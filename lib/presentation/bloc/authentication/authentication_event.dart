part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationEventStarted extends AuthenticationEvent {}

class AuthenticationEventLoggedIn extends AuthenticationEvent {}

class AuthenticationEventLoggedOut extends AuthenticationEvent {}

class AuthenticationEventUpdateUserName extends AuthenticationEvent {
  final String displayName;

  const AuthenticationEventUpdateUserName(this.displayName);

  @override
  List<Object> get props => [displayName];
}

class AuthenticationEventUpdateProfileImage extends AuthenticationEvent {
  final File image;

  const AuthenticationEventUpdateProfileImage(this.image);

  @override
  List<Object> get props => [image];
}

class AuthenticationEventUpdatePassword extends AuthenticationEvent {
  final String oldPassword;
  final String password;

  const AuthenticationEventUpdatePassword(this.oldPassword, this.password);

  @override
  List<Object> get props => [oldPassword, password];
}

class AuthenticationEventDeleteAccount extends AuthenticationEvent {}
