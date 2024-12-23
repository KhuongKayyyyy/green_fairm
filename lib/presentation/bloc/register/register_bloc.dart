import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:green_fairm/core/validator/validator.dart';
import 'package:green_fairm/data/res/user_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository = UserRepository();
  RegisterBloc() : super(const RegisterInitial()) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterEventPressed>(_onRegisterPressed);
  }

  FutureOr<void> _onEmailChanged(
      RegisterEmailChanged event, Emitter<RegisterState> emit) {
    // emit(state.cloneWith(isEmailValid: Validator.isValidEmail(event.email)));
  }

  FutureOr<void> _onPasswordChanged(
      RegisterPasswordChanged event, Emitter<RegisterState> emit) {
    // emit(state.cloneWith(
    //     isPasswordValid: Validator.isValidPassword(event.password)));
  }

  Future<void> _onRegisterPressed(
      RegisterEventPressed event, Emitter<RegisterState> emit) async {
    emit(const RegisterLoading());
    try {
      final userCredential =
          await _userRepository.createUserWithEmailAndPassword(
              event.email, event.username, event.password);
      emit(RegisterSuccess(userCredential: userCredential));
    } catch (e) {
      String errorMessage = 'An unknown error occurred';
      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? 'An unknown error occurred';
      }
      emit(RegisterFailure(errorMessage: errorMessage));
    }
    // finally {
    //   emit(state.cloneWith(isSubmitting: false));
    // }
  }
}
