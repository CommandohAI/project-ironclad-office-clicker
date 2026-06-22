# 01-game-design-output.md

UI purpose
- Create a cleaner, more professional presentation for the current game.
- Make the main screen feel structured and easy to scan.
- Help players understand money, earnings, promotions, hiring, and rebirth at a glance.
- Keep the experience simple and readable without changing gameplay.

Main screen layout idea
- Use a top header or side panel for core stats: Money, Per Click, Passive Income, Prestige, Rebirth status.
- Place the WORK button prominently in the center or bottom-left with a consistent visual style.
- Use separate panel cards or tabs for Promotions, Hiring, and Rebirth so each section is clearly defined.
- Keep the main screen uncluttered; show only the most important stats and a clear action button.

Information hierarchy
- Primary: current Money and Work earnings.
- Secondary: current Per Click power and Passive Income rate.
- Tertiary: Prestige total and Rebirth eligibility/status.
- Panel headings should clearly label Promotions, Hiring, and Rebirth.
- Use concise labels and values so players can parse information quickly.

Button/panel behaviour
- All panels should open and close cleanly, with a visible close button or icon.
- Each panel should behave consistently: same header style, same close action, same spacing.
- Buttons should have consistent styling, hover feedback, and disabled state visuals.
- The WORK button stays on the main screen and remains the core interaction.
- Panels should not block the player from seeing their current stats.

Promotions panel improvements
- Present promotions as a simple list or grouped card with clear cost and effect text.
- Show each promotion’s current level or effect with short labels like “+X per click.”
- Add a heading and subheading that explain promotion value in one sentence.
- Include a close control and keep the panel sized consistently with other menus.

Hiring panel improvements
- Display each worker type with name, cost, count, and passive income contribution.
- Clarify total passive income as a separate line in the panel.
- Use consistent spacing and a clear affordance for buying/hiring more workers.
- Keep the panel focused on current hires and the next purchase option.

Rebirth panel improvements
- Show current Prestige and the rebirth requirement clearly.
- Include a short description of what Prestige does and why rebirth matters.
- Disable the Rebirth button until the player reaches the requirement.
- When not eligible, show a simple progress message like “Earn X more to unlock Rebirth.”
- Ensure the panel matches the style of Promotions and Hiring panels.

Tutorial/help hint ideas
- Add a small “Need help?” or “Tip” label near the main stats.
- Show one or two short contextual hints, such as “Work to earn money, then buy promotions to boost clicks.”
- Keep hints optional and unobtrusive, for example a small help icon or text line.
- Avoid full tutorials; use lightweight guidance that supports the current loop.

What should not change
- Core gameplay systems must remain unchanged.
- Work, promotions, hiring, saving, and rebirth mechanics stay intact.
- No new currencies, monetisation, or gameplay systems are introduced.
- Existing promotion tiers, worker tiers, and rebirth behavior remain the same.
- No complex animations or world/map systems are required.

Acceptance criteria
- The Game Design output is updated in `docs/missions/006-ui-polish-main-layout/01-game-design-output.md`.
- The UI design is simple, readable, and clearly supports the current game loop.
- Main stats and panel structure are easier to understand than the current layout.
- Panels for Promotions, Hiring, and Rebirth are consistent and closable.
- Buttons have a unified style, feedback states, and do not change gameplay behavior.
- Tutorial/help hints are optional, brief, and do not introduce new mechanics.

Handoff task for Roblox Studio Agent
- Design the updated main menu layout with a clear stats area, a prominent WORK button, and three matching panels for Promotions, Hiring, and Rebirth.
- Specify placement, sizing, and close behavior for each panel.
- Define the visual hierarchy for Money, Per Click, Passive Income, Prestige, and Rebirth status.
- Recommend simple UI polish choices such as panel cards, spacing, consistent button styles, and clean typography.

Handoff task for Coding Agent
- Implement the updated UI layout using existing gameplay systems.
- Keep current functionality exactly the same while applying the new presentation.
- Ensure panels are closable, buttons have consistent states, and the stats display is clearer.
- Add lightweight help hint text if appropriate, without changing game mechanics.
