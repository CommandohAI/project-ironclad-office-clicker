# 02-economy-output.md

First rebirth money requirement
- Set the first rebirth threshold at 10,000 money.
- This keeps the goal meaningful but reachable after a few minutes of normal play with work, promotions, and workers.

Requirement scaling formula for future rebirths
- Use a simple exponential progression: next requirement = current requirement * 2.
- This gives the first few rebirths reasonable milestones while ensuring each reset feels harder than the last.
- Example: 10,000 → 20,000 → 40,000 → 80,000 → 160,000.

Prestige reward per rebirth
- Award 1 Prestige point for each rebirth.
- Keep the reward flat for the first version to simplify tracking and balance.

Prestige bonus formula
- Apply a permanent +1% earnings bonus per Prestige point.
- The bonus multiplies both click earnings and passive worker income.
- Formula: earnings multiplier = 1 + (Prestige * 0.01).
- Example: 5 Prestige gives +5% total earnings.

What values reset on rebirth
- Current Money resets to 0.
- PromotionLevel resets to the base starting promotion tier.
- WorkPower resets to the base starting click power.
- WorkerCount resets to 0.
- Any current-run progression gains are cleared.

What values persist after rebirth
- Total Prestige / Corporate Influence points.
- Prestige bonus multiplier.
- Saved player progress including Prestige data.
- Any non-run meta state needed for future runs.

Suggested first 5 rebirth requirements
1. 10,000
2. 20,000
3. 40,000
4. 80,000
5. 160,000

Suggested first 5 prestige bonus values
- Rebirth 1: 1 Prestige → +1% earnings
- Rebirth 2: 2 Prestige → +2% earnings
- Rebirth 3: 3 Prestige → +3% earnings
- Rebirth 4: 4 Prestige → +4% earnings
- Rebirth 5: 5 Prestige → +5% earnings

Economy risks
- Prestige bonus may feel weak if early progression is too slow, so keep base work and passive income growth healthy.
- If rebirth scaling is too steep, players may abandon the system; the 2x formula should be tested and adjusted if early rebirths feel unreachable.
- If Prestige bonuses stack too high later, they could accelerate progression excessively. Keep the bonus additive and modest for the first version.

Economy handoff task for Coding Agent
- Implement the rebirth threshold and eligibility check using the first requirement values.
- Ensure Prestige is stored, loaded, and applied as an earnings multiplier on both click and passive income.
- Use the simple reset rules: money, promotions, work power, and workers reset while Prestige persists.
- Expose current requirement, current Prestige, and earned bonus to the UI so the player can see value clearly.
