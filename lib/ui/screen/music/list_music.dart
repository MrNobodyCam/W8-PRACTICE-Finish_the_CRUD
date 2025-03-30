import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w8/ui/screen/widget/input/input_music.dart';

import '../../../model/music.dart';
import '../widget/error/error.dart';
import '../../provider/music_provider.dart';

class ListMusic extends StatelessWidget {
  const ListMusic({super.key});

  void _onAddPressed(BuildContext context) {
    final MusicProvider musicProvider = context.read<MusicProvider>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InputMusic(title: "Add", isEditMode: false),
      ),
    );
    musicProvider.fetchMusic();
  }

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);

    Widget content = Text('');
    if (musicProvider.isLoading) {
      content = CircularProgressIndicator();
    } else if (musicProvider.hasData) {
      List<Music> musicList = musicProvider.musicState!.data!;

      if (musicList.isEmpty) {
        content = Error();
      } else {
        content = ListView.builder(
          itemCount: musicList.length,
          itemBuilder:
              (context, index) => ListTile(
                title: Text(musicList[index].title),
                subtitle: Text(
                  "${musicList[index].artist} - ${musicList[index].album} - ${musicList[index].year}",
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed:
                      () => {musicProvider.deleteMusic(musicList[index].id)},
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => InputMusic(
                            title: "Edit",
                            music: musicList[index],
                            isEditMode: true,
                          ),
                    ),
                  );
                },
              ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => _onAddPressed(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(child: content),
    );
  }
}
