# Above Hero

[![Pub Version](https://img.shields.io/pub/v/above_hero?label=pub.dev)](https://pub.dev/packages/above_hero)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

[Русская версия](README_RU.md)

A package that allows limited control over the z-index of the Hero widget by placing page elements above it during page transitions.

## Preview:

<table>
  <tr>
    <td align="center" colspan="2">
      <img src="https://github.com/user-attachments/assets/363f734c-4ffe-4845-bf32-86c7cf4a7581" alt="combined preview" width="600" />
    </td>
  </tr>
  <tr>
    <td align="center" width="50%">
      <div style="display: block; margin-top: 8px;">
        <b>without above_hero</b>
      </div>
    </td>
    <td align="center" width="50%">
      <div style="display: block; margin-top: 8px;">
        <b>with above_hero</b>
      </div>
    </td>
  </tr>
</table>

Online demo: [https://thela.space/above_hero](https://thela.space/above_hero)

## Usage

Simply wrap the widgets that should be displayed above the Hero in `AboveHero`:
 ```dart
 Stack(
   children: <Widget>[
     Hero(tag: "myHero", child: MyHeroContent()),
     Positioned(
       top: 16,
       left: 16,
       child: AboveHero(
         child: ElevatedButton(
           onPressed: () => Navigator.pop(context),
           child: Icon(Icons.arrow_back),
         ),
       ),
     ),
   ],
 )
 ```

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
