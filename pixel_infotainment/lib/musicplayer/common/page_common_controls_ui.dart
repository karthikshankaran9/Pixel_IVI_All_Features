import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

String getMusicPlayerImageFolderName() {
  return "assets/images/musicplayer";
}

Widget getSongMetaDataText(String? value, double? fontsize) {
  return Text(value ?? "",
      style: TextStyle(
        fontSize: fontsize,
        color: Colors.white,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.bold,
      ));
}

Widget getMetaDataInfo(Metadata metadata) {
  // metadata.trackArtistNames?.add("test text");
  if (metadata != null) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        getSongMetaDataText(metadata.trackName ?? "", 22),
        SizedBox(
          height: 15,
        ),
        // Text(
        //   metadata.trackArtistNames != null
        //       ? '${metadata.trackArtistNames}'
        //       : "",
        //   style: const TextStyle(
        //     fontSize: 12,
        //     color: Colors.white,
        //     fontFamily: 'Urbanist',
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        // getSongMetaDataText(metadata.trackArtistNames ?? ""),
        getSongMetaDataText(metadata.albumName ?? "", 12),
        getSongMetaDataText(metadata.albumArtistName ?? "", 12),
        // getSongMetaDataText(metadata.trackNumber.toString()),
        // getSongMetaDataText(metadata.albumLength.toString()),
        getSongMetaDataText(
            metadata.year != null ? metadata.year.toString() : "", 12),
        getSongMetaDataText(metadata.authorName ?? "", 12),
        // getSongMetaDataText(metadata.genre.toString()),
        // getSongMetaDataText(metadata.writerName.toString()),
        // getSongMetaDataText(metadata.discNumber.toString()),
        // getSongMetaDataText(metadata.filePath.toString()),
      ],
    );
  } else {
    return const Text("");
  }
}