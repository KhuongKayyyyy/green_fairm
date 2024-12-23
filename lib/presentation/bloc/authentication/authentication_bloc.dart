import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_fairm/data/res/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationInitial()) {
    on<AuthenticationEventStarted>(_onAuthenticationStarted);
    on<AuthenticationEventLoggedIn>(_onAuthenticationLoggedIn);
    on<AuthenticationEventLoggedOut>(_onAuthenticationLoggedOut);
  }

  // Handler for AuthenticationEventStarted
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

  // Handler for AuthenticationEventLoggedIn
  Future<void> _onAuthenticationLoggedIn(AuthenticationEventLoggedIn event,
      Emitter<AuthenticationState> emit) async {
    final user = await userRepository.getUser();
    emit(AuthenticationSuccess(user!));
  }

  // Handler for AuthenticationEventLoggedOut
  Future<void> _onAuthenticationLoggedOut(AuthenticationEventLoggedOut event,
      Emitter<AuthenticationState> emit) async {
    userRepository.signOut();
    emit(const AuthenticationFailure("Logged out"));
  }
}
