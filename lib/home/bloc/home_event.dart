part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadAlbums extends HomeEvent {
  const LoadAlbums();

  @override
  List<Object> get props => [];
}
