import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:quotesapp/models/dart/song.dart';

class PlayerScreen extends StatefulWidget {
  final Song song;

  const PlayerScreen({Key? key, required this.song}) : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final player = AudioPlayer();
  bool loaded = false;

  Future<void> loadMusic() async {
    var timeplay=await player.setAsset(widget.song.musicUrl);
    print(timeplay);
    await player.load();
    setState(() {
      loaded = true;
    });
  }

  Future<void> playPauseMusic() async {
    if (player.playing) {
      await player.pause();
    } else {
      await player.play();
    }
  }

  @override
  void initState() {
    super.initState();
    loadMusic();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: Text(
          widget.song.title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Spacer(flex: 2),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              widget.song.thumbnailImgUrl,
              height: 350,
              width: 350,
              fit: BoxFit.cover,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: FutureBuilder<void>(
              future: player.load(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return StreamBuilder<Duration>(
                    stream: player.positionStream,
                    builder: (context, snapshot1) {
                      final Duration? duration = snapshot1.data;
                      if (duration == null) {
                        return CircularProgressIndicator();
                      }
                      return StreamBuilder<Duration>(
                        stream: player.bufferedPositionStream,
                        builder: (context, snapshot2) {
                          final Duration? bufferedDuration = snapshot2.data;
                          if (bufferedDuration == null) {
                            return CircularProgressIndicator();
                          }
                          return SizedBox(
                            height: 30,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: ProgressBar(
                                progress: duration,
                                total: player.duration ?? const Duration(seconds: 0),
                                buffered: bufferedDuration,
                                timeLabelPadding: -1,
                                timeLabelTextStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                progressBarColor: Colors.black,
                                baseBarColor: Colors.grey[200],
                                bufferedBarColor: Colors.grey[350],
                                thumbColor: Colors.black,
                                onSeek: loaded
                                    ? (duration) async {
                                  await player.seek(duration);
                                }
                                    : null,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("Error loading audio: ${snapshot.error}");
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: loaded
                    ? () async {
                  if (player.position.inSeconds + 10 <=
                      player.duration!.inSeconds) {
                    await player.seek(
                        Duration(seconds: player.position.inSeconds + 10));
                  } else {
                    await player.seek(const Duration(seconds: 0));
                  }
                }
                    : null,
                icon: const Icon(Icons.fast_forward_rounded),
              ),

              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: IconButton(
                  onPressed: loaded
                      ? () {
                    playPauseMusic();
                  }
                      : null,
                  icon: Icon(
                    player.playing ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: loaded
                    ? () async {
                  if (player.position.inSeconds + 10 <=
                      player.duration!.inSeconds) {
                    await player.seek(
                        Duration(seconds: player.position.inSeconds + 10));
                  } else {
                    await player.seek(const Duration(seconds: 0));
                  }
                }
                    : null,
                icon: const Icon(Icons.fast_forward_rounded),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}

