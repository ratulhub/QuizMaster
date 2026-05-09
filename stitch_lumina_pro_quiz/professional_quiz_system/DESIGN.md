---
name: Professional Quiz System
colors:
  surface: '#f9f9ff'
  surface-dim: '#d8d9e3'
  surface-bright: '#f9f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f3fd'
  surface-container: '#ecedf7'
  surface-container-high: '#e7e7f1'
  surface-container-highest: '#e1e2eb'
  on-surface: '#191b22'
  on-surface-variant: '#424753'
  inverse-surface: '#2e3038'
  inverse-on-surface: '#eff0fa'
  outline: '#727785'
  outline-variant: '#c2c6d5'
  surface-tint: '#005ac1'
  primary: '#0058bd'
  on-primary: '#ffffff'
  primary-container: '#2771df'
  on-primary-container: '#fefcff'
  inverse-primary: '#adc6ff'
  secondary: '#575f6b'
  on-secondary: '#ffffff'
  secondary-container: '#dbe3f1'
  on-secondary-container: '#5d6571'
  tertiary: '#595c5d'
  on-tertiary: '#ffffff'
  tertiary-container: '#727576'
  on-tertiary-container: '#fbfdfe'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d8e2ff'
  primary-fixed-dim: '#adc6ff'
  on-primary-fixed: '#001a41'
  on-primary-fixed-variant: '#004494'
  secondary-fixed: '#dbe3f1'
  secondary-fixed-dim: '#bfc7d4'
  on-secondary-fixed: '#141c26'
  on-secondary-fixed-variant: '#3f4752'
  tertiary-fixed: '#e1e3e4'
  tertiary-fixed-dim: '#c4c7c8'
  on-tertiary-fixed: '#191c1d'
  on-tertiary-fixed-variant: '#444748'
  background: '#f9f9ff'
  on-background: '#191b22'
  surface-variant: '#e1e2eb'
typography:
  display-lg:
    fontFamily: Outfit
    fontSize: 57px
    fontWeight: '600'
    lineHeight: 64px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Outfit
    fontSize: 32px
    fontWeight: '500'
    lineHeight: 40px
  headline-md:
    fontFamily: Outfit
    fontSize: 28px
    fontWeight: '500'
    lineHeight: 36px
  headline-sm:
    fontFamily: Outfit
    fontSize: 24px
    fontWeight: '500'
    lineHeight: 32px
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
  headline-lg-mobile:
    fontFamily: Outfit
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
rounded:
  sm: 0.5rem
  DEFAULT: 1rem
  md: 1.5rem
  lg: 2rem
  xl: 3rem
  full: 9999px
spacing:
  base: 8px
  xs: 4px
  sm: 12px
  md: 16px
  lg: 24px
  xl: 32px
  xxl: 48px
  container-max: 1120px
  gutter: 24px
---

## Brand & Style

This design system is built for high-stakes professional assessment and sophisticated learning environments. It leans heavily into the **Material 3** philosophy of "Personalized, Adaptable, and Expressive," but refines it into a minimalist, "Pro" level aesthetic. 

The brand personality is authoritative yet approachable—think of a digital Proctor who is calm, precise, and encouraging. By utilizing a high degree of white space and a restricted color palette, we reduce cognitive load for the user, allowing them to focus entirely on the content of the quiz. The emotional response should be one of clarity, confidence, and modern professionalism. The "capsule" shape language introduces a friendly, modern organicism that breaks away from traditional rigid corporate structures.

## Colors

The palette is anchored by **Google Blue (#4285F4)**, used purposefully for primary actions and brand presence. To maintain a "pro" feel, the secondary palette uses highly desaturated pastel shades that serve as functional indicators rather than decorative elements (e.g., light green for "correct," light red for "incorrect").

- **Primary:** Google Blue is the "source" color for interactive focus and progression.
- **Surface Strategy:** We use a "White on Light Grey" strategy. The main page background is `#F8F9FA`, while interactive cards and containers are pure `#FFFFFF` to create a subtle natural lift.
- **Pastel Accents:** These are used for secondary containers, chips, or background tints to provide soft visual feedback without overwhelming the user's eye.

## Typography

We utilize **Outfit**, a geometric sans-serif that mirrors the characteristics of Google Sans. It provides the perfect balance between clinical precision and modern approachability.

- **Headlines:** Use Medium (500) or SemiBold (600) weights to establish clear hierarchy. Display sizes use slight negative letter spacing to feel more "editorial" and premium.
- **Body:** Standard reading text uses Regular (400) weight with generous line heights (1.5x) to ensure readability during long assessment sessions.
- **Labels:** Used for buttons, tags, and small metadata. These are always Medium (500) weight to ensure they remain legible even at smaller sizes.

## Layout & Spacing

The design system follows a **12-column fluid grid** for desktop, transitioning to a **4-column grid** for mobile. The spacing philosophy is rooted in an 8px rhythm to maintain Material 3 consistency.

- **Whitespace:** We prioritize "breathing room." Content is rarely cramped; question containers should have at least `32px` of internal padding to feel premium and focused.
- **Centering:** For the quiz experience, a fixed-width central column (max 800px for questions) is preferred to prevent eye strain from long line lengths.
- **Breakpoints:**
    - Mobile: Up to 600px (Margins: 16px)
    - Tablet: 601px to 1024px (Margins: 24px)
    - Desktop: 1025px+ (Margins: Auto, max-width container applied)

## Elevation & Depth

Elevation in this design system is used sparingly to signify "interactivity" rather than physical height. We move away from heavy, dramatic shadows in favor of **Soft Tonal Elevation**.

- **Level 0 (Flat):** Used for the main background.
- **Level 1 (Low Blur):** Used for inactive cards or containers. Shadow: `0px 1px 3px rgba(0, 0, 0, 0.05)`.
- **Level 2 (Hover/Active):** Used when a user interacts with a quiz option or button. Shadow: `0px 4px 12px rgba(66, 133, 244, 0.12)`. Note the subtle blue tint in the shadow to reinforce the primary brand color.
- **Focus States:** Instead of high elevation, use a `2px` solid Google Blue border with a soft inner glow.

## Shapes

The defining visual characteristic of this design system is the **Capsule Shape**. 

Every interactive element—from the largest card to the smallest radio button—must utilize a high border-radius. 
- **Buttons & Inputs:** Must be fully pill-shaped (height / 2).
- **Cards & Question Containers:** Use a `rounded-xl` or `32px` radius to maintain a consistent "friendly" geometry.
- **Selection Indicators:** Progress bars and selection chips must have fully rounded end-caps.

## Components

### Buttons
Primary buttons are filled with Google Blue and use white text. Secondary buttons are "Tonal," using the Pastel Blue (`#E8F0FE`) with Blue text. All buttons must be pill-shaped.

### Quiz Cards
Question containers should be pure white with a 32px border radius. Use a very thin, light grey border (`1px solid #E0E0E0`) instead of heavy shadows to maintain the minimalist feel.

### Selection Inputs (Radio/Checkbox)
Replace standard browser inputs with custom "Capsule Selection" tiles. When an option is selected, the entire tile should transition to a light Google Blue background with a primary blue border.

### Progress Indicators
Use a thick, pill-shaped progress bar. The "track" should be `#F1F3F4` and the "indicator" should be a solid Google Blue.

### Chips & Tags
Used for categories or difficulty levels. These should be small, pill-shaped, and use the pastel accent palette (e.g., a "Math" tag might be Pastel Blue).

### Input Fields
Text inputs should be pill-shaped with a generous horizontal padding (24px) to ensure the text doesn't feel crowded by the curve of the capsule.