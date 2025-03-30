import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/repository/music_firebase_repository.dart';
import 'data/repository/music_repository.dart';
import 'ui/provider/music_provider.dart';
import 'ui/screen/music/list_music.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListMusic();
  }
}

void main() async {
  final MusicRepository musicRepository = MusicFirebaseRepository(
    baseUrl:
        'https://w8-assignment-default-rtdb.asia-southeast1.firebasedatabase.app/',
    musicCollection: 'music',
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => MusicProvider(musicRepository),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: const App()),
    ),
  );
}
