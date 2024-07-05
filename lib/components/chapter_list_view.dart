import 'package:chapter/components/parallax_container.dart';
import 'package:flutter/material.dart';

class ChapterListView extends StatelessWidget {
  const ChapterListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: const Text("Home"),
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                height: 400,
                color: Colors.grey,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 18,
              (context, index) {
                return ParallaxContainer(
                  imageUrl: locations[index % 10].imageUrl,
                  name: "Chapter ${index + 1}",
                  country: "INDIA",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
