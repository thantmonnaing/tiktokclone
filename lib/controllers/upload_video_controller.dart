   
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/constants.dart';
import 'package:tiktokclone/models/video.dart';
import 'package:tiktokclone/views/screens/home_screen.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  static UploadVideoController instance = Get.find();

  late double _progress = 0;
  double get progress => _progress;

  _compressVideo(String videoPath) async {
    try{
      final compressedVideo = await VideoCompress.compressVideo(
          videoPath,
          quality: VideoQuality.MediumQuality,
          deleteOrigin: false,
        includeAudio: true
      );
      // ignore: avoid_print
      print(compressedVideo!.file);
      return compressedVideo.file;
    }catch(e){
      Get.snackbar(
        'Error Uploading Video',
        e.toString(),
      );
    }

  }

  showLoading({String title = "uploading..."}) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          margin: const EdgeInsets.all(15.0),
          height: 40,
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.black38),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  bool isDialogueOpen = false ;
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    File file = File(videoPath); //await _compressVideo(videoPath)
    UploadTask uploadTask = ref.putFile(file);
    uploadTask.snapshotEvents.listen((event) {
      _progress = event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
      if (event.state == TaskState.success) {
        if(isDialogueOpen){
          Get.back();
          // Get.snackbar('Successful!','Upload completed',
          //     snackPosition: SnackPosition.BOTTOM);
          showLoading(title: "Completed!");
          Get.back();
          Get.off(HomeScreen());
        }
        isDialogueOpen = false;
      }
      else if (event.state == TaskState.running){
        _progress = event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
        if(!isDialogueOpen){
          showLoading(title: "Uploading...");
        }
        isDialogueOpen = true;
        // Get.snackbar('Please wait!','Uploading....',
        //     snackPosition: SnackPosition.BOTTOM,isDismissible: isDialogueOpen);
      }
      else if (event.state == TaskState.error){
        Get.back();
        isDialogueOpen = false;
        Get.snackbar('Error!','Uploading error....',
            snackPosition: SnackPosition.BOTTOM,isDismissible: isDialogueOpen);
      }
    }).onError((error) {
      // do something to handle error
    });
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // upload video
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      // get id
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
      String thumbnail = await _uploadImageToStorage("Video $len", videoPath);

      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>)['name'],
        uid: uid,
        id: "Video $len",
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
        thumbnail: thumbnail,
      );

      await firestore.collection('videos').doc('Video $len').set(
            video.toJson(),
          );
      Get.back();
      Get.off(HomeScreen());
    } catch (e) {
      Get.snackbar(
        'Error Uploading Video',
        e.toString(),
      );
    }
  }
}