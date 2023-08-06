import '../modals/songModal.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  late Database _database;

  Future<void> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'flutterVibes.db');

    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
        CREATE TABLE playlists (
          id INTEGER PRIMARY KEY,
          name TEXT
        )
      ''');
          await db.execute('''
        CREATE TABLE songs (
          id INTEGER PRIMARY KEY,
          playlistId INTEGER,
          artistName TEXT,
          category TEXT,
          imageUrl TEXT,
          songName TEXT,
          songUrl TEXT
        )
      ''');
        });
  }

  Future<List<String>> fetchAllPlaylistNames() async {
    final List<Map<String, dynamic>> playlists =
    await _database.query('playlists', columns: ['name']);

    return playlists.map((playlist) => playlist['name'] as String).toList();
  }

  Future<void> insertPlaylist(String name) async {
    await _database.insert('playlists', {'name': name});
  }

  Future<void> insertSong(SongModel song) async {
    await _database.insert('songs', song.toMap());
  }

  Future<List<SongModel>> fetchSongsInPlaylist(int playlistId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'songs',
      where: 'playlistId = ?',
      whereArgs: [playlistId],
    );
    return List.generate(maps.length, (i) {
      return SongModel.fromJson(maps[i]);
    });
  }

  Future<void> deleteSong(int songId) async {
    await _database.delete(
      'songs',
      where: 'id = ?',
      whereArgs: [songId],
    );
  }
}
