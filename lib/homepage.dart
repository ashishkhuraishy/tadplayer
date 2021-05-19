import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TADPlayer'),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            var res = await PhotoManager.requestPermission();
            if (!res) return;

            log('access permission');

            var files = await PhotoManager.getAssetPathList(
              type: RequestType.video,
            );

            log(files.length.toString());

            files.forEach((element) async {
              var assets = await element.assetList;
              assets.forEach((asset) {
                print(element.name + "\t" + (asset.title ?? "some title"));
              });
            });
          },
          child: Text('request permission'),
        ),
      ),
    );
  }
}
