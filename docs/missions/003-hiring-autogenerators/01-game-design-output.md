# 01-game-design-output.md

## 1. Gameplay purpose
Hiring introduces a passive income loop that complements the existing WORK clicker. It gives the player a new way to earn money over time, reward progression beyond active clicking, and create a simple upgrade path for the early game.

## 2. Player flow
1. Player opens the main game UI.
2. Player presses the existing Hiring button.
3. The Hiring panel opens and displays at least one worker type with cost, count, and income per second.
4. Player selects a worker and purchases it if they have enough money.
5. The worker count increases, the player's money decreases by the cost, and passive income begins generating automatically every second.
6. Player can close the Hiring panel and continue working or return later to hire more workers.

## 3. Hiring behaviour
- The Hiring button toggles the Hiring panel open and closed.
- Only one Hiring panel is needed for first-version scope.
- Each worker purchase deducts the worker cost from the player's current money immediately.
- If the player cannot afford a worker, the buy option is disabled or clearly marked as unavailable.
- The worker cost should be visible in the panel and update if any simple scaling is used.

## 4. Worker behaviour
- Workers generate passive money every second.
- Each owned worker contributes a fixed amount of income per second.
- Worker income accumulates in the player’s money automatically without further interaction.
- The worker count is tracked and shown in the Hiring panel.
- For the first version, a single worker tier is sufficient, for example “Junior Worker” or “Office Assistants.”

## 5. UI behaviour
- The main UI Hiring button opens and closes the Hiring panel.
- The Hiring panel shows:
  - worker name
  - current worker count owned
  - purchase cost
  - income per worker per second
  - total income per second from that worker type
  - a buy button for each worker type
- The panel updates in real time as the player gains money, buys workers, or earns passive income.
- The buy button is disabled when the player cannot afford the worker.
- The current player money should remain visible while the panel is open.

## 6. What should happen when the player cannot afford a worker
- The worker buy button must be disabled or visually marked as unavailable.
- The UI should not allow the purchase to proceed.
- If the player attempts to buy with insufficient funds, the game should provide clear feedback such as a disabled button or a small message like “Not enough money.”
- No money should be deducted and no worker should be added.

## 7. Acceptance criteria
- The Hiring button opens and closes the Hiring panel.
- The Hiring panel shows at least one worker type with count, cost, and passive income per second.
- Players can purchase workers only when they have enough money.
- Purchased workers increase the worker count and deduct the correct amount of money.
- Passive income from workers adds to the player’s money every second.
- The UI updates immediately when money changes or new workers are bought.
- Insufficient funds prevent purchases and show clear disabled/unavailable feedback.

## 8. Handoff task for Economy Agent
- Propose base worker cost and income values for the first worker tier.
- Provide a simple progression rule if pricing should scale after each purchase (for example, cost increase per worker).
- Recommend a passive income rate that complements existing WORK earnings and promotions without overpowering click rewards in this first version.
- Supply the exact numeric values and any simple scaling formula the Coding Agent should use.

## 9. Handoff task for Coding Agent
- Implement the Hiring panel toggle and worker purchase UI updates.
- Add a worker purchase flow that checks player money, deducts cost, increments worker count, and starts passive income generation.
- Ensure passive income is added every second and updates the player's displayed money.
- Ensure the buy button is disabled when the player cannot afford the worker.
- Keep the system simple, with a first-version single worker tier and no saving or monetisation logic.
