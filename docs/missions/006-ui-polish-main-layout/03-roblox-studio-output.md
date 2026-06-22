# 03-roblox-studio-output.md

Required main screen layout
- The main screen must show a clear stats header or side section with current Money, Per Click, Passive Income, Prestige, and Rebirth status.
- The WORK button should be prominent, visually distinct, and consistently sized.
- Promotions, Hiring, and Rebirth should appear as separate panels or cards with matching visual style.
- The layout should be simple and balanced, with main stats visible while any panel is open.

Required panel layout
- Each panel should use the same frame style, header font, and close behavior.
- Panels should have a visible close button or icon in the top-right corner.
- Promotions, Hiring, and Rebirth panels should be clearly labeled and visually grouped.
- The panels should not overlap the core WORK area or obscure the main stats.

Required buttons, labels, frames, and visual elements
- `MoneyLabel`: large, clear display of current money.
- `PerClickLabel`: shows current earnings per WORK click.
- `PassiveIncomeLabel`: shows total passive income per second or minute.
- `PrestigeLabel`: shows current prestige amount.
- `RebirthStatusLabel`: shows current rebirth eligibility or requirement.
- `WorkButton`: large button for the main click action.
- `PromotionsPanel`, `HiringPanel`, `RebirthPanel`: consistent frame cards for each section.
- Each panel should include a header label, content area, and close control.
- Buttons inside each panel should share consistent styling, hover feedback, and disabled appearance.

How Promotions should look/behave
- The Promotions panel should display each promotion entry with name, cost, and effect.
- Each entry should have a clear button for purchase or level-up.
- Show a short summary line such as `+X per click` or `Next upgrade: +Y`.
- The panel should be easy to scan and should not require scrolling for the first few promotion items.
- If a promotion button is unavailable, it should show a disabled state and a clear reason.

How Hiring should look/behave
- The Hiring panel should list worker options with name, count owned, cost, and passive income contribution.
- Display the total passive income clearly at the top or bottom of the panel.
- Each hiring button should be clearly labeled and consistent with the Promotions panel.
- The panel should show the current count of each worker type and the cost for the next hire.
- When the player buys a worker, the panel should update immediately and keep the same layout.

How Rebirth should look/behave
- The Rebirth panel should clearly show the current Prestige total.
- Show the current rebirth requirement and whether the player is eligible.
- Include a `RebirthButton` that is disabled until eligibility is met.
- Include a short explanation line describing Prestige benefit, e.g. `Prestige increases future earnings.`
- If the player is not eligible, show a message like `Earn X more to unlock Rebirth.`

How important stats should be displayed
- Money should be the most prominent stat on the screen.
- Per Click and Passive Income should be grouped near Money with smaller but readable labels.
- Prestige and Rebirth status should be visible but not dominate the main screen.
- Use consistent label formats like `Money: 1,234`, `Click: +12`, `Passive: +5/sec`, `Prestige: 0`.
- Keep text concise and easy to read at a glance.

Button feedback requirements
- All buttons should have a hover or pressed state that makes them feel interactive.
- Disabled buttons should look visually distinct and unclickable.
- The WORK button should visually respond on click.
- Panel open/close controls should be clearly styled and consistent across panels.
- Feedback should be visual only; no new gameplay behavior is introduced.

What the Commander should see after implementation
- A cleaner main UI layout with a prominent WORK button and a clear stats area.
- Three matching panels for Promotions, Hiring, and Rebirth with headers and close controls.
- Improved readability for Money, Per Click, Passive Income, Prestige, and Rebirth status.
- Buttons that appear responsive and consistent across the UI.
- Rebirth panel that clearly shows eligibility, requirement, and Prestige total.

Roblox Studio test steps
1. Open the project in Roblox Studio and enter Play mode.
2. Confirm the main UI shows Money, Per Click, Passive Income, Prestige, and Rebirth status clearly.
3. Confirm the WORK button is prominent and styled consistently with other buttons.
4. Open the Promotions panel and verify it shows promotion entries, costs, effects, and close button.
5. Open the Hiring panel and verify it shows worker entries, counts, costs, passive income, and close button.
6. Open the Rebirth panel and verify it shows Prestige, requirement text, a disabled Rebirth button if not eligible, and a close button.
7. Verify all panels use a matching visual style and do not obscure the main stats.
8. Interact with buttons and confirm hover/pressed and disabled states are visible.
9. Play the game long enough to ensure the UI remains readable and the main statistics update.

Handoff task for Coding Agent
- Apply the updated layout and visuals using the existing UI in `StarterGui/MainUI`.
- Keep the game functionality unchanged while updating panel layouts and styles.
- Ensure the Rebirth panel is consistent with Promotions and Hiring and includes the new eligibility messaging.
- Make stat labels and buttons update instantly with current values from the game systems.
