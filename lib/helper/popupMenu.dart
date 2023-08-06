import 'package:flutter/material.dart';

import '../localStorage/localStorage.dart';

AddTOPlayListBottomSheet(context) {
  final h = MediaQuery.of(context).size.height;
  final w = MediaQuery.of(context).size.width;
  return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: h * 0.2,
                  width: w * 0.8,
                  child: FutureBuilder(
                    future: DatabaseHelper().fetchAllPlaylistNames(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null ||
                          !snapshot.hasError ||
                          !snapshot.hasData ||
                          snapshot.data!.isEmpty) {
                        return Center(
                          child: Text("No PlayList Found"),
                        );
                      } else {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: h * 0.05,
                                  width: w * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all()),
                                  child: Center(
                                    child: Text("playList NAme"),
                                  ),
                                ),
                              );
                            });
                      }
                    },
                  ),
                )
              ],
            ),
          ));
}

CreateNewPlayListBottomSheet(context) {
  final h = MediaQuery.of(context).size.height;
  final w = MediaQuery.of(context).size.width;
  return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                    constraints: BoxConstraints(maxHeight: h * 0.1),
                    width: w * 0.8,
                    child: TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "My Playlist"),
                      onChanged: (value){

                    ))
              ],
            ),
          ));
}
