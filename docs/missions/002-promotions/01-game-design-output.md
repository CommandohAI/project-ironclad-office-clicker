Game Design Output — Mission 002: Promotions

1. Gameplay purpose
- Provide a simple, intuitive upgrade path that lets players spend earned money to increase the earnings they receive per `WORK` click. Promotions create a sense of progression and enable short-term goals for the first playable loop.

2. Player flow
- Player opens the Main UI and presses the existing `Promotions` button.
- Promotions UI (modal) appears showing available promotion tier(s), current player multiplier, player money, and a clear "Purchase" action for each tier.
- Player selects a promotion and confirms the purchase (optional confirm step configurable by the Coding Agent).
- On success: player money decreases, promotion level increases, and WORK earnings update immediately.
- On failure: show an informative message and prevent the purchase.

3. Promotion behaviour
- Structure: single linear progression of promotion levels (Level 1, Level 2, ...). Keep mechanics simple for first-playable.
- Effect: each promotion increases the per-click earnings by a multiplier (multiplicative stacking is allowed, but simplest is additive multiplier increments — e.g., +10% per level). Exact numbers are for the Economy Agent to supply.
- Limits: design for a soft cap (e.g., a maximum sensible multiplier or diminishing returns) to be defined by Economy Agent.
- Persistence: promotions must be persistent across sessions (handled by Coding Agent's PlayerDataService).

4. UI behaviour
- Entry: existing `Promotions` button opens a modal centered on screen.
- Contents: show a concise header, player's current money, a list or single tile for promotion with:
	- Tier name and icon
	- Current owned level
	- Current per-click multiplier (or display interpreted value like "+10% earnings")
	- Next-level cost
	- `Purchase` button (or `Maxed` / `Owned` when not applicable)
- Feedback: on purchase success, play a short visual cue (e.g., green flash, increment animation) and update the displayed multiplier and player money instantly.
- Accessibility: buttons should be keyboard-focusable and include text labels.

5. What should happen when the player cannot afford a promotion
- The `Purchase` button is disabled and shows a tooltip or inline message: "Insufficient funds".
- If the player attempts purchase via other input, show a brief non-blocking toast: "You don't have enough money to buy this promotion." Do not crash or allow negative currency.

6. Acceptance criteria
- Promotions UI opens from the existing `Promotions` button.
- Promotions show current player money, current multiplier, next cost, and purchase afford/disabled state.
- Purchasing deducts the correct cost and increases earnings per `WORK` click immediately.
- Disabled purchases cannot be performed and show clear feedback when attempted.
- Promotion levels persist across sessions (Coding Agent to implement persistence). QA must verify with a local server test.

7. Handoff task for Economy Agent
- Deliver a cost and effect table for promotion levels, e.g.:
	- For each level N: `cost`, `multiplier_increase` (percent or factor), and any pacing notes.
	- Provide the starting per-click base value and target mid-game per-click value to guide scaling.
	- Recommend a soft cap or diminishing-return curve if appropriate.
	- Indicate whether costs should be linear, exponential, or custom.

8. Handoff task for Coding Agent
- Requirements and non-implementation details:
	- Server-authoritative purchase flow: endpoint `RequestPurchasePromotion(playerId, promotionId)` that validates funds, applies cost, increments level, persists change, and returns success/failure with updated player money and multiplier.
	- Events/hooks: `PromotionPurchased(playerId, promotionId, newLevel)`, and `GetPlayerPromotionData(playerId)` to fetch current level and multiplier.
	- UI contract: expected JSON for promotions list: `{ id, name, icon, ownedLevel, nextCost, currentMultiplier, maxLevel? }`.
	- Client behaviour: UI should not perform final validation — it may only pre-check affordability for UX; final validation must be server-side.
	- Persistence: Coding Agent should store promotion level in `PlayerDataService` and load on player join.
	- Confirmations: implement an optional confirmation dialog (configurable) before performing server call.

Notes
- Keep the initial implementation minimal: one promotion track with clear, testable effects is better than multiple complex systems.
- Do not include numeric balancing in this document — hand that to the Economy Agent.

# Game Design Output

Pending mission output.
