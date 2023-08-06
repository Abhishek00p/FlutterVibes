import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:FlutterVibes/Pages/SongScreen.dart';
import 'package:FlutterVibes/Pages/searchPage.dart';
import 'package:FlutterVibes/firebase/functions.dart';
import 'package:FlutterVibes/getController/auth/audioPlayerController.dart';
import 'package:FlutterVibes/modals/songModal.dart';

import '../getController/auth/homeController.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  final audioAllGEtController = Get.put(AudioPlayerGetController());
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(40),
      body: Container(
        height: h,
        width: w,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(
              () => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: w * 0.8,
                      child: GestureDetector(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Discover",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                              Icon(
                                Icons.search,
                                size: 24,
                                color: Colors.white,
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: h * 0.2,
                      width: w - 40,
                      child: CarouselSlider(
                        items: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: h * 0.19,
                                width: w - 40,
                                child: Image.asset(
                                  "assets/adImage.jpg",
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: h * 0.19,
                                width: w - 40,
                                child: Image.asset(
                                  "assets/adImage2.jpg",
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: h * 0.19,
                                width: w - 40,
                                child: Image.asset(
                                  "assets/adImage3.jpg",
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ],
                        options: CarouselOptions(
                          height: h * 0.2,
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayCurve: Curves.linearToEaseOut,
                          scrollPhysics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.05,
                    ),
                    Text(
                      "Love Songs",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: h * 0.22,
                      width: w - 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: homeController.listOfSongs.value
                            .where(
                                (element) => element.category.contains('love'))
                            .length,
                        itemBuilder: (context, index) {
                          List<SongModel> songLists = homeController
                              .listOfSongs.value
                              .where((element) =>
                                  element.category.contains('love'))
                              .toList();
                          print("length of love: ${songLists.length}");
                          return InkWell(
                            onTap: () {
                              audioAllGEtController
                                  .listOfSongsOfThisCategory.value = songLists;
                              audioAllGEtController.currentIndexFromList.value =
                                  index;
                              Get.to(() => AlbumPage());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: h * 0.2,
                                width: w * 0.4,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        top: 0,
                                        child: Container(
                                          height: h * 0.15,
                                          width: w * 0.4,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              songLists[index].imageUrl,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )),
                                    Positioned(
                                        bottom: 0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              songLists[index].songName,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              songLists[index].artistName,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: h * 0.05,
                    ),
                    Text(
                      "Old Songs",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: h * 0.22,
                      width: w - 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: homeController.listOfSongs.value
                            .where(
                                (element) => element.category.contains('old'))
                            .length,
                        itemBuilder: (context, index) {
                          List<SongModel> songLists = homeController
                              .listOfSongs.value
                              .where(
                                  (element) => element.category.contains('old'))
                              .toList();
                          print("length of old : ${songLists.length}");
                          return InkWell(
                            onTap: () {
                              audioAllGEtController
                                  .listOfSongsOfThisCategory.value = songLists;
                              audioAllGEtController.currentIndexFromList.value =
                                  index;
                              Get.to(() => AlbumPage());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: h * 0.2,
                                width: w * 0.4,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        top: 0,
                                        child: Container(
                                          height: h * 0.15,
                                          width: w * 0.4,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              songLists[index].imageUrl,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )),
                                    Positioned(
                                        bottom: 0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              songLists[index].songName,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              songLists[index].artistName,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: h * 0.05,
                    ),
                    const Text(
                      "Pop Songs",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: h * 0.22,
                      width: w - 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: homeController.listOfSongs.value
                            .where(
                                (element) => element.category.contains('pop'))
                            .length,
                        itemBuilder: (context, index) {
                          List<SongModel> songLists = homeController
                              .listOfSongs.value
                              .where(
                                  (element) => element.category.contains('pop'))
                              .toList();
                          print("length o f : ${songLists.length}");
                          return InkWell(
                            onTap: () {
                              audioAllGEtController
                                  .listOfSongsOfThisCategory.value = songLists;
                              audioAllGEtController.currentIndexFromList.value =
                                  index;
                              Get.to(() => AlbumPage());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: h * 0.2,
                                width: w * 0.4,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        top: 0,
                                        child: Container(
                                          height: h * 0.15,
                                          width: w * 0.4,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              songLists[index].imageUrl,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )),
                                    Positioned(
                                        bottom: 0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              songLists[index].songName,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              songLists[index].artistName,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
