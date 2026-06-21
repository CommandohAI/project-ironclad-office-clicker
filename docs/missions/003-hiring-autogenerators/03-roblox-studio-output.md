# 03-roblox-studio-output.md

## 1. Required UI behaviour
- The existing Hiring button toggles a Hiring panel open and closed.
- The Hiring panel must remain visible while open and close cleanly when the button is pressed again.
- The Hiring panel updates in real time as the player’s money changes.
- The buy button for each worker type is enabled only when the player can afford the current cost.

## 2. Required Explorer structure
- `StarterGui/MainUI` should contain the Hiring button already.
- Add a `HiringPanel` Frame under `StarterGui/MainUI` or an existing panel container.
- Inside `HiringPanel`, include a `WorkerEntry` container for the worker type.
- `WorkerEntry` should contain labels for Name, Count, Cost, IncomePerSecond, and a Buy button.

## 3. Required buttons, labels, frames, and visual elements
- Button: `HiringButton` (already exists) to toggle the panel.
- Frame: `HiringPanel` to hold the hiring UI.
- TextLabel: `WorkerNameLabel` showing the worker name.
- TextLabel: `WorkerCountLabel` showing how many workers are owned.
- TextLabel: `WorkerCostLabel` showing the current cost to hire the next worker.
- TextLabel: `WorkerIncomeLabel` showing income per worker per second and total income/sec.
- Button: `BuyWorkerButton` to purchase a worker.
- Optional TextLabel: `AffordabilityLabel` or button disabled state to indicate insufficient funds.

## 4. What happens when the player presses the Hiring button
- If the Hiring panel is closed, it opens and becomes visible.
- If the Hiring panel is open, it closes and becomes invisible.
- When open, the panel shows the current worker count, next cost, and current income/sec.
- The existing main game UI remains visible behind or alongside the panel.

## 5. What happens when the player buys a worker
- The UI sends a request to the server to purchase the worker.
- If the purchase succeeds:
  - `WorkerCountLabel` increments.
  - `WorkerCostLabel` updates to the next scaled cost.
  - `WorkerIncomeLabel` updates to show the new total passive income per second.
  - The player’s money display updates immediately.
  - The `BuyWorkerButton` may become disabled if the player no longer can afford the next purchase.

## 6. What happens when the player cannot afford a worker
- The `BuyWorkerButton` is disabled or visually unavailable.
- The panel should show a clear affordability indicator, such as greying out the buy button or a small message `Not enough money`.
- No purchase request should succeed when funds are insufficient.

## 7. How passive income should appear/update
- Passive income does not need its own visual effect beyond the money display updating.
- The `WorkerIncomeLabel` should show current total passive income per second, e.g. `+1/sec` or `+5/sec`.
- The main money display should increase automatically once per second as workers generate income.
- If the Hiring panel is visible, the displayed money and income labels should refresh each second.

## 8. What the Commander should see after implementation
- The Hiring button opens a functional Hiring panel.
- The Hiring panel shows a worker entry with name, current count, current cost, and income per second.
- The Buy button correctly enables/disables based on available money.
- Buying a worker updates the count, cost, passive income, and money display.
- Passive income increases the player’s money over time without additional clicks.

## 9. Roblox Studio test steps
1. Open the place in Roblox Studio and run a local test.
2. Confirm the Hiring button is visible in the Main UI.
3. Press the Hiring button and verify the Hiring panel opens.
4. Check that the panel displays worker name, count, cost, income per second, and a buy button.
5. Earn enough money by pressing WORK and confirm the buy button enables when affordable.
6. Purchase a worker and verify money decreases, worker count increases, and income/sec updates.
7. Watch the money display for at least 3 seconds and confirm passive income adds automatically.
8. Verify the buy button is disabled again if the next worker cost is higher than current money.
9. Close the Hiring panel with the Hiring button and confirm it hides properly.

## 10. Handoff task for Coding Agent
- Implement the Hiring panel toggle and worker purchase UI updates.
- Expose labels and buttons as named UI elements for easy client scripting.
- Ensure the buying flow validates funds before sending the request.
- Ensure the UI refreshes worker count, cost, income/sec, and money correctly.
- Keep the panel simple and consistent with the existing Main UI styling.
