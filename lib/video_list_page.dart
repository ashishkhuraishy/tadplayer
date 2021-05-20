import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';

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
          maxCrossAxisExtent: 150,
          crossAxisSpacing: 0.5,
        ),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          var video = videos[index];

          return ListTile(
            title: VideoWidget(video: video),
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
    thumbData = await _loadPlaceholder();
    setState(() {});

    thumbData = await widget.video.thumbData;
    setState(() {});
  }

  Future<Uint8List> _loadPlaceholder() async {
    final byteData = await rootBundle.load('assets/black_placeholder.jpeg');

    return byteData.buffer.asUint8List(
      byteData.offsetInBytes,
      byteData.lengthInBytes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: thumbData == null
              ? CircularProgressIndicator()
              : Image.memory(
                  thumbData ?? Uint8List(10),
                  fit: BoxFit.cover,
                ),
        ),
        Expanded(
          child: Text(
            widget.video.title ?? 'unknown',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ],
    );
  }
}
