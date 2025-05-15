# Above Hero

[![Pub Version](https://img.shields.io/pub/v/above_hero?label=pub.dev)](https://pub.dev/packages/above_hero)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

[English version](README.md)


Пакет, позволяющий ограниченно контролировать z-index виджета Hero, размещая элементы страницы над ним во время переходов между страницами.

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
        <b>без above_hero</b>
      </div>
    </td>
    <td align="center" width="50%">
      <div style="display: block; margin-top: 8px;">
        <b>с above_hero</b>
      </div>
    </td>
  </tr>
</table>



Онлайн демо: [https://thela.space/above_hero](https://thela.space/above_hero)

## Использование
 
Просто оберните в AboveHero те виджеты, которые должны отображаться над Hero:
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
