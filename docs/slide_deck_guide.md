# 🚀 Refined 6-Slide Presentation Guide

This outline provides the exact text and content structure for your 6-slide presentation, incorporating all CFO feedback and focusing on the strategic narrative.

---

## Slide 1: Title & Context

| Component | Text / Visual |
| :--- | :--- |
| **Title** | **The Digital Remittance Bridge: Stablecoin Flows to the Global South** |
| **Subtitle** | A Data-Driven Assessment of Cost, Volume, and Liquidity Constraints |
| **Team/Date** | [Your Team Name] |
| **Speaker Note** | "Good morning. We assess whether stablecoins can truly disrupt the $700B remittance market, focusing on overcoming the key constraints of cost and local liquidity." |
| **Visual** | A clean graphic representing North-to-South flow (e.g., two icons connected by a digital bridge). |

---

## Slide 2: Executive Summary (The BLUF)

| Component | Text / Visual |
| :--- | :--- |
| **Headline** | **BLUF: Viability Confirmed, Strategy Refinement Required** |
| **Key Finding 1: Cost** | **Mainnet is Expensive, L2 is Viable.** L2s offer a theoretical cost of ~$0.51, validating the long-term financial model against the $7.00 digital benchmark. |
| **Key Finding 2: Volume** | **Filter the Noise, Find the Signal.** 90%+ of raw volume is institutional arbitrage. Retail Flow (<$1k) is the true KPI and shows early adoption. |
| **Key Finding 3: Liquidity** | **The South Runs on USDT.** A USDC-only strategy creates critical slippage barriers. We must support USDT to be competitive. |
| **Recommendation** | **Proceed with Pilot.** Launch an "L2-First" product supporting both USDC and USDT to match local market reality. |
| **Visual** | 3 Big Icon/Number Callouts for Cost, Volume, and Liquidity. |

---

## Slide 3: Constraint 1: The Cost Barrier & L2 Solution

| Component | Text / Visual |
| :--- | :--- |
| **Headline** | **Mainnet is the Ceiling. L2 is the Floor.** |
| **Visual** | **Line Chart** (From `queries/01_daily_cost_vs_benchmark.sql`). <br> Lines: **L2 Theoretical ($0.51)**, Crypto Mainnet (Variable), Digital Benchmark ($7.00). |
| **Insight 1** | **The Technology Works:** The L2 theoretical cost line consistently sits at ~$0.51, proving the core technology is financially superior to the $7.00 digital benchmark. |
| **Insight 2 (CFO Defense)** | **Critical Limitation:** Our current Mainnet data is skewed. High fees mean "Retail" users are often forced to use intermediaries. Ingesting L2 data is the immediate next step to fully validate the $0.51 cost thesis. |

---

## Slide 4: Constraint 2: Volume Signal & Economic Weight

| Component | Text / Visual |
| :--- | :--- |
| **Headline** | **Finding the Retail User: Signal vs. Economic Weight** |
| **Visual 1 (Top Half)** | **Side-by-Side Bar Chart** (From `queries/03_north_south_flows.sql`) <br> Bar A: Whale Volume (>$100k) (Noise) <br> Bar B: Retail Volume (<$1k) (Signal) |
| **Narrative 1** | **Filtering the Noise:** Raw volume is deceptive. 90% is 'Whale' arbitrage (Noise). We must focus solely on Retail Flow (<$1k) (Signal) to track remittance adoption. |
| **Visual 2 (Bottom Half)** | **Histogram** (From `queries/04_transfer_size_histogram.sql`) <br> Y-Axis: % of Total Volume (Economic Weight) |
| **Narrative 2** | **Validating the 'Little Guy':** The distinct cluster of activity in the $100-$1,000 range holds [Insert %] of the total economic volume. This validates that our target persona exists and transacts on-chain. |

---

## Slide 5: Constraint 3: The Liquidity Reality (The USDT Mandate)

| Component | Text / Visual |
| :--- | :--- |
| **Headline** | **The Liquidity Reality: Meeting the Market Where It Is** |
| **Visual** | **Bar Chart or Pie Chart** (From `queries/05_stablecoin_preference.sql`) <br> Comparison: USDT Volume vs USDC Volume in Global South corridors. |
| **Insight 1** | **Local Preference is USDT:** While we might prefer USDC, our analysis shows the Global South market prefers USDT by a [Insert Margin] margin. |
| **Insight 2** | **The Competitive Edge:** If we launch a USDC-only product, our users will pay high slippage and swap fees. We must support USDT to be a competitive remittance rail. |
| **Insight 3** | **Regional Breakdown:** Adoption is strongest in [Insert Top Receiving Region/Entity], which also shows the highest [USDT/USDC] preference. |

---

## Slide 6: Conclusion & Strategic Roadmap

| Component | Text / Visual |
| :--- | :--- |
| **Headline** | **Strategic Roadmap: Launching the L2-First Pilot** |
| **Summary** | We have a viable tech stack (L2s), a validated retail user base (filtered data), and clear product requirements (USDT support). |
| **Next Step 1: Data Expansion** | Ingest L2 data (Base/Optimism) immediately to fully validate the $0.51 cost thesis and identify L2-native retail flow. |
| **Next Step 2: Pilot Program** | Launch a small-scale corridor test (e.g., US -> [Top Region]) using the "L2-First" approach and mandated USDT support. |
| **Next Step 3: KPI Alignment** | Future reporting must use `retail_volume_usd` as the primary measure of success for this line of business. |
| **Visual** | A simple roadmap or checklist with check marks. |
