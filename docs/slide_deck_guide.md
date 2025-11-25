# Slide Deck Guide: Stablecoin Remittance Analysis

**Persona:** Emerging Markets Analyst
**Audience:** CFO & Strategy Team
**Goal:** Prove that stablecoins are a viable remittance rail *if* we navigate the specific constraints of cost and liquidity.

---

## Slide 1: Title & Context
*   **Title:** "The Digital Remittance Bridge: Analyzing Stablecoin Flows to the Global South"
*   **Subtitle:** A Data-Driven Assessment of Cost, Volume, and Liquidity
*   **Team:** [Your Team Name]
*   **Visual:** A clean, high-level graphic or logo.
*   **Speaker Note:** "Good morning. Today we are presenting our analysis on whether stablecoins can truly disrupt the $700B remittance market, specifically focusing on flows from the Global North to the Global South."

---

## Slide 2: Executive Summary (The "BLUF")
*   **Key Findings:**
    1.  **Cost:** Mainnet is too expensive ($2-$10), but L2s offer a theoretical cost of $0.51, beating the $7.00 digital benchmark.
    2.  **Volume:** "True Remittance" (Retail <$1k) is present but obscured by massive institutional arbitrage. We must filter the noise.
    3.  **Liquidity:** The Global South runs on USDT. A USDC-only strategy will fail due to slippage.
*   **Recommendation:** **Proceed with Pilot.** Launch a "L2-First" product on Optimism/Base, supporting USDT to match local liquidity depth.
*   **Visual:** 3 Big Numbers or Icons representing Cost, Volume, Liquidity.

---

## Slide 3: Methodology & Critical Limitations
*   **Data Source:** Ethereum Mainnet (Dune Analytics).
*   **Timeframe:** Last 6-12 Months.
*   **Geographic Proxy:** CEX Labels (Coinbase/Kraken = North; Binance LatAm/Bitso = South).
*   **CRITICAL LIMITATION (The "CFO Defense"):**
    *   *Text:* "**Data Gap:** Analysis is limited to Ethereum Mainnet. High fees skew the 'Retail' picture. L2 data is the next required step."
    *   *Why:* This preempts the "Gas is too high" objection.
*   **Visual:** A simple process flow: `Raw Data -> Geo-Labeling -> Noise Filtering -> Insight`.

---

## Slide 4: The Cost Barrier (And the L2 Solution)
*   **Headline:** "Mainnet is the Ceiling. L2 is the Floor."
*   **Visual:** **Line Chart** from `queries/01_daily_cost_vs_benchmark.sql`.
    *   *Lines:* Traditional ($14), Digital ($7), Crypto Mainnet (Variable), L2 Theoretical ($0.51).
*   **Insight:** "While Mainnet (Blue) often breaches the $7 viability line, the L2 alternative (Green) consistently sits at ~$0.51. This proves the *technology* works, even if the *network* (Mainnet) is currently premium."

---

## Slide 5: The "True" Remittance Flow
*   **Headline:** "Filtering the Noise: Finding the Retail User"
*   **Visual:** **Stacked Bar Chart** or **Side-by-Side Bars** from `queries/03_north_south_flows.sql`.
    *   *Series:* Whale Volume (>$100k) vs. Retail Volume (<$1k).
*   **Insight:** "If we look at raw volume, it looks like billions. But 90% of that is 'Whale' arbitrage (Grey). When we filter for 'Retail' flows (Blue), we see the actual remittance adoption curve. It's smaller, but it's the signal we need to track."

---

## Slide 6: Validating the User Base
*   **Headline:** "The Economic Weight of the 'Little Guy'"
*   **Visual:** **Histogram (Bar Chart)** from `queries/04_transfer_size_histogram.sql`.
    *   *X-Axis:* Transfer Size Buckets.
    *   *Y-Axis:* **% of Total Volume** (Not just count!).
*   **Insight:** "This chart answers the 'So What?'. We see a distinct cluster of activity in the $100-$1,000 range. These aren't bots; these are people paying rent and sending money home. This validates our target persona exists on-chain."

---

## Slide 7: The Liquidity Reality (USDT vs USDC)
*   **Headline:** "Meeting the Market Where It Is"
*   **Visual:** **Bar Chart or Pie Chart** from `queries/05_stablecoin_preference.sql`.
    *   *Comparison:* USDT Volume vs USDC Volume in Global South corridors.
*   **Insight:** "While we might prefer USDC for regulatory reasons, the Global South prefers USDT by a wide margin. If we launch a USDC-only product, our users will pay 1-2% in swap fees. We must support USDT to be competitive."

---

## Slide 8: Conclusion & Next Steps
*   **Summary:** We have a viable tech stack (L2s), a visible retail user base (filtered data), and a clear product requirement (USDT support).
*   **Next Steps:**
    1.  **Expand Data:** Ingest L2 data (Base/Optimism) to validate the $0.51 cost thesis.
    2.  **Pilot Program:** Launch a small-scale corridor test (e.g., US -> Mexico) using the "Retail" parameters defined here.
*   **Visual:** A roadmap graphic or checklist.

---

## Appendix: SQL Queries
*   Include screenshots of your 4-5 key queries with comments explaining the logic.
