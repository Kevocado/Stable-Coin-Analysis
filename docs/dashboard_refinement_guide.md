# Dashboard Refinement Guide (CFO Feedback Edition)

Based on the CFO's feedback, we have updated the underlying SQL queries. Here is how to update your dashboard visualizations to tell a more accurate and defensible story.

## 1. The Cost Chart (Line Chart)
*   **Update:** We added `l2_theoretical_cost` ($0.51) to `queries/01_daily_cost_vs_benchmark.sql`.
*   **Action:** Add this new column as a **Line** on your chart.
*   **Narrative:** "While Mainnet (Blue Line) is often above the $7.00 Digital Benchmark, L2s (New Green Line) offer a theoretical cost of ~$0.51, proving the long-term viability of the technology."

## 2. The North-South Flow Charts (Bar Charts)
*   **Update:** We added `retail_volume_usd` (<$1k) and `whale_volume_usd` (>$100k) to `queries/03_north_south_flows.sql`.
*   **Action:**
    *   **Duplicate** your existing "Monthly Volume" chart.
    *   **Chart A (The Noise):** Plot `whale_volume_usd`. Label it "Institutional Arbitrage".
    *   **Chart B (The Signal):** Plot `retail_volume_usd`. Label it "True Remittance Flow".
*   **Narrative:** "When we filter out the institutional noise (Chart A), we see the true retail adoption curve (Chart B), which is the KPI that actually matters for our strategy."

## 3. The Histogram (Bar Chart)
*   **Update:** `queries/04_transfer_size_histogram.sql` now calculates `pct_of_volume`.
*   **Action:** Change the Y-Axis from `transfer_count` (which is dominated by dust) or `total_volume` (dominated by whales) to `pct_of_volume`.
*   **Narrative:** "This view shows the 'Economic Weight' of each segment. If the 'Remittance Bucket' ($100-$1k) holds 20% of the volume, that is a massive success. If it's 0.1%, we are purely a speculative asset."
