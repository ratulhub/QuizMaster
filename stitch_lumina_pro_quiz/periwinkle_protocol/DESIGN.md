---
name: Periwinkle Protocol
colors:
  surface: '#fcf8fd'
  surface-dim: '#dcd9de'
  surface-bright: '#fcf8fd'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f6f2f7'
  surface-container: '#f0edf2'
  surface-container-high: '#ebe7ec'
  surface-container-highest: '#e5e1e6'
  on-surface: '#1c1b1f'
  on-surface-variant: '#494551'
  inverse-surface: '#313034'
  inverse-on-surface: '#f3eff4'
  outline: '#7a7582'
  outline-variant: '#cbc4d2'
  surface-tint: '#6750a4'
  primary: '#4f378a'
  on-primary: '#ffffff'
  primary-container: '#6750a4'
  on-primary-container: '#e0d2ff'
  inverse-primary: '#cfbcff'
  secondary: '#b4271f'
  on-secondary: '#ffffff'
  secondary-container: '#fe5c4c'
  on-secondary-container: '#610002'
  tertiary: '#624000'
  on-tertiary: '#ffffff'
  tertiary-container: '#815600'
  on-tertiary-container: '#ffd293'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e9ddff'
  primary-fixed-dim: '#cfbcff'
  on-primary-fixed: '#22005d'
  on-primary-fixed-variant: '#4f378a'
  secondary-fixed: '#ffdad5'
  secondary-fixed-dim: '#ffb4aa'
  on-secondary-fixed: '#410001'
  on-secondary-fixed-variant: '#910809'
  tertiary-fixed: '#ffddb1'
  tertiary-fixed-dim: '#fcba55'
  on-tertiary-fixed: '#291800'
  on-tertiary-fixed-variant: '#624000'
  background: '#fcf8fd'
  on-background: '#1c1b1f'
  surface-variant: '#e5e1e6'
typography:
  display-lg:
    fontFamily: Outfit
    fontSize: 57px
    fontWeight: '400'
    lineHeight: 64px
    letterSpacing: -0.25px
  headline-lg:
    fontFamily: Outfit
    fontSize: 32px
    fontWeight: '400'
    lineHeight: 40px
  headline-md:
    fontFamily: Outfit
    fontSize: 28px
    fontWeight: '400'
    lineHeight: 36px
  title-lg:
    fontFamily: Outfit
    fontSize: 22px
    fontWeight: '500'
    lineHeight: 28px
  title-md:
    fontFamily: Outfit
    fontSize: 16px
    fontWeight: '500'
    lineHeight: 24px
    letterSpacing: 0.15px
  body-lg:
    fontFamily: Outfit
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: 0.5px
  body-md:
    fontFamily: Outfit
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: 0.25px
  label-lg:
    fontFamily: Outfit
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: 0.1px
  label-sm:
    fontFamily: Outfit
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.5px
rounded:
  sm: 0.5rem
  DEFAULT: 1rem
  md: 1.5rem
  lg: 2rem
  xl: 3rem
  full: 9999px
spacing:
  xs: 0.25rem
  sm: 0.5rem
  md: 1rem
  lg: 1.5rem
  xl: 2rem
  xxl: 4rem
  gutter: 1.5rem
  margin-mobile: 1rem
  margin-desktop: 2.5rem
---

## Brand & Style

This design system is built on the principles of **Corporate Modernism** with a friendly, approachable twist. It prioritizes clarity, systematic hierarchy, and a high degree of "finish" reminiscent of premium Google workspace applications. 

The aesthetic is characterized by:
- **Cleanliness:** Massive whitespace serves as a structural element, not just a gap.
- **Approachability:** Soft, rounded "capsule" geometry reduces visual tension.
- **Sophistication:** A palette rooted in muted periwinkle and deep lavender conveys intelligence and professional reliability.
- **Contextual Energy:** While the core is neutral, secondary accents (red, ochre, green) provide distinct semantic "modes" to prevent visual monotony.

## Colors

The color strategy uses a **Foundation + Mode** approach. 

- **Primary (#6750A4):** The "Normal" state. Used for key actions, brand moments, and primary navigation.
- **Neutral Foundation:** The UI sits on a pure white (#FFFFFF) background, utilizing a very soft lavender-tinted neutral (#F6F2F7) for secondary containers and background fills.
- **Semantic Accents:** 
    - **Deep Red (#B3261E):** Used for "Roast" or "Critical" modes.
    - **Ochre (#A06B00):** Used for "Teacher" or "Warning" modes.
    - **Green (#386A20):** Used for "Success" or "Competitive" modes.
- **Text:** High-contrast charcoal (#1C1B1F) ensures maximum legibility against light surfaces.

## Typography

This system exclusively utilizes **Outfit**, a geometric sans-serif that balances the clinical precision of a grotesque with a warm, circular construction.

- **Headlines:** Use generous tracking and standard weights. Headlines should always feel "airy."
- **Readability:** Body text uses a slightly more generous line height (1.5x) to accommodate the rounded letterforms of Outfit.
- **Labels:** Button labels and tags use a medium weight (500) and increased letter spacing for clarity at smaller sizes.
- **Hierarchy:** Use color (Primary Purple vs Medium Grey) rather than just size to distinguish between primary titles and secondary descriptions.

## Layout & Spacing

The layout is based on a **12-column fluid grid** for desktop and a **4-column grid** for mobile.

- **Rhythm:** An 8px linear scale is used for all internal spacing.
- **Margins:** Generous outer margins (40px on desktop) ensure the content feels centered and important.
- **Container Padding:** Cards and surfaces should use `lg` (24px) or `xl` (32px) padding to maintain the "Google-style" breathable feel.
- **Vertical Spacing:** Use `xxl` (64px) spacing between major sections to emphasize the clean, white aesthetic.

## Elevation & Depth

Hierarchy is established through **Tonal Elevation** rather than heavy shadows.

- **Surface 0:** The main background (#FFFFFF or #F6F2F7).
- **Surface 1:** Soft cards with a subtle 1px border (#E6E1E5) and a very diffused, low-opacity shadow (4% opacity, 8px blur, 4px Y-offset).
- **Interactive State:** On hover, cards should lift slightly by increasing shadow opacity to 8% and decreasing the border's transparency.
- **Focus:** Never use "glow" effects. Use a solid 2px primary-colored ring with an offset for focused elements.

## Shapes

The "Capsule" look is the defining visual characteristic of this design system.

- **Full Rounding (ROUND_FULL):** Used for all buttons, input fields, tags, and selection chips.
- **Large Components:** Main content cards and modals use `rounded-xl` (24px - 32px) to maintain a soft but structural feel.
- **Consistency:** If an element is interactive, it should likely be a capsule or a highly rounded rectangle. Sharp corners are strictly prohibited.

## Components

### Buttons
- **Primary:** Capsule shape, solid Primary color fill, white text.
- **Secondary/Mode:** Solid semantic color (Red, Ochre, Green) based on the active protocol.
- **Outlined:** Capsule shape, 1px border of the active accent color, transparent fill.

### Input Fields
- **Search/Text:** Full-pill shape with a light-grey fill (#F1F3F4) that turns white with a 2px primary border on focus.
- **Radio/Checkboxes:** Use the primary purple for the "selected" state. Circles should be perfectly round; checkboxes should have a generous 4px corner radius.

### Cards
- **Structure:** 24px internal padding.
- **Footer:** Buttons in cards are always full-width capsules at the bottom or right-aligned capsules.
- **Visuals:** Use subtle background tints (e.g., a 5% opacity red fill for "Roast Mode" cards) to reinforce the mode.

### Chips & Tags
- **Style:** Small capsule shapes with a height of 32px.
- **Usage:** Indicate active status or "Mode" in the top right of containers. Use uppercase `label-sm` typography.

### Lists
- **Item Style:** Encased in soft-rounded containers with 12px vertical spacing between items. Hover states should use the `neutral` color fill.