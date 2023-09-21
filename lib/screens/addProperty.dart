import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tukdak/config/services/objectDetection.dart';
import 'package:tukdak/controller/NavController.dart';
import 'package:tukdak/controller/propertryController.dart';
import 'package:tukdak/screens/homePage.dart';
import 'package:tukdak/screens/mainScreen.dart';
import 'package:tukdak/screens/propertyInfo.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:get/get.dart';

class AddProperty extends StatefulWidget {
  final List <CameraDescription> cameras;
  const AddProperty({
    super.key,
  required this.cameras});

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  late CameraController cameraController;
  // XFile? pictureFile;
  final NavBarController controller = Get.put(NavBarController());
  final AddPropertyController propController = Get.put(AddPropertyController());

  @override
  void initState() {
    startCamera();
    super.initState();
  }

  void startCamera() async {
    cameraController = CameraController(
      widget.cameras[0],
      ResolutionPreset.high,
    );
    await cameraController.initialize().then((value) {
      if(!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }


  @override
  Widget build(BuildContext context) {
    if(cameraController != null && cameraController.value.isInitialized){
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
                // height: 120,
                // decoration: BoxDecoration(color: Colors.black12),
                child:
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.homepage(0);
                          // Get.back();
                        },
                        icon: Icon(Icons.arrow_back_rounded, size: 30,),
                        color: Colors.black12 ,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 470,
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Stack(
                    children: [
                      CameraPreview(cameraController),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 320,
                  padding: const EdgeInsets.only(top: 20),
                  child:
                  ZoomTapAnimation(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xFFAAC7D7),
                            child: IconButton(
                                color: Colors.white,
                                onPressed: () async {
                                  // propController.imageFile = await cameraController.takePicture();
                                  try {
                                    final XFile xFile = await cameraController.takePicture();
                                    final File file = File(xFile.path); // Convert XFile to File
                                    propController.setImageFile(file);
                                    Get.to(() => PropertyInfo()); //
                                    if (file != null){
                                      print('object+++++++++++++++++++++++++');
                                    }
                                    // print('object+++++++++++++++++++++++++');// igate to PropertyInfo
                                  } catch (e) {
                                    print("Error taking picture: $e");
                                  }
                                },
                                iconSize: 30,
                                icon: const Icon(Icons.camera_alt_rounded)
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}