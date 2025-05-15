# Above Hero

[![Pub Version](https://img.shields.io/pub/v/above_hero?label=pub.dev)](https://pub.dev/packages/above_hero)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

This package allows limited control of the Hero widget's z-index by placing page elements ABOVE it during page transitions.

## Preview:

<table>
  <tr>
    <td align="center">
      <b>without above_hero</b><br>
      <img src="URL_TO_YOUR_GIF_WITHOUT_PACKAGE" alt="without above_hero" width="300" />
    </td>
    <td align="center">
      <b>with above_hero</b><br>
      <img src="URL_TO_YOUR_GIF_WITH_PACKAGE" alt="with above_hero" width="300" />
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
