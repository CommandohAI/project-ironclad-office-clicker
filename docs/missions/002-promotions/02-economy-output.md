Economy Output — Mission 002: Promotions

Context
- Current `WORK` reward: £1 per click (base).

1. Starting promotion cost
- Level 1 cost: £10

2. Cost scaling formula
- Use an exponential scaling: cost(level) = round( baseCost * scaleFactor^(level-1) )
- Recommended parameters: `baseCost = 10`, `scaleFactor = 1.6` (round to nearest whole £).

3. WorkPower increase per promotion
- Use a multiplicative per-level multiplier: per-click = baseWork * (multiplierPerLevel^level)
- Recommended parameter: `multiplierPerLevel = 1.2` (20% increase per purchased level). BaseWork is the existing £1 per click.

4. Suggested first 10 promotion costs (rounded to nearest £)
- Level 1: £10
- Level 2: £16
- Level 3: £26
- Level 4: £41
- Level 5: £66
- Level 6: £105
- Level 7: £168
- Level 8: £268
- Level 9: £429
- Level 10: £687

5. Suggested first 10 WorkPower values (per-click earnings, rounded to 2 decimals)
- Level 0 (no promotions): £1.00
- Level 1: £1.20
- Level 2: £1.44
- Level 3: £1.73
- Level 4: £2.07
- Level 5: £2.49
- Level 6: £2.99
- Level 7: £3.58
- Level 8: £4.30
- Level 9: £5.16
- Level 10: £6.19

6. Early-game pacing target
- Players should be able to buy the first promotion after ~10 WORK clicks (10 × £1 = £10), producing an immediate sense of progression.
- By level 3–4 (roughly 25–50 clicks if reinvesting), players should feel noticeably faster progression as per-click income crosses £2.
- This keeps the early loop quick and rewarding while costs ramp for mid-game.

7. What happens if the player cannot afford a promotion
- Purchases are disallowed server-side if the player has insufficient funds; the client may show the `Purchase` button as disabled and display "Insufficient funds." No negative balances or queued purchases.

8. Economy handoff task for Coding Agent
- Provide the Coding Agent with the following:
	- Constants to implement: `baseCost = 10`, `scaleFactor = 1.6`, `multiplierPerLevel = 1.2`, and `baseWork = 1`.
	- The cost table for levels 1–10 (as above) for initial testing.
	- Specification: currency stored as integer pennies (or smallest unit) if practical to avoid floating-point rounding; otherwise use numbers but round displayed values to 2 decimals.
	- Server-side validation: implement `RequestPurchasePromotion(playerId, promotionId)` to validate funds, deduct cost, increment level, persist data, and return updated money and multiplier.
	- Return values for UI: `{ success: bool, newMoney: number, newLevel: number, newPerClick: number, errorMessage?: string }`.

Notes
- Numbers are intentionally simple and front-loaded to make the early loop feel rewarding. The Economy Agent can iterate after playtesting if progression is too fast/slow.

# Economy Output

Pending mission output.
