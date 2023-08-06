import 'package:FlutterVibes/getController/auth/popMenuController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modals/songModal.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _database;

  initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'flutterVibes.db');

    await openDatabase(path, version: 1,
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
    }).then((value) {
      _database = value;
      debugPrint("Databse created");
    });
  }

   fetchAllPlaylistNames() async {
    await initDatabase();
    final List<Map<String, dynamic>> playlists =
        await _database!.query('playlists', columns: ['name']);
print("------playlist :${playlists}");
final popController = Get.put(PopMenuBarController());

    final mylist=await playlists.map((playlist) => playlist['name'] as String).toList();
    popController.playListNamesList.value=mylist;
    popController.selectedPlayListBoolValue.value=List.generate(mylist.length, (index) => false);
    return popController;
  }

  Future<void> createPlaylist(String name) async {
    await initDatabase();

    await _database!.insert('playlists', {'name': name});
  }

  Future<void> insertSong(SongModel song) async {
    await initDatabase();

    await _database!.insert('songs', song.toMap());
  }

  Future<List<SongModel>> fetchSongsInPlaylist(int playlistId) async {
    await initDatabase();

    final List<Map<String, dynamic>> maps = await _database!.query(
      'songs',
      where: 'playlistId = ?',
      whereArgs: [playlistId],
    );
    return List.generate(maps.length, (i) {
      return SongModel.fromJson(maps[i]);
    });
  }

  Future<void> deleteSong(int songId) async {
    await initDatabase();

    await _database!.delete(
      'songs',
      where: 'id = ?',
      whereArgs: [songId],
    );
  }
}
