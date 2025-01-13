import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:green_fairm/core/constant/app_setting.dart';
import 'package:green_fairm/data/res/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository = UserRepository();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEventStarted>(_onAuthenticationStarted);
    on<AuthenticationEventLoggedIn>(_onAuthenticationLoggedIn);
    on<AuthenticationEventLoggedOut>(_onAuthenticationLoggedOut);
    on<AuthenticationEventUpdateUserName>(_onAuthenticationUpdateUserName);
    on<AuthenticationEventUpdatePassword>(_onAuthenticationUpdatePassword);
    on<AuthenticationEventDeleteAccount>(_onAuthenticationDeleteAccount);
  }

  Future<void> _onAuthenticationStarted(AuthenticationEventStarted event,
      Emitter<AuthenticationState> emit) async {
    final isSignedIn = await userRepository.isSignedIn();
    if (isSignedIn) {
      final user = await userRepository.getUser();
      emit(AuthenticationSuccess(user!));
    } else {
      emit(const AuthenticationFailure("Not logged in"));
    }
  }

  Future<void> _onAuthenticationLoggedIn(AuthenticationEventLoggedIn event,
      Emitter<AuthenticationState> emit) async {
    final user = await userRepository.getUser();
    emit(AuthenticationSuccess(user!));
  }

  Future<void> _onAuthenticationLoggedOut(AuthenticationEventLoggedOut event,
      Emitter<AuthenticationState> emit) async {
    userRepository.signOut();
    emit(const AuthenticationFailure("Logged out"));
  }

  Future<void> _onAuthenticationUpdateUserName(
      AuthenticationEventUpdateUserName event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      // await userRepository.updateUsername(name: event.displayName);
      User user = FirebaseAuth.instance.currentUser!;
      await user.updateDisplayName(event.displayName);
      final userId =
          await const FlutterSecureStorage().read(key: AppSetting.userUid);
      await userRepository.updateUsernameToServer(
          userId: userId ?? "", username: event.displayName);
      emit(AuthenticationUpdateProfileSuccess(
          FirebaseAuth.instance.currentUser!));
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }

  Future<void> _onAuthenticationUpdatePassword(
      AuthenticationEventUpdatePassword event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      User user = FirebaseAuth.instance.currentUser!;
      await user.updatePassword(event.password);
      final userId =
          await const FlutterSecureStorage().read(key: AppSetting.userUid);
      await userRepository.updatePassordToServer(
          userId: userId ?? "",
          password: event.password,
          oldPassword: event.oldPassword);
      emit(AuthenticationUpdateProfileSuccess(user));
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }

  Future<void> _onAuthenticationDeleteAccount(
      AuthenticationEventDeleteAccount event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      await userRepository.deleteAccount();
      emit(AuthenticationDeleteAccountSuccess());
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }
}
