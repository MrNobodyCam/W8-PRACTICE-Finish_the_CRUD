import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/music.dart';
import '../../../provider/music_provider.dart' show MusicProvider;

class InputMusic extends StatefulWidget {
  const InputMusic({
    super.key,
    required this.title,
    this.music,
    this.isEditMode = false,
  });

  final String title;
  final Music? music;
  final bool isEditMode;

  @override
  State<InputMusic> createState() => _InputMusicState();
}

class _InputMusicState extends State<InputMusic> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _artistController;
  late final TextEditingController _albumController;
  late final TextEditingController _yearController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.music?.title);
    _artistController = TextEditingController(text: widget.music?.artist);
    _albumController = TextEditingController(text: widget.music?.album);
    _yearController = TextEditingController(
      text: widget.music?.year.toString(),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _albumController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void validateAndSave() {
    if (_formKey.currentState!.validate()) {
      final String title = _titleController.text;
      final String artist = _artistController.text;
      final String album = _albumController.text;
      final int year = int.tryParse(_yearController.text) ?? 0;

      print(
        'Music Data:'
        '\nTitle: $title'
        '\nArtist: $artist'
        '\nAlbum: $album'
        '\nYear: $year',
      );
      final musicProvider = Provider.of<MusicProvider>(context, listen: false);
      if (widget.isEditMode) {
        Music music = Music(
          id: widget.music?.id ?? '',
          title: title,
          artist: artist,
          album: album,
          year: year,
        );
        musicProvider.updateMusic(music);
      } else {
        musicProvider.addMusic(title, artist, album, year);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.title} Music')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title cannot be empty';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Artist'),
                controller: _artistController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Artist cannot be empty';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Album'),
                controller: _albumController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Album cannot be empty';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Year'),
                controller: _yearController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Year cannot be empty';
                  }
                  final int? year = int.tryParse(value);
                  if (year == null || year <= 1920) {
                    return 'Year must be a positive number and greater than 1920';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: validateAndSave,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
