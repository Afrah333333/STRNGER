import 'package:flutter/material.dart';
import 'package:quotesapp/screens/player_screen.dart';
import 'package:quotesapp/models/dart/song.dart';

class SoundPage extends StatefulWidget {
  const SoundPage({Key? key}) : super(key: key);

  @override
  State<SoundPage> createState() => _SoundPageState();
}

class _SoundPageState extends State<SoundPage> {
  final List<Song> songs = [
    Song(
      title: "Rain drops",
      musicUrl: "assets/nature.mp3",
      thumbnailImgUrl: "https://hips.hearstapps.com/hmg-prod/images/its-raining-heavily-wearing-an-umbrella-during-the-royalty-free-image-1660153348.jpg",
    ),
    Song(
      title: "Forest",
      musicUrl: "assets/meditative-rain-114484.mp3",
      thumbnailImgUrl: "https://hips.hearstapps.com/hmg-prod/images/its-raining-heavily-wearing-an-umbrella-during-the-royalty-free-image-1660153348.jpg",
    ),
    Song(
      title: "Wind",
      musicUrl: "assets/nature.mp3",
      thumbnailImgUrl: "https://hips.hearstapps.com/hmg-prod/images/its-raining-heavily-wearing-an-umbrella-during-the-royalty-free-image-1660153348.jpg",
    ),
    Song(
      title: "Birds",
      musicUrl: "assets/meditative-rain-114484.mp3",
      thumbnailImgUrl: "https://img.freepik.com/free-photo/colorful-bird-with-yellow-beak-sits-pink-flower_1340-38643.jpg",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        title: const Text("Music Player"),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlayerScreen(
                    song: song,
                  ),
                ),
              );
            },
            child: Container(
              width: 200, // Adjust the width as needed
              margin: const EdgeInsets.all(5),
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: Colors.deepPurple.shade200,
                  borderRadius: BorderRadius.circular(20.0)
              ),
              child: Row(
                children: [
                  Image.network(
                    song.thumbnailImgUrl,
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 5,),
                  Text(song.title,
                    style: TextStyle(fontSize: 15),),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
