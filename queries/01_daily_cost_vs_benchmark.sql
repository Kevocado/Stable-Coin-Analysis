-- Title: Average Gas Fee for USDT Transfers vs World Bank Benchmark
-- Description: Calculates the daily average gas cost in USD to send USDT and compares it to a 6.5% remittance fee.

SELECT
    DATE_TRUNC('day', evt_block_time) AS day,
    AVG(tx.gas_used * tx.gas_price / 1e18 * p.price) AS avg_fee_usd,
    6.5 AS world_bank_benchmark -- Flat line for comparison ($13.00 for a $200 transfer is 6.5%)
FROM erc20_ethereum.evt_Transfer t
JOIN ethereum.transactions tx ON t.evt_tx_hash = tx.hash
LEFT JOIN prices.usd p ON p.minute = DATE_TRUNC('minute', evt_block_time)
WHERE t.contract_address = 0xdac17f958d2ee523a2206206994597c13d831ec7 -- USDT Contract Address
AND p.symbol = 'ETH' -- We need ETH price to calculate gas cost in USD
AND t.evt_block_time > NOW() - INTERVAL '3 months'
GROUP BY 1
ORDER BY 1 DESC;
