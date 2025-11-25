-- Title: Stablecoin Preference in the Global South
-- Description: Compares USDT vs USDC usage specifically for flows involving "Global South" entities.
-- Strategic Relevance: "Why does this matter?" (CFO Question). 
-- Answer: Liquidity dictates spreads. If the Global South uses USDT (90% share), then offering USDC-only products will fail due to high conversion costs (slippage).
-- We need to meet the market where the liquidity is.

WITH exchange_labels AS (
    -- Reuse the same manual mapping as before
    SELECT * FROM (VALUES
        -- GLOBAL NORTH
        (0x71660c4005ba85c37ccec55d0c4493e66fe775d3, 'Global North', 'Coinbase 1'),
        (0x503828976d22510aad0201ac7ec88293211d23da, 'Global North', 'Coinbase 2'),
        (0x267be1c1d684f78cb4f6a176c4911b741e4ffdc0, 'Global North', 'Kraken 1'),
        (0x55fe002aeff02f77364de339a1292923a15844b8, 'Global North', 'Circle (USDC Issuer)'),
        
        -- GLOBAL SOUTH
        (0x3f5ce5fbfe3e9af3971dd833d26ba9b5c936f0be, 'Global South', 'Binance 1'),
        (0xd551234ae421e3bcba99a0da6d736074f22192ff, 'Global South', 'Binance 2'),
        (0x5754284f345afc66a98fbb0a0a3883dc1c94364d, 'Global South', 'Bitso (LatAm)'),
        (0x0d0707963952f2fba59dd06f2b425ace40b492fe, 'Global South', 'Gate.io')
    ) AS t(address, region, entity_name)
),

stablecoin_contracts AS (
    SELECT * FROM (VALUES
        (0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48, 'USDC'),
        (0xdac17f958d2ee523a2206206994597c13d831ec7, 'USDT'),
        (0x6b175474e89094c44da98b954eedeac495271d0f, 'DAI')
    ) AS t(contract_address, symbol)
),

transfers AS (
    SELECT 
        t.contract_address,
        t."from" AS sender,
        t."to" AS receiver,
        CASE 
            WHEN t.contract_address = 0x6b175474e89094c44da98b954eedeac495271d0f THEN t.value / 1e18
            ELSE t.value / 1e6
        END AS amount_usd
    FROM erc20_ethereum.evt_Transfer t
    JOIN stablecoin_contracts sc ON t.contract_address = sc.contract_address
    WHERE evt_block_time > NOW() - INTERVAL '12' month
)

SELECT 
    sc.symbol,
    COUNT(*) AS transfer_count,
    SUM(t.amount_usd) AS total_volume_usd,
    AVG(t.amount_usd) AS avg_transfer_size
FROM transfers t
JOIN stablecoin_contracts sc ON t.contract_address = sc.contract_address
-- Join Labels
LEFT JOIN exchange_labels sender_label ON t.sender = sender_label.address
LEFT JOIN exchange_labels receiver_label ON t.receiver = receiver_label.address

WHERE 
    -- Filter: At least one side must be "Global South"
    sender_label.region = 'Global South' 
    OR receiver_label.region = 'Global South'

GROUP BY 1
ORDER BY 3 DESC;
