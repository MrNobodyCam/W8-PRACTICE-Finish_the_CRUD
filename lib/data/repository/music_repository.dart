import 'package:w8/model/music.dart';

abstract class MusicRepository {
  Future<Music> addMusic({
    required String title,
    required String artist,
    required String album,
    required int year,
  });
  Future<List<Music>> getMusic();
  Future<String> deleteMusic(String id);
  Future<Music> updateMusic({
    required String id,
    required String title,
    required String artist,
    required String album,
    required int year,
  });
}
