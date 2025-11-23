# Research Notes & Benchmarks

## 1. The Benchmark (Traditional Finance)
* **Global Average Cost:** ~6.49% to send $200 (World Bank Q4 2024).
* **Digital-Only Benchmark:** ~3.55% (e.g., Wise/Remitly).
* **Target:** Our solution must be consistently cheaper than $7.10 (3.55% of $200) to be viable.

## 2. The Stablecoin Choice (USDT)
* **Asset:** Tether (USDT).
* **Rationale:** Highest liquidity in emerging markets (Asia, LatAm, Africa) compared to USDC, which is more US-institutional.

## 3. The "Apples-to-Apples" Cost Formula
We cannot just compare Gas vs. Western Union. We must use:
> Total Crypto Cost = Gas Fee (Sender) + Exchange Fee (0.1%) + Off-Ramp Fee (~$1-$3)

## 4. Benchmark Data Sources (Verified)
* **Digital Competitor Index:** 3.55% (World Bank Q1 2025 Digital-Only MTO Index).
* **Global Average:** 6.49% (World Bank Q1 2025 Global Average).
* **Comparison Math:**
  * $200 * 6.49% = $12.98 (Easy to beat).

## 5. Geographic & Entity Attribution Strategy
* **The Challenge:** Blockchain addresses are pseudonymous and have no inherent GPS location.
* **Proxy Method 1: Time of Day Analysis**
    * *Logic:* Retail users transact during their waking hours (9 AM - 9 PM local).
    * *Asia Window:* 00:00 - 08:00 UTC (Morning/Afternoon in Asia).
    * *Americas Window:* 13:00 - 21:00 UTC (Morning/Afternoon in LatAm/US).
* **Proxy Method 2: Exchange Labeling**
    * We can track flows into "Deposit Addresses" of exchanges popular in specific regions.
    * *LatAm:* Bitso, Mercado Bitcoin.
    * *Africa:* Luno, Yellow Card (if labeled), Binance (Global).
    * *Asia:* OKX, Binance, Upbit.
* **Reference to Reflection:** This directly answers "The Entities" question by attempting to map on-chain flows to real-world geography.

## 6. The "Big vs. Small" Economy Lens (Africa Focus)
* **The Goal:** Contrast "Global North" institutional trading (US/Asia) vs. "Global South" utility usage (Africa/LatAm).
* **The "Africa Window" (08:00 - 14:00 UTC):**
    * This slot overlaps with London/Europe markets, BUT...
    * High volume here *relative to GDP* suggests strong adoption.
    * **Key Insight:** If we see high transaction counts but lower average value in this window, it signals "Retail/Remittance" (Africa) rather than "Institutional Trading" (London).
* **Hypothesis:** 
    * **Asia/US:** High Volume, High Avg Value (Whales/Traders).
    * **Africa/LatAm:** High Transaction Count, Low Avg Value (Real Users).
