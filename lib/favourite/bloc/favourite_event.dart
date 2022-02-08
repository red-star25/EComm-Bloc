part of 'favourite_bloc.dart';

@immutable
abstract class FavouriteEvent {}

class FavouriteEventFetch extends FavouriteEvent {}

class FavouriteEventRemove extends FavouriteEvent {
  FavouriteEventRemove({
    required this.id,
    required this.context,
  });
  final String id;
  final BuildContext context;
}
