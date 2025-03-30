import '../../model/music.dart';

class MusicDto {
  static Music fromJson(String id, Map<String, dynamic> json) {
    return Music(
      id: id,
      title: json['title'],
      artist: json['artist'],
      album: json['album'],
      year: json['year'],
    );
  }

  static Map<String, dynamic> toJson(Music music) {
    return {
      'title': music.title,
      'artist': music.artist,
      'album': music.album,
      'year': music.year,
    };
  }
}
