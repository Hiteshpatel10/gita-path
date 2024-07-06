import 'package:chapter/verse_module/bloc/verse_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerseView extends StatefulWidget {
  const VerseView({
    super.key,
    required this.verseNo,
    required this.chapterNo,
  });

  final int chapterNo;
  final int verseNo;

  @override
  State<VerseView> createState() => _VerseViewState();
}

class _VerseViewState extends State<VerseView> {
  int _selectedAuthor = 0;
  int _selectedLanguage = 0;

  @override
  void initState() {
    BlocProvider.of<VerseCubit>(context).getVerse(
      chapterNo: widget.chapterNo,
      verseNo: widget.verseNo,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<VerseCubit, VerseState>(
        builder: (context, state) {
          if (state is VerseLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is VerseSuccess) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  Text(
                    state.state.result?.slok ?? '',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(height: 2),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 64),
                  Text("Transliteration", style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Text(
                    state.state.result?.transliteration ?? '',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 64),
                  Text("Meaning", style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Text(
                    state.state.result?.comments?[_selectedAuthor].languages![_selectedLanguage]
                            .text ??
                        '',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
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
