import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:FlutterVibes/getController/auth/homeController.dart';
import 'package:FlutterVibes/modals/songModal.dart';

class MyFunctions{

  final fireStoreDB = FirebaseFirestore.instance;
 final homeController =Get.put(HomeController());

 // Get songs Lists and store in GetControllers
 Future<void> getAllSongs() async {
   try {
     final ref = fireStoreDB.collection("songs").limit(50);
     final refdata = await ref.get().then((value) => value.docs);
     for (var element in refdata) {
       homeController.listOfSongs.value.add(SongModel.fromJson(element.data()));
     }


   }catch(e){
     print("errro : $e");
   }
 }
}