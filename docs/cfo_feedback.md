# CFO Critical Review: Stablecoin Remittance Analysis

**To:** Emerging Markets Strategy Team
**From:** CFO Office
**Date:** November 2025
**Subject:** Review of "Stablecoin Remittance" Proposal

I have reviewed your `project_reflection.md` and proposed queries. While the narrative is compelling, I have several critical concerns regarding the data interpretation and financial viability assumptions.

## 1. The "Mainnet" Fallacy (Cost Analysis)
You are benchmarking Ethereum Mainnet gas fees against Western Union.
*   **Critique:** This is a straw man argument. No retail user sends $200 on Mainnet paying $5-$10 in gas. They use Layer 2s (Base, Optimism) or Tron.
*   **Risk:** If you only analyze Mainnet, you will conclude "Crypto is too expensive" and kill a potentially viable product line that actually lives on L2s.
*   **Missing Data:** Where is the L2 analysis? If we can't query L2 data, this limitation must be bolded in red.

## 2. The "Remittance vs. Arbitrage" Confusion (Flow Analysis)
You propose a "North -> South" flow analysis using CEX addresses.
*   **Critique:** How do you distinguish a $500 remittance from a $500 arbitrage bot trade?
*   **Risk:** High volume does not mean high adoption. If 90% of the volume is bots, your "Remittance River" chart will look great but mean nothing for our retail strategy.
*   **Requirement:** Your "Retail Reality Check" (Histogram) is insufficient. It counts transfers but doesn't show the *weight* of capital. If 1,000 transfers are $100 (Retail) and 1 transfer is $10M (Whale), the "Total Volume" metric is useless for retail analysis without segmentation.

## 3. The "So What?" on Stablecoin Preference
You want to compare USDC vs. USDT.
*   **Critique:** Why does this matter for the P&L?
*   **Risk:** This feels like academic curiosity. Unless there is a specific cost or liquidity implication (e.g., "USDT has 50% lower spread in Nigeria"), this query adds noise, not signal.

---

## Required Improvements
1.  **Fix the Histogram:** Don't just show counts. Calculate the **% of Total Volume** that sits in the "Remittance Bucket" ($100-$1k). If it's <1%, we have a problem.
2.  **Address the L2 Gap:** Explicitly acknowledge the Mainnet limitation in the reflection document.
