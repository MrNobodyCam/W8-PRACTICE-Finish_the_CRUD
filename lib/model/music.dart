class Music {
  final String id;
  final String title;
  final String artist;
  final String album;
  final int year;

  Music({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.year,
  });
  @override
  bool operator ==(Object other) {
    return other is Music && other.id == id;
  }

  @override
  int get hashCode => super.hashCode ^ id.hashCode;
  @override
  String toString() {
    return 'Music(title: $id, artist: $artist, album: $album, year: $year)';
  }
}
