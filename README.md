# Above Hero

[![Pub Version](https://img.shields.io/pub/v/above_hero?label=pub.dev)](https://pub.dev/packages/above_hero)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

[Русская версия](https://github.com/TheLastFlame/above_hero/blob/master/README_RU.md)

A package that allows limited control over the z-index of the Hero widget by placing page elements above it during page transitions.

## Preview:
<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/26604dd6-1f81-42c6-bdf6-d59ec99b2fd1" alt="without above_hero" width="300" />
      <div style="display: block; margin-top: 8px;">
        <b>without above_hero</b>
      </div>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/cb732320-49b8-4c89-aab7-d8231c4e4236" alt="with above_hero" width="300" />
      <div style="display: block; margin-top: 8px;">
        <b>with above_hero</b>
      </div>
    </td>
  </tr>
</table>

Online demo: [https://thela.space/above_hero](https://thela.space/above_hero)

## How does it work?

During the transition animation, both pages are located in the navigation overlay. Hero adds itself to this overlay at the very top.

`above_hero`... does the same.

1. Tracks the moment the transition animation starts
2. Waits for Hero to appear in the overlay
3. Moves its child widget to the top, replacing it with a placeholder.

In the overlay, `AboveHero` correctly positions the widget and applies the same transition animation to it that is applied to the screen.

Visually, everything looks as if the widget is still part of the screen.

After the animation is complete, `AboveHero` returns the widget to its rightful place on the page.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
