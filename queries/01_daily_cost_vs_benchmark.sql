-- Title: Remittance Wars: Crypto vs. Western Union vs. Wise
-- Description: Compares the cost of sending $200 USD via USDT vs. Global Benchmarks.
-- Benchmarks Source: World Bank Remittance Prices Worldwide (Q1 2025)

WITH daily_eth_price AS (
    -- Step 1: Get daily ETH price to convert Gas to USD
    SELECT 
        DATE_TRUNC('day', minute) AS day,
        AVG(price) AS eth_price
    FROM prices.usd
    WHERE symbol = 'ETH'
    AND minute > NOW() - INTERVAL '6' month
    GROUP BY 1
),

usdt_transfers AS (
    -- Step 2: Get USDT transfers to calculate average gas usage
    SELECT 
        DATE_TRUNC('day', evt_block_time) AS day,
        gas_price,
        gas_used
    FROM erc20_ethereum.evt_Transfer t
    JOIN ethereum.transactions tx ON t.evt_tx_hash = tx.hash
    WHERE t.contract_address = 0xdac17f958d2ee523a2206206994597c13d831ec7 -- USDT Contract
    AND t.evt_block_time > NOW() - INTERVAL '6' month
)

-- Step 3: The Final Comparison Table
SELECT 
    t.day,
    
    -- METRIC 1: The "Digital" Competitor (Wise/Remitly)
    -- Benchmark: User specified Digital-Only MTO Index (3.5% of $200)
    7.00 AS digital_competitor_cost,

    -- METRIC 2: The "Traditional" Benchmark (Western Union/Banks)
    -- Benchmark: User specified Global Average (7% of $200)
    14.00 AS traditional_benchmark_cost,

    -- METRIC 3: The True Crypto Cost
    -- Formula: (Avg Gas Fee) + (Exchange Withdrawal Fee approx $1.50)
    (AVG(CAST(t.gas_used AS DOUBLE) * CAST(t.gas_price AS DOUBLE) / 1e18 * p.eth_price) + 1.50) AS crypto_total_cost

FROM usdt_transfers t
JOIN daily_eth_price p ON t.day = p.day
GROUP BY 1
ORDER BY 1 DESC;
