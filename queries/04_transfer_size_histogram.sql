-- Title: The "Retail Reality" Check (Transfer Size Histogram)
-- Description: Buckets stablecoin transfers by size to validate "remittance" behavior (expected peak at $200-$1,000).

WITH stablecoin_contracts AS (
    SELECT * FROM (VALUES
        (0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48, 'USDC'),
        (0xdac17f958d2ee523a2206206994597c13d831ec7, 'USDT'),
        (0x6b175474e89094c44da98b954eedeac495271d0f, 'DAI')
    ) AS t(contract_address, symbol)
),

transfers AS (
    SELECT 
        t.evt_tx_hash,
        sc.symbol,
        -- Normalize value to USD
        CASE 
            WHEN t.contract_address = 0x6b175474e89094c44da98b954eedeac495271d0f THEN t.value / 1e18 -- DAI
            ELSE t.value / 1e6 -- USDC, USDT
        END AS amount_usd
    FROM erc20_ethereum.evt_Transfer t
    JOIN stablecoin_contracts sc ON t.contract_address = sc.contract_address
    WHERE evt_block_time > NOW() - INTERVAL '3' month
)

WITH bucket_stats AS (
    SELECT 
        symbol,
        CASE 
            WHEN amount_usd < 10 THEN '1. Micro (<$10)'
            WHEN amount_usd >= 10 AND amount_usd < 100 THEN '2. Small ($10-$100)'
            WHEN amount_usd >= 100 AND amount_usd < 500 THEN '3. Remittance Low ($100-$500)'
            WHEN amount_usd >= 500 AND amount_usd < 1000 THEN '4. Remittance High ($500-$1k)'
            WHEN amount_usd >= 1000 AND amount_usd < 10000 THEN '5. Commercial ($1k-$10k)'
            WHEN amount_usd >= 10000 AND amount_usd < 100000 THEN '6. Institutional ($10k-$100k)'
            ELSE '7. Whale (>$100k)'
        END AS size_bucket,
        COUNT(*) AS transfer_count,
        SUM(amount_usd) AS total_volume
    FROM transfers
    GROUP BY 1, 2
),

total_stats AS (
    SELECT symbol, SUM(transfer_count) as total_txs, SUM(total_volume) as global_volume
    FROM bucket_stats
    GROUP BY 1
)

SELECT 
    b.symbol,
    b.size_bucket,
    b.transfer_count,
    b.total_volume,
    -- IMPROVEMENT: Calculate Share of Activity
    (CAST(b.transfer_count AS DOUBLE) / t.total_txs) * 100 AS pct_of_txs,
    (b.total_volume / t.global_volume) * 100 AS pct_of_volume
FROM bucket_stats b
JOIN total_stats t ON b.symbol = t.symbol
ORDER BY 1, 2;
