import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

class Mp3File {
  final String path;
  final String name;

  Mp3File(this.path, this.name);
}

enum RepeatMode {
  none,
  repeatOne,
  repeatAll,
  repeatdisabled,
}

RepeatMode repeatMode = RepeatMode.none;
final LongPressGestureRecognizer longPressRecognizerForward =
    LongPressGestureRecognizer();
final LongPressGestureRecognizer longPressRecognizerBackward =
    LongPressGestureRecognizer();

bool isSongLoaded = false;
bool isSongPlaying = false;
bool isShuffled = false;

int totalSongs = 0;
int currentSongIndex = 0;
int favouriteIndex = 0;
int repeatIndex = 0;
int shuffleIndex = 0;
int skipBackwardIndex = 0;
int skipForwardIndex = 0;
int stopIndex = 0;

List<Mp3File> shuffledPlaylist = [];
List<Mp3File> orgMp3Files = [];
List<Mp3File> currentPlaylist = [];

Widget? currentSongAlbumArt;
Widget? nextSongAlbumArt;
Widget? previousSongAlbumArt;

Metadata globalMetaData = const Metadata();

List<String> favImages = [
  'p_icon_48X48_favourite.svg',
  'p_icon_48X48_favourite_selected.svg',
  'p_icon_48X48_favourite_unselected.svg'
];

List<String> repeatImages = [
  'p_icon_48X48_repeat_off.svg',
  'p_icon_48X48_repeat_once.svg',
  'p_icon_48X48_repeat_all.svg',
  'p_icon_48X48_repeat_disabled.svg'
];

List<String> shuffleImages = [
  'p_icon_48X48_shuffle.svg',
  'p_icon_48X48_shuffle_selected.svg',
  'p_icon_48X48_shuffle_unselected.svg'
];

List<String> skipBackwardImages = [
  'p_icon_48X48_backward.svg',
  'p_icon_48X48_backward_selected.svg',
  'p_icon_48X48_backward_unselected.svg'
];

List<String> skipForwardImages = [
  'p_icon_48X48_forward.svg',
  'p_icon_48X48_forward_selected.svg',
  'p_icon_48X48_forward_unselected.svg'
];

List<String> stopImages = [
  'p_icon_48X48_stop.svg',
  'p_icon_48X48_stop_selected.svg',
  'p_icon_48X48_stop_unselected.svg'
];
