import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

import '../video_list_page.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TADPlayer'),
        elevation: 0,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeSucessState) {
            return AlbumGrid(
              assets: state.assets,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class AlbumGrid extends StatelessWidget {
  const AlbumGrid({
    Key? key,
    required this.assets,
  }) : super(key: key);

  final List<AssetPathEntity> assets;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
      itemCount: assets.length,
      itemBuilder: (context, index) {
        var asset = assets[index];
        return GestureDetector(
          onTap: () async {
            var videos = await asset.assetList;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoListPage(
                  albumName: asset.name,
                  videos: videos,
                ),
              ),
            );
          },
          child: AlbumWidget(
            asset: asset,
          ),
        );
      },
    );
  }
}

class AlbumWidget extends StatelessWidget {
  const AlbumWidget({
    Key? key,
    required this.asset,
  }) : super(key: key);

  final AssetPathEntity asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(
            Icons.folder,
            size: 100,
          ),
          Expanded(
            child: Text(
              asset.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
