# Above Hero

[![Pub Version](https://img.shields.io/pub/v/above_hero?label=pub.dev)](https://pub.dev/packages/above_hero)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

[English version](README.md)


Пакет, позволяющий ограниченно контролировать z-index виджета Hero, размещая элементы страницы над ним во время переходов между страницами.

## Preview:

<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/26604dd6-1f81-42c6-bdf6-d59ec99b2fd1" alt="without above_hero" width="300" />
      <div style="display: block; margin-top: 8px;">
        <b>без above_hero</b>
      </div>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/cb732320-49b8-4c89-aab7-d8231c4e4236" alt="with above_hero" width="300" />
      <div style="display: block; margin-top: 8px;">
        <b>с above_hero</b>
      </div>
    </td>
  </tr>
</table>


Онлайн демо: [https://thela.space/above_hero](https://thela.space/above_hero)

## Как это работает?

Во время анимации перехода обе страницы расположены в оверлее навигации. Hero добавляет себя в этот оверлей на самый вверх. 

`above_hero`... делает то же самое.

1. Отслеживает момент начала анимации перехода
2. Дожидается появления Hero в оверлее
3. Переносит свой дочерний виджет наверх, заменяя плейсхолдером.

В оверлее `AboveHero` корректно позиционирует виджет, и применяет к нему ту же анимацию перехода, что применяется для экрана.

Визуально всё выглядит так, будто виджет всё ещё является частью экрана.

После завершения анимации `AboveHero` возвращает виджет на его законное место на странице.

## Лицензия

Этот проект лицензирован на условиях лицензии MIT - см. файл [LICENSE](LICENSE) для подробностей.
