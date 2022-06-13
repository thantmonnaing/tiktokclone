import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktokclone/controllers/auth_controller.dart';
import 'package:tiktokclone/controllers/upload_video_controller.dart';
import 'package:tiktokclone/views/screens/add_video_screen.dart';
import 'package:tiktokclone/views/screens/profile_screen.dart';
import 'package:tiktokclone/views/screens/search_screen.dart';
import 'package:tiktokclone/views/screens/video_screen.dart';


//pages
List pages = [
  VideoScreen(),
  SearchScreen(),
  const AddVideoScreen(),
  Text('Messages Screen'),
  ProfileScreen(uid: authController.user.uid,status:false),
];


//colors
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;


//firebase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;


//controller
var authController = AuthController.instance;
var uploadController = UploadVideoController.instance;