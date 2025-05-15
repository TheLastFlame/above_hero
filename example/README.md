# Above Hero Example

This directory contains an example Flutter application demonstrating the usage of the `above_hero` package.

## Purpose

The `above_hero` package provides a widget (`AboveHero`) that allows its child to be displayed above a standard Flutter `Hero` animation during page transitions. This is useful for scenarios where you need elements like back buttons, floating action buttons, or other UI components to remain visible and interactive on top of the `Hero` animation, rather than being obscured by it.

This example showcases:
- A grid of tappable items that navigate to a detail page using `Hero` animations.
- On the detail page, a back button and a `DraggableScrollableSheet` are wrapped with `AboveHero`.
- This ensures that both the back button and the draggable sheet stay visually on top of the `Hero` animation as the colored card transitions between the pages.
- The `transitionOnUserGestures: true` property is used to demonstrate that these elements also stay on top during swipe-to-go-back gestures.

