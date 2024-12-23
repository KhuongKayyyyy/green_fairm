part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const LoginState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  // Getter to check if email and password are valid
  bool get isValidEmailAndPassword => isEmailValid && isPasswordValid;

  // Method to clone an object of LoginState with optional updated values
  LoginState cloneWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return LoginCustomState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object> get props => [
        isEmailValid,
        isPasswordValid,
        isSubmitting,
        isSuccess,
        isFailure,
      ];
}

// Initial state
final class LoginInitial extends LoginState {
  const LoginInitial()
      : super(
          isEmailValid: true,
          isPasswordValid: true,
          isSubmitting: false,
          isSuccess: false,
          isFailure: false,
        );
}

// Loading state when submission is in progress
final class LoginLoading extends LoginState {
  const LoginLoading()
      : super(
          isEmailValid: true,
          isPasswordValid: true,
          isSubmitting: true,
          isSuccess: false,
          isFailure: false,
        );
}

// Failure state when login fails
final class LoginFailure extends LoginState {
  final String errorMessage;
  const LoginFailure(
    this.errorMessage,
  ) : super(
          isEmailValid: true,
          isPasswordValid: true,
          isSubmitting: false,
          isSuccess: false,
          isFailure: true,
        );
}

// Success state when login is successful
final class LoginSuccess extends LoginState {
  const LoginSuccess()
      : super(
          isEmailValid: true,
          isPasswordValid: true,
          isSubmitting: false,
          isSuccess: true,
          isFailure: false,
        );
}

// Custom state to handle cloned or updated states
final class LoginCustomState extends LoginState {
  const LoginCustomState({
    required super.isEmailValid,
    required super.isPasswordValid,
    required bool isSubmitting,
    required bool isSuccess,
    required bool isFailure,
  }) : super(
          isSubmitting: false,
          isSuccess: false,
          isFailure: false,
        );
}
