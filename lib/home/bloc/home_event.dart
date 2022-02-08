part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeEventFetch extends HomeEvent {}

class HomeEventFavourite extends HomeEvent {
  HomeEventFavourite({
    required this.id,
    required this.isFavourite,
    required this.notifyUpdateIsFavourite,
    required this.context,
  });
  final String id;
  final bool isFavourite;
  final VoidCallback notifyUpdateIsFavourite;
  final BuildContext context;
}

class HomeEventLogout extends HomeEvent {
  HomeEventLogout(this.context);

  final BuildContext context;
}
