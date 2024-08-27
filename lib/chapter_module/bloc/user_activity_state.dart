part of 'user_activity_cubit.dart';

@immutable
abstract class UserActivityState {}

class UserActivityInitial extends UserActivityState {}

class UserActivityLoading extends UserActivityState {}

class UserActivitySuccess extends UserActivityState {
  UserActivitySuccess({required this.userActivity});

  final UserActivityModel userActivity;
}

class UserActivityError extends UserActivityState {
  UserActivityError({this.errorMessage});
  final String? errorMessage;
}
