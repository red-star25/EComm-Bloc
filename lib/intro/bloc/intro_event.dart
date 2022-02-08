part of 'intro_bloc.dart';

@immutable
abstract class IntroEvent {}

class IntroStarted extends IntroEvent {}

class IntroFinished extends IntroEvent {}
