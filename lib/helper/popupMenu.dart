import 'package:FlutterVibes/constants/constant.dart';
import 'package:FlutterVibes/getController/auth/popMenuController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../localStorage/localStorage.dart';

class AddTOPlayListBottomSheetClass extends StatefulWidget {
  const AddTOPlayListBottomSheetClass({Key? key}) : super(key: key);

  @override
  State<AddTOPlayListBottomSheetClass> createState() =>
      _AddTOPlayListBottomSheetClassState();
}

class _AddTOPlayListBottomSheetClassState
    extends State<AddTOPlayListBottomSheetClass> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              height: h * 0.35,
              width: w * 0.8,
              child: FutureBuilder(
                future: DatabaseHelper().fetchAllPlaylistNames(),
                builder: (context, AsyncSnapshot snapshot) {
                  print("snapshotDATAA :${snapshot.data}");
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.data == null ||
                      snapshot.hasError ||
                      !snapshot.hasData) {
                    return Center(
                      child: Text("No PlayList Found"),
                    );
                  } else {
                    final popControler = Get.find<PopMenuBarController>();
                    if (popControler.playListNamesList.value.isEmpty) {
                      return Center(
                        child: Text("No PlayList Found"),
                      );
                    }
                    return Obx(
                      () => ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              popControler.playListNamesList.value.length,
                          itemBuilder: (context, index) {
                            print(
                                "list value -->${popControler.selectedPlayListBoolValue.value[index]}");

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(
                                    () => Checkbox(
                                        value: popControler
                                            .selectedPlayListBoolValue
                                            .value[index],
                                        onChanged: (value) {
                                          popControler.selectedPlayListBoolValue
                                                  .value[index] =
                                              !popControler
                                                  .selectedPlayListBoolValue
                                                  .value[index];
                                          print(
                                              "changing value $index -->${popControler.selectedPlayListBoolValue.value[index]}");
                                        }),
                                  ),
                                  Container(
                                    height: h * 0.05,
                                    width: w * 0.6,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all()),
                                    child: Center(
                                      child: Text(
                                          "${popControler.playListNamesList[index]}"),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: h * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text("Create")),
              ],
            )
          ],
        ),
      ),
    );
  }
}

AddTOPlayListBottomSheet(context) {
  return showModalBottomSheet(
      context: context, builder: (context) => AddTOPlayListBottomSheetClass());
}

CreateNewPlayListBottomSheet(context) {
  final h = MediaQuery.of(context).size.height;
  final w = MediaQuery.of(context).size.width;
  final popMenubarControler = Get.put(PopMenuBarController());
  return showModalBottomSheet(
      backgroundColor: whitealpha.withOpacity(0.7),
      context: context,
      builder: (context) => Container(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                 Container(
                      constraints: BoxConstraints(maxHeight: h * 0.1),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5)),
                      width: w * 0.8,
                      child: TextFormField(
                          autofocus: true,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: "My Playlist"),
                          onChanged: (value) {
                            popMenubarControler.playListName.value = value;
                          }),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel")),
                    ElevatedButton(
                        onPressed: () async {
                          await DatabaseHelper().createPlaylist(
                              popMenubarControler.playListName.value);
                          Navigator.pop(context);
                        },
                        child: Text("Create")),
                  ],
                )
              ],
            ),
      )
          );
}
