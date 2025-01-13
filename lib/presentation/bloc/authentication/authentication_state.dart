part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final User user;

  const AuthenticationSuccess(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() {
    return "AuthenticationSuccess { user: $user }";
  }
}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  const AuthenticationFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return "AuthenticationFailure { message: $message }";
  }
}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationUpdateProfileSuccess extends AuthenticationState {
  final User user;

  const AuthenticationUpdateProfileSuccess(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() {
    return "AuthenticationUpdateProfileSuccess { user: $user }";
  }
}

class AuthenticationUpdateProfileImageSuccess extends AuthenticationState {
  final User user;

  const AuthenticationUpdateProfileImageSuccess(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() {
    return "AuthenticationUpdateProfileImageSuccess { user: $user }";
  }
}

class AuthenticationUpdatePasswordSuccess extends AuthenticationState {
  final User user;

  const AuthenticationUpdatePasswordSuccess(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() {
    return "AuthenticationUpdatePasswordSuccess { user: $user }";
  }
}

class AuthenticationDeleteAccountSuccess extends AuthenticationState {}
