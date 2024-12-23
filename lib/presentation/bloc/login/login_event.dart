part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginEventEmailChanged extends LoginEvent {
  final String email;
  const LoginEventEmailChanged({required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'LoginEventEmailChanged { email: $email }';
}

// Event when the password changes
final class LoginEventPasswordChanged extends LoginEvent {
  final String password;
  const LoginEventPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'LoginEventPasswordChanged { password: $password }';
}

// Event for signing in with Google
final class LoginEventWithGooglePressed extends LoginEvent {
  const LoginEventWithGooglePressed();
}

// Event for signing in with email and password
final class LoginEventWithEmailAndPasswordPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginEventWithEmailAndPasswordPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'LoginEventWithEmailAndPasswordPressed { email: $email, password: $password }';
  }
}
