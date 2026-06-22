# 01-game-design-output.md

## 1. Gameplay purpose of saving
Saving provides continuity between play sessions. It preserves the player’s progress so they can return later and continue earning from promotions, hired workers, and accumulated money.

## 2. Player experience when rejoining
- The player should return to the same money balance they had when they last left.
- Their current promotion level and per-click earnings should persist.
- The number of hired workers and passive income rate should persist.
- The game should resume with the player able to continue pressing WORK and earning based on the saved state.

## 3. What data must be saved
- `Money`
- `WorkPower`
- `PromotionLevel`
- `WorkerCount`

## 4. What data should not be saved yet
- Current session runtime timers or elapsed time since last logout.
- Any offline earnings while the player was away.
- Temporary UI state such as whether the Hiring panel was open.
- Any monetisation or purchase history.

## 5. Expected behaviour for new players
- New players should start with the default values: base money, base work power, no promotions, and no workers.
- The save system should create a new profile when a new player joins.
- The UI should show `£0` money, `Earns £1 per click`, and zero workers owned.

## 6. Expected behaviour for returning players
- Returning players should see the money and progression values loaded from their last session.
- Promotions should reflect the saved promotion level and apply the saved per-click earnings.
- Hiring should reflect the saved worker count and passive income per second.
- Passive income should resume generating normally from the server using saved worker count.

## 7. Acceptance criteria
- A player’s `Money`, `WorkPower`, `PromotionLevel`, and `WorkerCount` are saved and restored across sessions.
- New players receive default starting data.
- Returning players resume with the same progression they had when they left.
- No offline earnings are granted on rejoin.
- UI and gameplay values match the restored state after rejoin.

## 8. Handoff task for Coding Agent
- Implement a save/load system that stores `Money`, `WorkPower`, `PromotionLevel`, and `WorkerCount` for each player.
- Load player data when they join and save data when they leave.
- Ensure the server restores saved values before any work, promotion, or hiring actions occur.
- Do not calculate or award offline earnings on load.
- Keep the implementation simple and robust for the first playable version.
