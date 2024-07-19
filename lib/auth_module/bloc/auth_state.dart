part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class Authenticating extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailed extends AuthState {
  AuthFailed({this.errorMessage});
  final String? errorMessage;
}
