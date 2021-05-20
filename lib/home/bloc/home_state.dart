part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeSucessState extends HomeState {
  final List<AssetPathEntity> assets;

  const HomeSucessState(this.assets);

  @override
  List<Object> get props => [assets];
}

class HomeErrorState extends HomeState {
  final String error;

  const HomeErrorState(this.error);

  @override
  List<Object> get props => [error];
}
