import 'package:FlutterVibes/helper/popupMenu.dart';
import 'package:FlutterVibes/localStorage/localStorage.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:FlutterVibes/modals/songModal.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/constant.dart';

import '../getController/auth/audioPlayerController.dart';
import 'home.dart';

class AlbumPage extends StatefulWidget {
  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  var _val = 0.0;
  final audioPlayerGetControl = Get.find<AudioPlayerGetController>();

  AudioPlayer _audioPlayer = AudioPlayer();

  var audioDuration;
  var currentValue = 0.0;
  var positionofSlider;

  void playNextSong() {
    //Check is Shuffle is ON
    if (audioPlayerGetControl.isShuffling.value) {
      audioPlayerGetControl.listOfSongsOfThisCategory.value.shuffle();
      audioPlayerGetControl.currentIndexFromList.value = 0;
    } else {
      // If Shuffle is OFF play next Sequence
      if (audioPlayerGetControl.currentIndexFromList.value <
          audioPlayerGetControl.listOfSongsOfThisCategory.value.length - 1) {
        audioPlayerGetControl.currentIndexFromList.value++;
      } else if (audioPlayerGetControl.isLooping.value) {
        audioPlayerGetControl.currentIndexFromList.value = 0;
      }
    }

    final nextSong = audioPlayerGetControl.listOfSongsOfThisCategory
        .value[audioPlayerGetControl.currentIndexFromList.value];

    _audioPlayer.setUrl(nextSong.songUrl);
    _audioPlayer.play();
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();

    positionofSlider = _audioPlayer.positionStream;
    audioDuration = _audioPlayer.durationStream;
    _audioPlayer.playerStateStream.listen((event) {
      print("playing  state :${event.processingState}");

      if (ProcessingState.completed == event.processingState) {
        print("processingSATECompleted : ");

        playNextSong();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayerGetControl.currentIndexFromList.value = 0;
    audioPlayerGetControl.listOfSongsOfThisCategory.value.clear();
    audioPlayerGetControl.isAudioPlaying.value = false;
    _audioPlayer.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      rxdart.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, bufferPosition, duration) => PositionData(
              position, bufferPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final SongModel song = audioPlayerGetControl.listOfSongsOfThisCategory
        .value[audioPlayerGetControl.currentIndexFromList.value];

    return Scaffold(
      backgroundColor: scaffColor,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                value == 'addToPlayList'
                    ? AddTOPlayListBottomSheet(context)
                    : CreateNewPlayListBottomSheet(context);
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'addToPlayList',
                    child: Text('Add to Playlist'),
                  ),
                  PopupMenuItem<String>(
                    value: 'createPlaylist',
                    child: Text('create a Playlist'),
                  ),
                ];
              },
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Get.offAll(Home());
            },
            icon: Icon(
              Icons.arrow_back_sharp,
              color: Colors.white,
            ),
          )),
      body: SafeArea(
          child: Container(
        height: h,
        width: w,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: h * 0.45,
                        width: w * 0.9,
                        padding:
                            EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            song.imageUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        song.songName.toString(),
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        song.artistName,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                            color: Colors.greenAccent),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Toggle loop mode
                          audioPlayerGetControl.isLooping.value =
                              !audioPlayerGetControl.isLooping.value;
                          _audioPlayer.setLoopMode(
                            audioPlayerGetControl.isLooping.value
                                ? LoopMode.one
                                : LoopMode.off,
                          );
                        },
                        icon: Icon(
                          Icons.loop,
                          color: audioPlayerGetControl.isLooping.value
                              ? Colors.green
                              : Colors.white,
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            if (audioPlayerGetControl
                                    .currentIndexFromList.value >
                                0) {
                              _audioPlayer.stop();
                              audioPlayerGetControl.isAudioPlaying.value =
                                  false;
                              audioPlayerGetControl
                                  .currentIndexFromList.value--;
                            }

                            setState(() {});
                          },
                          icon: Icon(
                            Icons.skip_previous_outlined,
                            color: Colors.orangeAccent,
                          )),
                      GestureDetector(
                        onTap: audioPlayerGetControl.isAudioPlaying.value
                            ? () async {
                                audioPlayerGetControl.isAudioPlaying.value =
                                    false;
                                _audioPlayer.pause();
                              }
                            : () async {
                                audioPlayerGetControl.isAudioPlaying.value =
                                    true;
                                await _audioPlayer.setUrl(song.songUrl);

                                _audioPlayer.play();
                              },
                        child: !audioPlayerGetControl.isAudioPlaying.value
                            ? Icon(
                                Icons.play_circle_outline_outlined,
                                size: 45,
                                color: Colors.orange,
                              )
                            : Icon(
                                Icons.pause_circle_outline,
                                size: 45,
                                color: Colors.orange,
                              ),
                      ),
                      IconButton(
                          onPressed: () async {
                            if (audioPlayerGetControl
                                    .listOfSongsOfThisCategory.value.length >
                                (audioPlayerGetControl
                                        .currentIndexFromList.value +
                                    1)) {
                              audioPlayerGetControl.isAudioPlaying.value =
                                  false;

                              _audioPlayer.stop();

                              audioPlayerGetControl
                                  .currentIndexFromList.value++;
                              setState(() {});
                            }
                          },
                          icon: Icon(
                            Icons.skip_next_outlined,
                            color: Colors.orangeAccent,
                          )),
                      IconButton(
                        onPressed: () {
                          // Toggle shuffle mode
                          audioPlayerGetControl.isShuffling.value =
                              !audioPlayerGetControl.isShuffling.value;
                          if (audioPlayerGetControl.isShuffling.value) {
                            // Perform shuffling logic
                            // You'll need to shuffle your playlist or tracks here
                          }
                        },
                        icon: Icon(
                          Icons.shuffle,
                          color: audioPlayerGetControl.isShuffling.value
                              ? Colors.green
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 15,
                        top: 2,
                        child: Container(
                          width: w * 0.8,
                          height: 10,
                          child: StreamBuilder<PositionData>(
                            stream: _positionDataStream,
                            builder: (context, snap) {
                              final posData = snap.data;
                              return ProgressBar(
                                timeLabelTextStyle: TextStyle(
                                    color: Colors.white, fontSize: 12),
                                thumbRadius: 8,
                                barHeight: 4,
                                baseBarColor: Colors.white.withOpacity(0.2),
                                thumbColor: Colors.red,
                                thumbGlowColor: Colors.yellow,
                                bufferedBarColor: Colors.white,
                                progressBarColor: Colors.orange,
                                progress: posData?.position ?? Duration.zero,
                                total: posData?.duration ?? Duration.zero,
                                buffered:
                                    posData?.bufferPosition ?? Duration.zero,
                                onSeek: _audioPlayer.seek,
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                          left: 0,
                          bottom: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferPosition;
  final Duration duration;

  PositionData(this.position, this.bufferPosition, this.duration);
}
