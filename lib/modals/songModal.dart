class SongModel {
  final String artistName;
  final String category;
  final String imageUrl;
  final String songName;
  final String songUrl;

  SongModel({
    required this.artistName,
    required this.category,
    required this.imageUrl,
    required this.songName,
    required this.songUrl,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      artistName: json['artist_name'],
      category: json['category'],
      imageUrl: json['image_url'],
      songName: json['song_name'],
      songUrl: json['song_url'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'artistName': artistName,
      'category': category,
      'imageUrl': imageUrl,
      'songName': songName,
      'songUrl': songUrl,
    };
  }
}
