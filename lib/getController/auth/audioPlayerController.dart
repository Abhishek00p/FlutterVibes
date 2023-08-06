import 'package:get/get.dart';
import 'package:FlutterVibes/modals/songModal.dart';



class AudioPlayerGetController extends GetxController{
  var isAudioPlaying=false.obs;
  var listOfSongsOfThisCategory =<SongModel>[].obs;
  var currentIndexFromList=0.obs;
  var isShuffling=false.obs;
  var isLooping=false.obs;

}