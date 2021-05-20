import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is LoadAlbums) {
      /// Checking wheather the user gave enough permissions
      /// to read and write the local storage
      var permitted = await PhotoManager.requestPermission();

      if (!permitted) {
        /// TODO: handle error event when the user denies
        /// storage permission
        log('permission denied');
        return;
      }

      var assets = await PhotoManager.getAssetPathList(
        type: RequestType.video,
      );

      yield HomeSucessState(assets);
    }
  }
}
