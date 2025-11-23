-- Title: Geographic Distribution Proxy (Time of Day Analysis)
-- Description: Buckets USDT transfers by UTC hour to estimate geographic usage patterns (Asia vs. Americas).
-- Note: This is a proxy. We assume "Retail" users transact during their local waking hours.

WITH transfer_hours AS (
    SELECT 
        EXTRACT(HOUR FROM evt_block_time) AS hour_of_day_utc,
        value / 1e6 AS amount_usd, -- USDT has 6 decimals
        evt_tx_hash
    FROM erc20_ethereum.evt_Transfer
    WHERE contract_address = 0xdac17f958d2ee523a2206206994597c13d831ec7 -- USDT
    AND evt_block_time > NOW() - INTERVAL '3 months'
    -- Filter for "Remittance Sized" transactions to reduce bot noise
    AND value / 1e6 < 1000 
)

SELECT 
    hour_of_day_utc,
    COUNT(*) AS tx_count,
    AVG(amount_usd) AS avg_size_usd,
    
    -- Geographic Mapping (Approximate)
    CASE 
        -- Big Economies (Global North)
        WHEN hour_of_day_utc BETWEEN 0 AND 8 THEN 'Asia (China/Korea/Japan) - Big Econ'
        WHEN hour_of_day_utc BETWEEN 14 AND 22 THEN 'Americas (US/Canada/LatAm) - Mixed'
        
        -- Emerging / Smaller Economies Focus
        WHEN hour_of_day_utc BETWEEN 8 AND 14 THEN 'EMEA (Europe & Africa) - Key Remittance Window'
        
        ELSE 'Pacific / Mixed'
    END AS region_category,
    
    CASE
        WHEN hour_of_day_utc BETWEEN 8 AND 14 THEN 'Africa Focus'
        ELSE 'Global Macro'
    END AS analysis_focus
    
FROM transfer_hours
GROUP BY 1, 4
ORDER BY 1 ASC;
