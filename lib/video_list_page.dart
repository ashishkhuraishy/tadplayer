import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'constants.dart';
import 'video_page.dart';

class VideoListPage extends StatelessWidget {
  final String albumName;
  final List<AssetEntity> videos;

  const VideoListPage({
    Key? key,
    required this.albumName,
    required this.videos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(albumName),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 1.5,
        ),
        itemCount: videos.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var video = videos[index];

          return GestureDetector(
            onTap: () async {
              log('Clicked');
              var path = await video.relativePath;
              if (path == null) return;

              var vidPath = '/storage/emulated/0/$path${video.title}';
              log(vidPath);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerPage(
                    media: vidPath,
                  ),
                ),
              );
            },
            child: VideoWidget(video: video),
          );
        },
      ),
    );
  }
}

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    Key? key,
    required this.video,
  }) : super(key: key);

  final AssetEntity video;

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  Uint8List? thumbData;

  @override
  void initState() {
    super.initState();

    loadThumbNail();
  }

  loadThumbNail() async {
    thumbData = await widget.video.thumbData;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var video = widget.video;
    var title = video.title ?? 'unknown';

    var duration =
        video.videoDuration.toString().split('.').first.padLeft(8, "0");

    return Container(
      padding: EdgeInsets.all(4),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: MemoryImage(
                  thumbData ?? kPlaceHolder,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2),
                    topRight: Radius.circular(2),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                padding: EdgeInsets.all(1),
                child: Text(
                  duration,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: Colors.white70),
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
