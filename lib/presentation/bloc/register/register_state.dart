part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const RegisterState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  @override
  List<Object> get props =>
      [isEmailValid, isPasswordValid, isSubmitting, isSuccess, isFailure];

  // Method to check if email and password are valid
  bool get isValidEmailAndPassword => isEmailValid && isPasswordValid;

  // Method to clone the state with updated properties
  RegisterState copyWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return this is RegisterInitial
        ? const RegisterInitial()
        : this is RegisterLoading
            ? const RegisterLoading()
            : this is RegisterFailure
                ? RegisterFailure(
                    errorMessage: (this as RegisterFailure).errorMessage)
                : RegisterSuccess(
                    userCredential: (this as RegisterSuccess)
                        .userCredential); // Fallback to RegisterSuccess
  }
}

// Different states extending RegisterState
final class RegisterInitial extends RegisterState {
  const RegisterInitial()
      : super(
            isEmailValid: true,
            isPasswordValid: true,
            isSubmitting: false,
            isSuccess: false,
            isFailure: false);
}

final class RegisterLoading extends RegisterState {
  const RegisterLoading()
      : super(
            isEmailValid: true,
            isPasswordValid: true,
            isSubmitting: true,
            isSuccess: false,
            isFailure: false);
}

final class RegisterFailure extends RegisterState {
  final String errorMessage;
  const RegisterFailure({this.errorMessage = "An unknown error occurred"})
      : super(
            isEmailValid: true,
            isPasswordValid: true,
            isSubmitting: false,
            isSuccess: false,
            isFailure: true);
}

final class RegisterSuccess extends RegisterState {
  final UserCredential userCredential;
  const RegisterSuccess({required this.userCredential})
      : super(
            isEmailValid: true,
            isPasswordValid: true,
            isSubmitting: false,
            isSuccess: true,
            isFailure: false);
}
