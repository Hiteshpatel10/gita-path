import 'package:chapter/components/parallax_container.dart';
import 'package:chapter/components/push_button.dart';
import 'package:chapter/utility/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:go_router/go_router.dart';

double _gapHeight = 60;

class QuestMap extends StatelessWidget {
  const QuestMap({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      shrinkWrap: true,
      reverse: true,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
      itemCount: 18,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 18,
              itemBuilder: (context, verse) {
                final baseY = verse * _gapHeight;

                return Transform.translate(
                  offset: Offset(
                    100 * math.sin((scrollController.offset + index * _gapHeight + baseY) / 150),
                    0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: LevelAnimatedButton(
                        onPressed: () {
                          context.pushNamed(AppRoutes.flipper);
                        },
                        height: 50,
                        buttonHeight: 10,
                        width: 65,
                        backgroundColor: getColorForSections(index),
                        buttonType: LevelButtonTypes.oval,
                        child: Text((verse + 1).toString()),
                      ),
                    ),
                  ),
                );
              },
            ),
            ParallaxContainer(
              imageUrl: locations[index % 10].imageUrl,
              name: "Chapter ${index + 1}",
              country: "INDIA",
            ),
          ],
        );
      },
    );
  }
}

Color getColorForSections(int id) {
  switch (id % 5) {
    case 0:
      return Colors.red;
    case 1:
      return Colors.blue;
    case 2:
      return Colors.green;
    case 3:
      return Colors.orange;
    case 4:
      return Colors.purple;
    default:
      return Colors.black;
  }
}
