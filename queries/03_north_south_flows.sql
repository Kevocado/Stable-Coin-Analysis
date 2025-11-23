-- Title: Global North to Global South Stablecoin Flows
-- Description: Quantifies the volume of USDC, USDT, and DAI moving from "Global North" entities to "Global South" entities.
-- Note: Uses manual labeling of exchange addresses as a proxy for geography.

WITH exchange_labels AS (
    -- Step 1: Manual Geographic Mapping (Placeholder Data)
    -- In a real scenario, this would be a comprehensive table or joined with a labels dataset.
    SELECT * FROM (VALUES
        -- GLOBAL NORTH (US/Europe/Regulated)
        (0x71660c4005ba85c37ccec55d0c4493e66fe775d3, 'Global North', 'Coinbase 1'),
        (0x503828976d22510aad0201ac7ec88293211d23da, 'Global North', 'Coinbase 2'),
        (0x267be1c1d684f78cb4f6a176c4911b741e4ffdc0, 'Global North', 'Kraken 1'),
        (0x55fe002aeff02f77364de339a1292923a15844b8, 'Global North', 'Circle (USDC Issuer)'),
        
        -- GLOBAL SOUTH (LatAm/Africa/Asia/Offshore)
        (0x3f5ce5fbfe3e9af3971dd833d26ba9b5c936f0be, 'Global South', 'Binance 1'),
        (0xd551234ae421e3bcba99a0da6d736074f22192ff, 'Global South', 'Binance 2'),
        (0x5754284f345afc66a98fbb0a0a3883dc1c94364d, 'Global South', 'Bitso (LatAm)'),
        (0x0d0707963952f2fba59dd06f2b425ace40b492fe, 'Global South', 'Gate.io')
    ) AS t(address, region, entity_name)
),

stablecoin_contracts AS (
    -- Step 2: Define the tokens we care about
    SELECT * FROM (VALUES
        (0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48, 'USDC'),
        (0xdac17f958d2ee523a2206206994597c13d831ec7, 'USDT'),
        (0x6b175474e89094c44da98b954eedeac495271d0f, 'DAI')
    ) AS t(contract_address, symbol)
),

transfers AS (
    -- Step 3: Get all transfers for these tokens
    SELECT 
        DATE_TRUNC('month', evt_block_time) AS month,
        t.contract_address,
        t."from" AS sender,
        t."to" AS receiver,
        -- Normalize value to USD (approximate, assuming 1:1 peg for stablecoins)
        -- USDC/USDT have 6 decimals, DAI has 18
        CASE 
            WHEN t.contract_address = 0x6b175474e89094c44da98b954eedeac495271d0f THEN t.value / 1e18 -- DAI
            ELSE t.value / 1e6 -- USDC, USDT
        END AS amount_usd
    FROM erc20_ethereum.evt_Transfer t
    JOIN stablecoin_contracts c ON t.contract_address = c.contract_address
    WHERE evt_block_time > NOW() - INTERVAL '12' month
)

-- Step 4: The Final Analysis
SELECT 
    t.month,
    sc.symbol AS token,
    sender_label.region AS sending_region,
    receiver_label.region AS receiving_region,
    SUM(t.amount_usd) AS total_volume_usd,
    COUNT(*) AS transfer_count
FROM transfers t
-- Join to identify SENDER region
JOIN exchange_labels sender_label ON t.sender = sender_label.address
-- Join to identify RECEIVER region
JOIN exchange_labels receiver_label ON t.receiver = receiver_label.address
-- Join to get Token Symbol
JOIN stablecoin_contracts sc ON t.contract_address = sc.contract_address

WHERE 
    -- CORE FILTER: We only want flows FROM North TO South
    sender_label.region = 'Global North'
    AND receiver_label.region = 'Global South'

GROUP BY 1, 2, 3, 4
ORDER BY 1 DESC, 5 DESC;
