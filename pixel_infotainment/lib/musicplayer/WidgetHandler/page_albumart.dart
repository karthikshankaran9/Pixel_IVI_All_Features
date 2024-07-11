import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

class AlbumAert extends StatelessWidget {
  final Metadata metadata;
  final double height;
  final double width;
  const AlbumAert(
      {required this.metadata,
      required this.height,
      required this.width,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        metadata.albumArt == null
            ? Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height >
                        MediaQuery.of(context).size.width
                    ? MediaQuery.of(context).size.width
                    : 256.0,
                width: MediaQuery.of(context).size.height >
                        MediaQuery.of(context).size.width
                    ? MediaQuery.of(context).size.width
                    : 256.0,
                child: const Text('null'),
              )
            : Image.memory(
                metadata.albumArt!,
                height: MediaQuery.of(context).size.height >
                        MediaQuery.of(context).size.width
                    ? MediaQuery.of(context).size.width
                    : height,
                width: MediaQuery.of(context).size.height >
                        MediaQuery.of(context).size.width
                    ? MediaQuery.of(context).size.width
                    : width,
              ),
      ],
    );
  }
}
