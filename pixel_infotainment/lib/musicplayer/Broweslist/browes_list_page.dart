import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Browselist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 237,
            left: 165,
            width: 420,
            height: 490,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Album',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Divider(color: Colors.white.withOpacity(0.5)),
                _buildMenuItem(
                    'assets/images/musicplayer/s_icon_64X64_album.svg',
                    'Album',
                    true),
                _buildMenuItem(
                    'assets/images/musicplayer/s_icon_64X64_artist.svg',
                    'Artist',
                    false),
                _buildMenuItem(
                    'assets/images/musicplayer/s_icon_64X64_song.svg',
                    'Song',
                    false),
                _buildMenuItem(
                    'assets/images/musicplayer/s_icon_64X64_foalder.svg',
                    'Folder',
                    false),
                _buildMenuItem(
                    'assets/images/musicplayer/s_icon_64X64_favourite.svg',
                    'Favourite',
                    false),
              ],
            ),
          ),
          Positioned(
            top: 240,
            left: 601,
            width: 635,
            height: 492,
            child: ListView(
              children: List.generate(7, (index) {
                return _buildSongItem('Name of the Song in Year 2023');
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String iconPath, String label, bool isActive) {
    return Container(
      color: isActive ? Colors.blue : Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            color: isActive ? Colors.white : Colors.grey,
            width: 30,
            height: 30,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSongItem(String songName) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/musicplayer/s_icon_64X64_song.svg',
                color: Colors.white,
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 10),
              Text(
                songName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SvgPicture.asset(
            'assets/images/musicplayer/p_icon_48X48_fav_remove1.svg',
            color: Colors.white,
            width: 30,
            height: 30,
          ),
        ],
      ),
    );
  }
}
