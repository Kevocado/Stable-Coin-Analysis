# Project Reflection: Stablecoin Remittance Analysis

**Role:** Emerging Markets Analyst
**Organization:** International Development Organization / Fintech Strategy Team
**Mission:** Investigate if stablecoins are a viable alternative to traditional remittance rails (Western Union/MoneyGram/Remitly) for the Global South.

---

## 1. The Core Business Question
**"Can we quantify the net capital flow from 'Global North' domiciled exchanges (e.g., Coinbase, Kraken) to 'Global South' domiciled exchanges (e.g., Binance LatAm, Bitso) using on-chain stablecoin transfer data as a proxy for cross-border remittance?"**

### Why this refinement?
*   **Specific & Measurable:** Moves from vague "adoption" to concrete **net capital flow** between entities.
*   **Technically Feasible:** Uses **Exchanges (CEXs)** as geographic proxies, overcoming wallet pseudonymity.
*   **Hypothesis-Driven:** Tests the "Remittance" narrative: Capital moves *from* wealthy nations *to* emerging markets.

---

## 2. Key Metrics & Benchmarks

### The Cost Test ($200 Remittance)
We compare the cost of sending $200 via Stablecoins vs. Traditional Rails.
*   **Traditional Benchmark (7%):** **$14.00** (Western Union, MoneyGram, Banks).
*   **Digital Benchmark (3.5%):** **$7.00** (Wise, Remitly).
*   **Crypto Cost:** Gas Fee + ~$1.50 Off-ramp Fee.
*   *Goal:* Crypto must consistently stay below $7.00 to be competitive with modern fintech, not just expensive banks.

### The Flow Test
*   **Assets:** USDC, USDT, DAI.
*   **Geographic Proxy:**
    *   **Global North:** Coinbase, Kraken, Circle, Uniswap.
    *   **Global South:** Bitso, Binance LatAm, Yellow Card, Tron-heavy wallets.
*   **Metric:** Monthly Volume (USD) sent from [North Group] -> [South Group].

### Risks & Mitigations (CFO Feedback)
*   **The Mainnet Premium:** Ethereum Mainnet gas fees ($2-$10) are often prohibitive for $200 remittances.
    *   *Mitigation:* This analysis establishes a "Worst Case" cost baseline. Future work must analyze L2s (Base, Optimism) where fees are <$0.10.
*   **Arbitrage Noise:** High volume flows may be institutional arbitrage, not retail remittance.
    *   *Mitigation:* We use the **Transfer Size Histogram** to filter out "Whale" activity and focus only on the "Remittance Bucket" ($100-$1,000) share of volume.

---

## 3. Analyst Recommendations: Queries & Visualizations

To fully validate this thesis, we need the following data artifacts:

### A. Queries
1.  **`01_daily_cost_vs_benchmark.sql`**: (Completed) Tracks daily crypto cost vs the $7.00 and $14.00 benchmarks.
2.  **`02_geographic_distribution.sql`**: (Completed) Uses time-of-day analysis to estimate regional activity (Asia vs Americas).
3.  **`03_north_south_flows.sql`**: (Completed) Quantifies direct volume from North Exchanges to South Exchanges.
4.  **[PROPOSED] `04_transfer_size_histogram.sql`**:
    *   *Purpose:* Validate "Remittance" behavior. Are flows mostly $200-$1,000 (Remittance) or $10k+ (B2B/Speculation)?
    *   *Hypothesis:* True remittance corridors will have a high density of <$1,000 transfers.
5.  **[PROPOSED] `05_stablecoin_preference.sql`**:
    *   *Purpose:* Compare USDT vs USDC usage in Global South flows.
    *   *Hypothesis:* Global South prefers USDT (liquidity), Global North prefers USDC (regulation).

### B. Visualizations (Dashboard Concept)
1.  **The "Remittance Gap" Chart (Line Chart)**
    *   **X-Axis:** Date (Last 6 Months)
    *   **Y-Axis:** Cost ($)
    *   **Lines:** Traditional ($14), Digital ($7), Crypto Cost (Variable).
    *   *Insight:* Highlight days where Crypto < $7.00 (The "Win Zone").

2.  **The "North-South" River (Sankey or Stacked Bar)**
    *   **Visual:** Flow of funds from North Entities -> South Entities.
    *   *Insight:* Is the volume growing? Is it dominated by one specific corridor (e.g., Coinbase -> Bitso)?

3.  **The "Retail Reality" Check (Histogram)**
    *   **X-Axis:** Transfer Size Log Scale ($10, $100, $1k, $10k).
    *   **Y-Axis:** Frequency.
    *   *Insight:* If the peak is at $100k, it's not remittance. We want to see a peak at $200-$500.
    * Test
