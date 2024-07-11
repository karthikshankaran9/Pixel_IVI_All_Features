import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:pixel_infotainment/commonapi/commonapi.dart';
import 'package:pixel_infotainment/commonapi/constant.dart';
import 'package:pixel_infotainment/general_home_settings/general_home_settings.dart';
import 'package:pixel_infotainment/musicplayer/common/page_favourite.dart';
import 'package:pixel_infotainment/musicplayer/common/page_general_class.dart';
import 'package:pixel_infotainment/musicplayer/common/page_permission_handler.dart';
import 'package:pixel_infotainment/musicplayer/common/page_audio_player_manager.dart';
import 'package:pixel_infotainment/musicplayer/common/page_common_controls_ui.dart';
import 'package:pixel_infotainment/musicplayer/widgethandler/page_albumart.dart';
import 'package:pixel_infotainment/musicplayer/widgethandler/page_progress_bar_manager.dart';
import 'package:pixel_infotainment/musicplayer/widgethandler/page_action_button_handler.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      home: MusicPlayerHomePage(),
    );
  }
}

class MusicPlayerHomePage extends StatefulWidget {
  @override
  _MusicPlayerHomePageState createState() => _MusicPlayerHomePageState();
}

class _MusicPlayerHomePageState extends State<MusicPlayerHomePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _durationTimer;

  PermissionHandler permissionHandler = PermissionHandler();
  AudioPlayerManager audioPlayerManager = AudioPlayerManager();
  FvouriteManager fvouriteManager = FvouriteManager();

  _MusicPlayerHomePageState() {
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _playNext();
      }
    });

    _audioPlayer.currentIndexStream.listen((index) {
      if (index != null && index != currentSongIndex) {
        updateSongAlbumArt();
      }
    });
  }

  Future<void> setPlaylist(List<Mp3File> songList) async {
    final playlist = ConcatenatingAudioSource(
      children: songList.map((song) => AudioSource.file(song.path)).toList(),
    );
    await _audioPlayer.setAudioSource(playlist);
  }

  void updateCurrentSongAlbumArt(Metadata metadata) {
    setState(() {
      globalMetaData = metadata;
      currentSongAlbumArt = AlbumAert(
        metadata: metadata,
        height: albumCurrentSongHeight,
        width: albumCurrentSongtWidth,
      );
    });
  }

  void updatePreviousNextSongAlbumArt(Metadata metadata, bool nextSong) {
    setState(() {
      Widget? albumArt = AlbumAert(
        metadata: metadata,
        height: albumPreviousNextHeight,
        width: albumPreviousNextWidth,
      );
      nextSong ? nextSongAlbumArt = albumArt : previousSongAlbumArt = albumArt;
    });
  }

  void updateSongAlbumArt() {
    currentSongIndex = _audioPlayer.currentIndex!;
    String filePath = currentPlaylist[currentSongIndex].path;

    MetadataRetriever.fromFile(
      File(filePath),
    ).then((metadata) => updateCurrentSongAlbumArt(metadata));

    filePath = currentPlaylist[
            ((currentSongIndex + 1) >= totalSongs) ? 0 : currentSongIndex + 1]
        .path;

    MetadataRetriever.fromFile(
      File(filePath),
    ).then((metadata) => updatePreviousNextSongAlbumArt(metadata, true));

    filePath =
        currentPlaylist[currentSongIndex > 0 ? (currentSongIndex - 1) : 0].path;

    MetadataRetriever.fromFile(
      File(filePath),
    ).then((metadata) => updatePreviousNextSongAlbumArt(metadata, false));
  }

  Future<void> _playNext() async {
    await _audioPlayer.seekToNext();
    updateSongAlbumArt();
  }

  Future<void> _playPrevious() async {
    await _audioPlayer.seekToPrevious();
    updateSongAlbumArt();
  }

  void updateSongInAudioPlayer() async {
    if (orgMp3Files.isEmpty && shuffledPlaylist.isEmpty) return;
    // await _audioPlayer.setFilePath(currentFilePath);
    currentPlaylist = isShuffled ? shuffledPlaylist : orgMp3Files;
    setPlaylist(currentPlaylist);
    updateSongAlbumArt();
    setState(() {
      isSongLoaded = true;
    });
  }

  void browseAlbumFolder() async {
    if (await permissionHandler.isPermissionAllowed()) {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory != null) {
        Directory directory = Directory(selectedDirectory);
        List<FileSystemEntity> files = directory.listSync();
        List<Mp3File> mp3Files = files
            .where((file) => file.path.endsWith('.mp3'))
            .map((file) => Mp3File(file.path, file.path.split('/').last))
            .toList();

        setState(() {
          orgMp3Files = mp3Files;
          totalSongs = orgMp3Files.length;
          updateSongInAudioPlayer();
          // pickSongFromList();
        });
      }
    } else {
      // Handle the case when the permission is denied
      // You can request the permission again or show a dialog to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission to access storage is required.')),
      );
    }
  }

  Future<void> _initAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
  }

  Future<void> playMusic() async {
    setState(() {
      isSongPlaying = true;
    });
    await _audioPlayer.play();
  }

  Future<void> pauseMusic() async {
    setState(() {
      isSongPlaying = false;
    });
    await _audioPlayer.pause();
  }

  Future<void> stopMusic() async {
    await _audioPlayer.stop();
  }

  void onPlay() {
    if (isSongLoaded) {
      if (isSongPlaying) {
        pauseMusic();
      } else {
        playMusic();
      }
    }
  }

  void onStop() {
    stopMusic();
    setState(() {
      isSongPlaying = false;
    });
  }

  void onRepeat() {
    repeatMode = audioPlayerManager.toggleRepeatMode(repeatMode);
    switch (repeatMode) {
      case RepeatMode.none:
      case RepeatMode.repeatdisabled:
        _audioPlayer.setLoopMode(LoopMode.off);
        break;
      case RepeatMode.repeatOne:
        _audioPlayer.setLoopMode(LoopMode.one);
        break;
      case RepeatMode.repeatAll:
        _audioPlayer.setLoopMode(LoopMode.all);
        break;
    }

    setState(() {
      isSongLoaded = true;
    });
  }

  void onFavourite() {
    favouriteIndex = fvouriteManager
        .updateFavouritesong(currentPlaylist[_audioPlayer.currentIndex!]);
    setState(() {
      isSongLoaded = true;
    });
  }

  void onShuffle() {
    setState(() {
      if (!isShuffled) {
        shuffledPlaylist =
            audioPlayerManager.shuffleWithRandomNumber(orgMp3Files);
        isShuffled = true;
      } else {
        isShuffled = false;
        shuffledPlaylist.clear();
      }
    });
    updateSongInAudioPlayer();
  }

  void onForwad() async {
    if (isSongLoaded) {
      if (_audioPlayer.position.inSeconds + 10 <=
          _audioPlayer.duration!.inSeconds) {
        await _audioPlayer
            .seek(Duration(seconds: _audioPlayer.position.inSeconds + 10));
      } else {
        await _audioPlayer.seek(const Duration(seconds: 0));
      }
    }
  }

  void _onLongPressFastForward() {
    if (isSongLoaded) {
      _durationTimer =
          Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (_audioPlayer.position.inSeconds + 1 <=
            _audioPlayer.duration!.inSeconds) {
          _audioPlayer
              .seek(Duration(seconds: _audioPlayer.position.inSeconds + 1));
        }
      });
    }
  }

  void _onLongPressFastForwardEnd(LongPressEndDetails details) {
    setState(() {
      _durationTimer?.cancel();
    });
  }

  void onBackward() async {
    if (isSongLoaded) {
      if (_audioPlayer.position.inSeconds >= 10) {
        await _audioPlayer
            .seek(Duration(seconds: _audioPlayer.position.inSeconds - 10));
      } else {
        await _audioPlayer.seek(const Duration(seconds: 0));
      }
    }
  }

  void _onLongPressFastBackward() {
    if (isSongLoaded) {
      _durationTimer =
          Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (_audioPlayer.position.inSeconds >= 1) {
          _audioPlayer
              .seek(Duration(seconds: _audioPlayer.position.inSeconds - 1));
        }
      });
    }
  }

  void _onLongPressFastBackwardEnd(LongPressEndDetails details) {
    setState(() {
      _durationTimer?.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    permissionHandler.requirePermission();
    _initAudioSession();

    longPressRecognizerForward
      ..onLongPress = _onLongPressFastForward
      ..onLongPressEnd = _onLongPressFastForwardEnd;

    longPressRecognizerBackward
      ..onLongPress = _onLongPressFastBackward
      ..onLongPressEnd = _onLongPressFastBackwardEnd;
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          getImageAsset(
              "Main_BackGround_gradient.png",
              getMusicPlayerImageFolderName(),
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height),

          const GeneralHomeButton(),

          // Album Art
          Container(
            child: currentSongAlbumArt,
          ),

          // Meta data
          Positioned(
            top: 359,
            left: 481,
            child: getMetaDataInfo(globalMetaData),
          ),

          Positioned(
            left: 224,
            top: 318,
            width: 974,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UpdatePreviousNextButton(
                    songAlbumArt: previousSongAlbumArt,
                    onTapFunction: _playPrevious,
                    svgFile: "p_icon_48X48_skip_previous_normal.svg"),
                UpdatePreviousNextButton(
                    songAlbumArt: nextSongAlbumArt,
                    onTapFunction: _playNext,
                    svgFile: "p_icon_48X48_skip_next_normal.svg"),
              ],
            ),
          ),

          // Button Browse
          getPositionedWidget(
              1025,
              100,
              browseAlbumFolder,
              "info_button_browse.svg",
              getMusicPlayerImageFolderName(),
              svgImageWidth,
              svgImageHeight),

          UpdateActionButton(
              onPlay: onPlay,
              onStop: onStop,
              onRepeat: onRepeat,
              onFavourite: onFavourite,
              onShuffle: onShuffle,
              onForwad: onForwad,
              onBackward: onBackward),

          UpdateSongProgress(
            audioPlayer: _audioPlayer,
            isSongLoaded: isSongLoaded,
            isSongPlaying: isSongPlaying,
          ),
        ],
      ),
    );
  }
}
