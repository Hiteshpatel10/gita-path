import 'package:chapter/components/chapter_landing.dart';
import 'package:chapter/verse_module/bloc/verse_cubit.dart';
import 'package:chapter/verse_module/model/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_flip/page_flip.dart';

class VerseView extends StatefulWidget {
  const VerseView({super.key, required this.verseNo});

  final String verseNo;

  @override
  State<VerseView> createState() => _VerseViewState();
}

class _VerseViewState extends State<VerseView> {

  int _selectedAuthor = 0;
  int _selectedLanguage = 0;
  _buildPagesList(VerseModel state) {
    List<Widget> pagesWidget = [];

    pagesWidget.add(
      ChapterLanding(
        title: "Chapter ${state.result?.chapter}",
        name: "Hitesh patel",
        subTitle: "Verse ${state.result?.verse}",
      ),
    );

    pagesWidget.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Verse", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Text(
              state.result?.slok ?? '',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 64),
            Text("Transliteration", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Text(
              state.result?.transliteration ?? '',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );

    final pageText = _splitTextIntoPages(
      context,
      state.result?.comments?[_selectedAuthor].languages?[_selectedLanguage].text ?? '',
    );

    for (var page in pageText) {
      pagesWidget.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Text(
            page,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      );
    }


    return PageFlipWidget(
      backgroundColor: Colors.white,
      lastPage: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Last Page!'),
        ),
      ),
      children: pagesWidget,
    );
  }

  @override
  void initState() {
    BlocProvider.of<VerseCubit>(context).getVerse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<VerseCubit, VerseState>(
        builder: (context, state) {
          if (state is VerseLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is VerseSuccess) {
            return _buildPagesList(state.state);

          }

          return const Center(
            child: Text("Something went wrong"),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<VerseCubit, VerseState>(builder: (context, state) {
        if (state is VerseSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    state.state.result?.comments?[_selectedAuthor].languages?.length ?? 0,
                    (index) {
                      final comments =
                          state.state.result?.comments?[_selectedAuthor].languages?[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedLanguage = index;

                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _selectedLanguage == index ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.blue),
                          ),
                          child: Text(comments?.language ?? '-'),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    state.state.result?.comments?.length ?? 0,
                    (index) {
                      final comments = state.state.result?.comments?[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedLanguage = 0;
                            _selectedAuthor = index;

                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _selectedAuthor == index ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.blue),
                          ),
                          child: Text(comments?.author ?? '-'),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          );
        }

        return const SizedBox.shrink();
      }),
    );
  }
}

List<String> _splitTextIntoPages(BuildContext context, String text) {
  List<String> pageList = [];

  TextPainter textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );

  TextStyle textStyle = const TextStyle(fontSize: 16);
  double pageWidth = MediaQuery.of(context).size.width - 32; // Horizontal padding
  double pageHeight = MediaQuery.of(context).size.height - 200; // Vertical padding

  String remainingText = text;
  while (remainingText.isNotEmpty) {
    textPainter.text = TextSpan(text: remainingText, style: textStyle);
    textPainter.layout(maxWidth: pageWidth);

    int endIndex = textPainter.getPositionForOffset(Offset(pageWidth, pageHeight)).offset;
    if (endIndex == 0) {
      endIndex = remainingText.length;
    }

    pageList.add(remainingText.substring(0, endIndex).trim());
    remainingText = remainingText.substring(endIndex).trim();
  }

  return pageList;
}
