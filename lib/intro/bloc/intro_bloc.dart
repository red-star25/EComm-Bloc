import 'package:bloc/bloc.dart';
import 'package:ecomm/data/sharedprefs/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  IntroBloc() : super(IntroInitial()) {
    on<IntroStarted>((event, emit) async {
      final _prefs = await SharedPreferences.getInstance();
      if (_prefs.getBool(Preferences.is_new_user) == false) {
        emit(IntroSuccessful());
      }
    });
    on<IntroFinished>((event, emit) async {
      final _prefs = await SharedPreferences.getInstance();
      await _prefs
          .setBool(Preferences.is_new_user, false)
          .then((value) => emit(IntroSuccessful()));
    });
  }
}
