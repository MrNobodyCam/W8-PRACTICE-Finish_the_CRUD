import 'package:flutter/material.dart';

import '../../data/repository/music_repository.dart';
import '../../model/music.dart';
import 'async_value.dart';

class MusicProvider extends ChangeNotifier {
  final MusicRepository _repository;
  AsyncValue<List<Music>>? musicState;

  MusicProvider(this._repository) {
    fetchMusic();
  }

  bool get isLoading =>
      musicState != null && musicState!.state == AsyncValueState.loading;
  bool get hasData =>
      musicState != null && musicState!.state == AsyncValueState.success;

  void fetchMusic() async {
    try {
      musicState = AsyncValue.loading();
      notifyListeners();

      musicState = AsyncValue.success(await _repository.getMusic());
    } catch (error) {
      musicState = AsyncValue.error(error);
    }

    notifyListeners();
  }

  void addMusic(String title, String artist, String album, int year) async {
    await _repository.addMusic(
      title: title,
      artist: artist,
      album: album,
      year: year,
    );

    fetchMusic();
  }

  void deleteMusic(String id) async {
    await _repository.deleteMusic(id);
    fetchMusic();
  }

  void updateMusic(Music music) async {
    await _repository.updateMusic(
      id: music.id,
      title: music.title,
      artist: music.artist,
      album: music.album,
      year: music.year,
    );
    fetchMusic();
  }
}
