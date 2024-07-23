part of 'chapter_cubit.dart';

@immutable
sealed class ChapterState {}

final class ChapterInitial extends ChapterState {}

class LoadingState extends ChapterState {}

class ErrorState extends ChapterState {}

class SuccessState extends ChapterState {
  SuccessState({required this.state});
  final UserDataModel state;
}
