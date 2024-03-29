import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class youtube_player extends StatefulWidget {
  String youtube;
  youtube_player({Key? key, required this.youtube}) : super(key: key);

  @override
  State<youtube_player> createState() => _youtube_playerState(this.youtube);
}

class _youtube_playerState extends State<youtube_player> {
  _youtube_playerState(this.youtube);
  final String youtube;
  late YoutubePlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(youtube);

    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(youtube)!,
        flags:
            const YoutubePlayerFlags(mute: false, loop: false, autoPlay: true));
  }

  @override
  void deactivate() {
    controller.pause();
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => YoutubePlayerBuilder(
      player: YoutubePlayer(controller: controller),
      builder: (context, player) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.amber,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Navigate back to previous screen
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            body: ListView(
              children: [
                player,
              ],
            ),
          ));
}
