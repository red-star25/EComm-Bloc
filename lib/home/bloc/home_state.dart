part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  HomeLoaded({required this.products});
  final Stream<List<Product>> products;
}

class HomeFavUpdated extends HomeState {}

class HomeError extends HomeState {
  HomeError({required this.error});
  final String error;
}
