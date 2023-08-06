import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';


class PopMenuBarController extends GetxController{
  var playListName="".obs;
  RxList<bool> selectedPlayListBoolValue=<bool>[].obs;
  var playListNamesList = <String>[].obs;

}