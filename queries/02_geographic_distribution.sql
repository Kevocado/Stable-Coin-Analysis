-- Title: Geographic Proxy: When do "Retail" Users Move Money?
-- Description: Analyzes hourly transaction patterns to estimate if USDT usage is dominated by Asia, Europe, or the Americas.

WITH transfer_hours AS (
    SELECT 
        EXTRACT(HOUR FROM evt_block_time) AS hour_of_day_utc,
        value / 1e6 AS amount_usd,
        evt_tx_hash
    FROM erc20_ethereum.evt_Transfer
    WHERE contract_address = 0xdac17f958d2ee523a2206206994597c13d831ec7 -- USDT
    AND evt_block_time > NOW() - INTERVAL '3' month
    
    -- REFINEMENT 1: The "Goldilocks" Filter
    -- We exclude >$1,000 (Whales/Institutions) AND <$10 (Spam/Dust/Airdrops)
    -- This isolates the "Remittance" signal: people sending $100-$500.
    AND value / 1e6 < 1000 
    AND value / 1e6 > 10 
),

hourly_stats AS (
    SELECT 
        hour_of_day_utc,
        COUNT(*) AS tx_count,
        AVG(amount_usd) AS avg_size_usd
    FROM transfer_hours
    GROUP BY 1
),

total_volume AS (
    SELECT SUM(tx_count) as total_txs FROM hourly_stats
)

SELECT 
    h.hour_of_day_utc,
    h.tx_count,
    h.avg_size_usd,
    
    -- REFINEMENT 2: Percentage Share
    -- This answers: "What % of global retail traffic happens in this hour?"
    (CAST(h.tx_count AS DOUBLE) / t.total_txs) * 100 AS pct_share_of_day,

    -- REFINEMENT 3: Narrative-Driven Regions
    CASE 
        -- Asia Day / US Night (00:00 - 08:00 UTC)
        -- Key Corridor: UAE -> India / Philippines (huge remittance flow)
        WHEN h.hour_of_day_utc BETWEEN 0 AND 7 THEN 'Asia & Middle East (Dubai/India Focus)'
        
        -- Europe Day / Asia Evening (08:00 - 13:00 UTC)
        -- Key Corridor: UK -> Africa / Europe Trading
        WHEN h.hour_of_day_utc BETWEEN 8 AND 13 THEN 'EMEA (Europe/Africa Working Hours)'
        
        -- The "Golden Overlap" (13:00 - 16:00 UTC)
        -- London is closing, New York is opening. Highest liquidity.
        WHEN h.hour_of_day_utc BETWEEN 14 AND 16 THEN 'Atlantic Bridge (Europe/US Overlap)'
        
        -- Americas Day / Asia Night (17:00 - 23:00 UTC)
        -- Key Corridor: US -> Mexico / LatAm (The largest corridor in the world)
        ELSE 'Americas (US -> LatAm Focus)'
    END AS region_proxy

FROM hourly_stats h
CROSS JOIN total_volume t
ORDER BY 1 ASC;