part of 'verse_cubit.dart';

@immutable
abstract class VerseState {}

class VerseInitial extends VerseState {}

class VerseLoading extends VerseState {}

class VerseSuccess extends VerseState {
  VerseSuccess({required this.state});
  final VerseModel state;
}

class VerseError extends VerseState {}
