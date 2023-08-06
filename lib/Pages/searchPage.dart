
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:FlutterVibes/getController/auth/audioPlayerController.dart';
import 'package:FlutterVibes/getController/auth/homeController.dart';
import 'package:FlutterVibes/getController/auth/searchController.dart';
import '../constants/constant.dart';
import 'SongScreen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final homeControl = Get.find<HomeController>();

  final audioPlayerGetControl = Get.find<AudioPlayerGetController>();
  Future getSearchResult(String s) async {
    searchGetController.queryRes.value = homeControl.listOfSongs.value
        .where((element) =>
            element.songName.toLowerCase().contains(s.toLowerCase()) ||
            element.artistName.toLowerCase().contains(s.toLowerCase()))
        .toList();
    audioPlayerGetControl.listOfSongsOfThisCategory.value =
        searchGetController.queryRes.value;
  }

  final searchController = TextEditingController();

  final searchGetController = Get.put(SearchGEtController());
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whitealpha,
      body: SafeArea(
        child: Obx(
          () => Container(
            height: h,
            width: w,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 55,
                    width: w * 0.85,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.deepOrange),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Container(
                        height: 50,
                        width: w * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          controller: searchController,
                          autofocus: true,
                          decoration: InputDecoration(
                              hintText: "Search here",
                              hintStyle: TextStyle(fontSize: 18)),
                          onChanged: (val) async {
                            await getSearchResult(val);
                          },
                          onFieldSubmitted: (val) async {
                            await getSearchResult(val);

                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  searchGetController.queryRes.value.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                          itemCount: searchGetController.queryRes.value.length,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, ind) {
                            return Padding(
                              padding: EdgeInsets.all(15),
                              child: GestureDetector(
                                onTap: () {
                                  audioPlayerGetControl
                                      .currentIndexFromList.value = ind;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AlbumPage()));
                                },
                                child: Container(
                                  height: 30,
                                  width: w - 50,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[400]!.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: Text(
                                      "${searchGetController.queryRes.value[ind].songName}",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ))
                      : SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
