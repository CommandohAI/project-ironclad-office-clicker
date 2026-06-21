Roblox Studio Output — Mission 002: Promotions

1. Required UI behaviour
- The existing `Promotions` button opens a centered modal (Frame) named `PromotionsModal`.
- Modal shows the player's current money, the player's current per-click `WorkPower`, and a single promotion tile allowing purchase of the next level.
- On successful purchase: modal updates immediately to show new money and new per-click value; a short visual success cue plays.
- On failed purchase (insufficient funds): the Purchase button is disabled and an "Insufficient funds" message is shown.

2. Required Explorer structure
- `StarterGui`
	- `MainUI` (ScreenGui)
		- `PromotionsButton` (TextButton) — existing, wired to open modal.
		- `PromotionsModal` (Frame) — new; set `Visible` = false by default.
			- `Header` (TextLabel)
			- `PlayerMoney` (TextLabel) — binds to money display (read-only from client view)
			- `PlayerWorkPower` (TextLabel) — shows current per-click earnings (e.g., "Earnings: £1.00")
			- `PromotionTile` (Frame)
				- `Icon` (ImageLabel)
				- `TierName` (TextLabel)
				- `OwnedLevel` (TextLabel)
				- `CurrentMultiplier` (TextLabel)
				- `NextCost` (TextLabel)
				- `PurchaseButton` (TextButton)
				- `InsufficientLabel` (TextLabel) — initially hidden; shows when unaffordable or on attempted invalid purchase.
		- `UIControllers` (Folder) — existing; add `PromotionsController` (LocalScript) recommended but optional (Coding Agent to implement).
- `ReplicatedStorage`
	- `IRONCLAD`
		- `Remotes` (Folder)
			- `RequestPurchasePromotion` (RemoteFunction or RemoteEvent) — see Coding Agent handoff.
			- `PromotionPurchased` (RemoteEvent) — optional: server notifies clients of successful purchase.

3. Required buttons, labels, frames, and visual elements
- `PromotionsModal` Frame: center-aligned, semi-opaque background, padding.
- `Header` label text: "Promotions".
- `PlayerMoney` label shows the same money value as the main UI money display.
- `PlayerWorkPower` label shows `Per-click: £X.XX` (two decimals).
- `PromotionTile` contains `TierName` (e.g., "Promotion"), `OwnedLevel` (e.g., "Level 1"), `CurrentMultiplier` (e.g., "+20%"), `NextCost` (e.g., "Cost: £10"), and `PurchaseButton` labeled "Purchase".
- `PurchaseButton` should have VisualState for disabled (greyed out) and enabled.
- `InsufficientLabel` small red text: "Insufficient funds"; visible only when needed.

4. What happens when the player presses the Promotions button
- `PromotionsModal.Visible` toggles to true.
- The client requests current promotion data from the server (via `GetPlayerPromotionData` or similar remote). The modal populates `OwnedLevel`, `NextCost`, and `PlayerWorkPower` from the returned data.

5. What happens when the player buys a promotion
- Client sends purchase request to `RequestPurchasePromotion` remote.
- Server validates funds, deducts cost, increments level, persists change, and replies with success and updated values.
- On success: `PlayerMoney`, `OwnedLevel`, `PlayerWorkPower`, and `NextCost` update in the modal instantly; play a short success animation (e.g., green flash on `PlayerMoney` and `PlayerWorkPower`).
- The modal can remain open to allow further purchases or be closed automatically per design (Coding Agent configurable).

6. What happens when the player cannot afford a promotion
- `PurchaseButton` is disabled and `InsufficientLabel` visible.
- If the client attempts to bypass the disabled state, server will reject the purchase and return an error; the client should show a brief toast: "You don't have enough money to buy this promotion." No negative balances.

7. What the Commander should see after implementation
- In Explorer:
	- `StarterGui > MainUI > PromotionsModal` exists and is `Visible = false` by default.
	- `ReplicatedStorage > IRONCLAD > Remotes` contains `RequestPurchasePromotion` and optionally `PromotionPurchased`.
- In Play (Start > Play):
	- Clicking `Promotions` opens the modal.
	- Modal displays current money and per-click earnings.
	- Buying a promotion deducts money and updates per-click display.
	- Disabled state prevents purchase and shows "Insufficient funds".

8. Roblox Studio test steps (exact)
1. Open the place in Roblox Studio and run a local server + client test (Start > Play).
2. Confirm `Promotions` button is visible in the main UI and `PromotionsModal` exists in Explorer under `StarterGui > MainUI`.
3. With a fresh test player, press `WORK` several times until you have at least £10.
4. Click `Promotions` to open the modal.
5. Verify `PlayerMoney`, `PlayerWorkPower`, and `NextCost` display sensible values per the Economy Agent table.
6. Click `Purchase` for the first promotion:
	 - Confirm player money decreases by the expected cost.
	 - Confirm `PlayerWorkPower` increases (e.g., from £1.00 to £1.20).
	 - Confirm a short success visual cue appears.
7. Close and rejoin (stop and Start > Play) to validate persistence: promotion level should remain increased.
8. Attempt to purchase when funds are insufficient and confirm `Purchase` is disabled and `Insufficient funds` message appears.

9. Handoff task for Coding Agent
- Implement client LocalScript `PromotionsController` under `StarterGui/MainUI/UIControllers` to manage modal open/close, request data, and send purchase requests.
- Implement server-side remote `RequestPurchasePromotion(player, promotionId)` in `ReplicatedStorage/IRONCLAD/Remotes` and server handlers that:
	- Validate player funds (server authoritative).
	- Deduct cost and increment promotion level in `PlayerDataService`.
	- Persist updated player data.
	- Return a response object: `{ success: bool, newMoney: number, newLevel: number, newPerClick: number, errorMessage?: string }`.
- Implement optional `PromotionPurchased` RemoteEvent for client notifications.
- UI contract (data format expected by the UI):
	- Promotions list entry: `{ id: string, name: string, icon: string | assetId, ownedLevel: number, nextCost: number, currentMultiplier: number, maxLevel?: number }`.
- Ensure displayed currency is rounded to 2 decimals and that server stores currency as an integer smallest unit or validates rounding.

Notes
- Keep the modal minimal for first playable: one promotion track, single tile, and clear afford/disabled states.
- Do not change existing `WORK` or money display elements — the modal reads and reflects those values.

# Roblox Studio Output

Pending mission output.
