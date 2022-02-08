import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecomm/auth/auth.dart';
import 'package:ecomm/data/repository/app_repository.dart';
import 'package:ecomm/data/sharedprefs/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository, required this.appRepository})
      : super(UnAuthenticated()) {
    // When User Presses the SignIn Button, we will send the SignInRequested Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    on<SignInRequested>(_signInUser);
    // When User Presses the SignUp Button, we will send the SignUpRequest Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    on<SignUpRequested>(_signUpUser);
    // When User Presses the Google Login Button, we will send the GoogleSignInRequest Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    on<GoogleSignInRequested>(_signInWithGoogle);
    // When User Presses the SignOut Button, we will send the SignOutRequested Event to the AuthBloc to handle it and emit the UnAuthenticated State
  }
  final AuthRepository authRepository;
  final AppRepository appRepository;

  FutureOr<void> _signInUser(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(Loading());
    try {
      await authRepository
          .signIn(
        email: event.email,
        password: event.password,
      )
          .then((uId) async {
        final _prefs = await SharedPreferences.getInstance();
        await _prefs.setString(Preferences.user_id, uId!);
        await _prefs.setBool(Preferences.is_logged_in, true);
        appRepository.setUserId = uId;
      }).then((value) {
        emit(Authenticated());
      });
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  FutureOr<void> _signUpUser(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(Loading());
    try {
      await authRepository.signUp(
        email: event.email,
        password: event.password,
        userName: event.userName,
      );
      final _prefs = await SharedPreferences.getInstance();
      await _prefs.setBool(Preferences.is_logged_in, true).then((value) {
        emit(Authenticated());
      });
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  FutureOr<void> _signInWithGoogle(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(Loading());
    try {
      await authRepository.signInWithGoogle().then((uId) async {
        if (uId != null) {
          final _prefs = await SharedPreferences.getInstance();
          await _prefs.setString(Preferences.user_id, uId);
          await _prefs.setBool(Preferences.is_logged_in, true);
          appRepository.setUserId = uId;
        }
      });
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }
}
