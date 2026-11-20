# GCAMS Style Guide – Summary

## 1. Color Palette

| Color        | Hex Code  | Purpose                             |
| ------------ | --------- | ----------------------------------- |
| Primary Blue | `#1d68f0` | Buttons, links, and active controls |
| Dark Navy    | `#07345d` | Sidebar and branding                |
| Active Navy  | `#0b416f` | Active navigation items             |
| Gold         | `#f2dc79` | Brand accents and highlights        |
| Background   | `#f4f6fa` | Main page background                |
| White        | `#ffffff` | Cards, panels, and modals           |
| Dark Text    | `#17243a` | Headings and primary text           |
| Muted Text   | `#73828d` | Secondary text and labels           |
| Border       | `#e6edef` | Dividers and card borders           |

### Status Colors

- **Green:** Successful or confirmed appointments.
- **Yellow:** Pending requests and moderate risk.
- **Red:** Errors, alerts, and high-risk indicators.
- **Violet:** Appointment icons and module accents.

## 2. Typography

- **Headings:** Manrope (Bold 700–800).
- **Body Text:** DM Sans (Regular 400–Bold 700).
- **Page Titles:** 30px.
- **Modal Titles:** 22px.
- **Panel Titles:** 15px.
- **Body Text:** 14px.
- **Form Labels:** 11–12px.
- **Captions:** 10–11px.

## 3. Layout and Design

- **Sidebar:** 246px wide, dark navy background with gold active indicators.
- **Main Content:** Light gray background with white cards.
- **Cards:** 8px rounded corners with subtle shadows.
- **Modals:** 12px rounded corners with a dark translucent backdrop.
- **Buttons and Inputs:** 6px rounded corners.
- **Avatars and Status Indicators:** Circular design.

## 4. UI Components

| Component        | Design                                             |
| ---------------- | -------------------------------------------------- |
| Primary Button   | Blue background with white bold text               |
| Secondary Button | White background with gray border                  |
| Ghost Button     | Light gray background with muted text              |
| Form Inputs      | White background, subtle border, blue focus effect |
| Data Cards       | White surface, subtle shadow, organized rows       |
| Appointment Tags | Colored labels indicating workflow status          |
| Modal Dialog     | White background, rounded corners, centered layout |

## 5. Responsive Design

- **Desktop:** Full sidebar and dashboard layout.
- **Tablet (900px):** Sidebar hidden and mobile navigation toggle displayed.
- **Mobile (600px):** Appointment items become vertically stacked, buttons expand to full width, and modal padding is reduced.
- **Mobile Compatibility:** No horizontal scrolling at 390px viewport width.

## 6. CSS Custom Properties Reference

```css
:root {
  /* Brand Theme Tokens */
  --navy: #07345d;
  --navy-active: #0b416f;
  --gold: #f2dc79;
  --paper: #f4f6fa;
  --surface: #ffffff;
  --ink: #17243a;
  --muted: #73828d;
  --line: #e6edef;
  --blue: #1d68f0;
  --blue-hover: #0d54d5;
  --shadow: 0 4px 14px rgba(0, 0, 0, 0.04);

  /* Style Guide Aliases */
  --color-primary: #1d68f0;
  --color-primary-hover: #0d54d5;
  --color-bg: #f4f6fa;
  --color-surface: #ffffff;
  --color-text: #17243a;
  --color-text-muted: #73828d;

  /* Typography */
  --font-heading: "Manrope", Arial, sans-serif;
  --font-body: "DM Sans", Arial, sans-serif;

  /* Corner Radii */
  --radius: 4px;
  --radius-md: 6px;
  --radius-lg: 10px;
}
```
