import 'dart:math';

import 'package:above_hero/above_hero.dart';
import 'package:flutter/material.dart';
import 'package:universal_back_gesture/back_gesture_page_transitions_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            for (final platform in TargetPlatform.values)
              platform: BackGesturePageTransitionsBuilder(
                parentTransitionBuilder: FadeForwardsPageTransitionsBuilder(),
              ),
          },
        ),
      ),
      home: HomePage(),
    );
  }
}

class ConstrainedFrame extends StatelessWidget {
  const ConstrainedFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 500),
        child: child,
      ),
    );
  }
}

Color getColor(int index) {
  int row = index ~/ 2;
  int col = index % 2;
  bool isBlue = (row + col) % 2 == 0;
  return isBlue ? Colors.blue : Colors.red;
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedFrame(
        child: GridView.builder(
          padding: EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) => Hero(
            tag: 'item$index',
            transitionOnUserGestures: true,
            // This has nothing to do with the above_hero library, just for the less harsh effect of Hero itself
            flightShuttleBuilder: heroFlightShuttle,
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              color: getColor(index),

              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardPage(index: index),
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    'Item $index',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget heroFlightShuttle(
    flightContext,
    animation,
    flightDirection,
    fromHeroContext,
    toHeroContext,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final Widget startWidget = flightDirection == HeroFlightDirection.push
            ? fromHeroContext.widget
            : toHeroContext.widget;
        final Widget endWidget = flightDirection == HeroFlightDirection.push
            ? toHeroContext.widget
            : fromHeroContext.widget;

        final progress = Curves.easeInOut.transform(animation.value);

        return Stack(
          fit: StackFit.expand,
          children: [
            Opacity(opacity: 1.0 - progress, child: startWidget),
            Opacity(opacity: progress, child: endWidget),
          ],
        );
      },
    );
  }
}

class CardPage extends StatelessWidget {
  const CardPage({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.widthOf(context);
    final double screenHeight = MediaQuery.heightOf(context);
    final double cardHeight = min(500, screenWidth);

    final double childSize = (screenHeight - cardHeight + 32) / screenHeight;
    final double topPadding =
        MediaQuery.viewPaddingOf(context).top + kToolbarHeight + 16;
    final double maxChildSize = (screenHeight - topPadding) / screenHeight;

    return Scaffold(
      body: ConstrainedFrame(
        child: Stack(
          children: [
            Hero(
              tag: 'item$index',
              transitionOnUserGestures: true,
              child: ColoredBox(
                color: getColor(index),
                child: SizedBox.square(dimension: cardHeight),
              ),
            ),

            AboveHero(
              transitionOnUserGestures: true,
              child: DraggableScrollableSheet(
                maxChildSize: maxChildSize,
                initialChildSize: childSize,
                minChildSize: childSize,
                builder: (context, controller) {
                  return Material(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),

                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      controller: controller,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text('Item $index'));
                      },
                    ),
                  );
                },
              ),
            ),
            SafeArea(
              child: AboveHero(
                transitionOnUserGestures: true,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton.filledTonal(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
