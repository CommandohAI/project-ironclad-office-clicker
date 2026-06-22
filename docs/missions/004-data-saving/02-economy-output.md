# 02-economy-output.md

## 1. Economy values that must be saved
- `Money`
- `WorkPower`
- `PromotionLevel`
- `WorkerCount`

## 2. Economy values that can be recalculated
- Passive income per second can be recalculated from saved `WorkerCount` and worker income config.
- Display strings such as `Earns £X per click` can be recalculated from saved `WorkPower`.
- Next worker cost can be recalculated from `WorkerCount` using the hiring cost formula.

## 3. Default values for new players
- `Money = 0`
- `WorkPower = 1`
- `PromotionLevel = 0`
- `WorkerCount = 0`

## 4. Risks if data fails to load
- Player progress may be lost for the session, causing frustration.
- The player may appear to have zero promotions or workers even if they had progression.
- Incorrect progression can break pacing and make the game feel unfair.

## 5. Risks if data fails to save
- Progress gained during the session may be lost on the next login.
- Players can lose trust in the persistence system.
- Unreliable saving may lead to repeated grinding to recover lost progress.

## 6. Safe fallback behaviour
- If load fails, initialize the player with default starting data and log the error for server-side diagnosis.
- If save fails, keep the in-session data active and retry on leave or periodically if possible.
- Do not award offline earnings to compensate for save/load failure.
- Keep the fallback simple: prefer safe defaults over corrupted or partial data.

## 7. Economy handoff task for Coding Agent
- Persist `Money`, `WorkPower`, `PromotionLevel`, and `WorkerCount` only.
- Recalculate derived values at runtime: passive income, current cost, and display values based on saved state.
- Ensure failure paths use safe defaults and do not create extra progress.
- Ensure no offline earnings are granted on load.
- Keep the implementation low-risk and focused on progression integrity.
