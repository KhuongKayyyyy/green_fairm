import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:green_fairm/core/constant/app_setting.dart';
import 'package:green_fairm/core/validator/validator.dart';
import 'package:green_fairm/data/res/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository = UserRepository();
  final storage = const FlutterSecureStorage();
  LoginBloc() : super(const LoginInitial()) {
    on<LoginEventEmailChanged>(_onEmailChanged);
    on<LoginEventPasswordChanged>(_onPasswordChanged);
    on<LoginEventWithEmailAndPasswordPressed>(_onLoginWithCredentials);
    on<LoginEventWithGooglePressed>(_onLoginWithGoogle);
  }

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    super.onTransition(transition);
    if (kDebugMode) {
      print(transition);
    }
  }

  FutureOr<void> _onEmailChanged(
      LoginEventEmailChanged event, Emitter<LoginState> emit) {
    emit(state.cloneWith(isEmailValid: Validator.isValidEmail(event.email)));
  }

  FutureOr<void> _onPasswordChanged(
      LoginEventPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.cloneWith(
        isPasswordValid: Validator.isValidPassword(event.password)));
  }

  Future<void> _onLoginWithCredentials(
    LoginEventWithEmailAndPasswordPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    try {
      await _userRepository.signInWithEmailAndPassword(
        event.email,
        event.password,
      );
      emit(const LoginSuccess());
    } catch (e) {
      String errorMessage = 'An unknown error occurred';
      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? 'An unknown error occurred';
      }
      print("Error signing in with email and password: $errorMessage");
      emit(LoginFailure(errorMessage));
    }
  }

  Future<void> _onLoginWithGoogle(
      LoginEventWithGooglePressed event, Emitter<LoginState> emit) async {
    emit(const LoginLoading());
    try {
      final userCredential = await _userRepository.signInWithGoogle();
      print(userCredential);
      await storage.write(key: AppSetting.userUid, value: userCredential.uid);
      emit(const LoginSuccess());
      // emit(state.cloneWith(isSuccess: true));
    } catch (e) {
      // emit(state.cloneWith(isFailure: true));
      print("Error signing in with Google: $e");
      if (e == "Null check operator used on a null value") {
        emit(const LoginFailure("Sign in with Google failed"));
      }
      emit(LoginFailure(e.toString()));
    }
  }
}
