import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../model/music.dart';
import '../dto/music_dto.dart';
import 'music_repository.dart';

class MusicFirebaseRepository extends MusicRepository {
  final String baseUrl;
  String musicCollection;
  MusicFirebaseRepository({
    required this.baseUrl,
    required this.musicCollection,
  });

  @override
  Future<List<Music>> getMusic() async {
    Uri uri = Uri.parse('$baseUrl/$musicCollection.json');
    final http.Response response = await http.get(uri);
    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to load');
    }
    final data = json.decode(response.body) as Map<String, dynamic>?;

    if (data == null) return [];
    return data.entries
        .map((entry) => MusicDto.fromJson(entry.key, entry.value))
        .toList();
  }

  @override
  Future<Music> addMusic({
    required String title,
    required String artist,
    required String album,
    required int year,
  }) async {
    Uri uri = Uri.parse('$baseUrl/$musicCollection.json');
    final newMusicData = {
      'title': title,
      'artist': artist,
      'album': album,
      'year': year,
    };
    final http.Response response = await http.post(
      uri,
      body: json.encode(newMusicData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to add music');
    }
    final newId = json.decode(response.body)['name'];
    return Music(
      id: newId,
      title: title,
      artist: artist,
      album: album,
      year: year,
    );
  }

  @override
  Future<String> deleteMusic(String id) async {
    Uri uri = Uri.parse('$baseUrl/$musicCollection/$id.json');
    final http.Response response = await http.delete(uri);
    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to delete music');
    }
    return id;
  }

  @override
  Future<Music> updateMusic({
    required String id,
    required String title,
    required String artist,
    required String album,
    required int year,
  }) async {
    Uri uri = Uri.parse('$baseUrl/$musicCollection/$id.json');
    final updatedMusicData = {
      'title': title,
      'artist': artist,
      'album': album,
      'year': year,
    };
    final http.Response response = await http.put(
      uri,
      body: json.encode(updatedMusicData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to update music');
    }
    return Music(
      id: id,
      title: title,
      artist: artist,
      album: album,
      year: year,
    );
  }
}
