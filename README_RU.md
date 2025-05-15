# Above Hero

[![Pub Version](https://img.shields.io/pub/v/above_hero?label=pub.dev)](https://pub.dev/packages/above_hero)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

[English version](README.md)


Этот пакет позволяет ограниченно контролировать z-index виджета Hero, размещая элементы страницы над ним во время переходов между страницами.

## Preview:

<table>
  <tr>
    <td align="center">
      <b>без above_hero</b><br>
      <img src="URL_TO_YOUR_GIF_WITHOUT_PACKAGE" alt="без above_hero" width="300" />
    </td>
    <td align="center">
      <b>с above_hero</b><br>
      <img src="URL_TO_YOUR_GIF_WITH_PACKAGE" alt="с above_hero" width="300" />
    </td>
  </tr>
</table>

Онлайн демо: [https://thela.space/above_hero](https://thela.space/above_hero)

## Как это работает?

Во время анимации перехода обе страницы расположены в оверлее навигации. Hero добавляет себя в этот оверлей на самый вверх. `above_hero`... делает то же самое.
`AboveHero` отслеживает момент начала анимации перехода, дожидается появления Hero в оверлее и переносит свой дочерний виджет наверх, заменяя плейсхолдером.
В оверлее `AboveHero` корректно позиционирует виджет, и применяет к нему ту же анимацию перехода, что применяется для экрана.
Визуально всё выглядит так, будто виджет всё ещё часть экрана.
После завершения анимации `AboveHero` возвращает виджет на его законное место на странице.

## Лицензия

Этот проект лицензирован на условиях лицензии MIT - см. файл [LICENSE](LICENSE) для подробностей.
