import 'package:chapter/chapter_module/model/chapter_model.dart';
import 'package:chapter/components/parallax_container.dart';
import 'package:chapter/utility/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChaptersView extends StatefulWidget {
  const ChaptersView({super.key});

  @override
  State<ChaptersView> createState() => _ChaptersViewState();
}

class _ChaptersViewState extends State<ChaptersView> {
  late final ChapterModel _chapterModel;

  @override
  void initState() {
    _chapterModel = ChapterModel.fromJson(chapterData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: _chapterModel.chapters?.length ?? 0,
              (context, index) {
                final chapter = _chapterModel.chapters?[index];
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.chapterDetail,
                      extra: {
                        "chapter_no": index,
                      },
                    );
                  },
                  child: ParallaxContainer(
                    imageUrl: locations[index % 10].imageUrl,
                    name: chapter?.title ?? '-',
                    country: "Chapter ${index + 1}",
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final list = [
  "Arjuna Vishada Yoga",
  "Sankhya Yoga",
  "Karma Yoga",
  "Jnana Karma Sanyasa Yoga",
  "Karma Sanyasa Yoga",
  "Dhyana Yoga",
  "Jnana Vijnana Yoga",
  "Aksara Brahma Yoga",
  "Raja Vidya Raja Guhya Yoga",
  "Vibhuti Yoga",
  "Visvarupa Darshana Yoga",
  "Bhakti Yoga",
  "Kshetra Kshetragna Vibhaga Yoga",
  "Gunatraya Vibhaga Yoga",
  "Purusottama Yoga",
  "Daivasura Sampad Vibhaga Yoga",
  "Sraddhatraya Vibhaga Yoga",
  "Moksha Sanyasa Yoga",
];
