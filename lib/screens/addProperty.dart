import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tukdak/screens/propertyInfo.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:get/get.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({super.key});

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  @override
  void initState() {
    startCamera();
    super.initState();
  }

  void startCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
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

  @override
  Widget build(BuildContext context) {
    if(cameraController != null && cameraController.value.isInitialized){
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
              height: 580,
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Stack(
                  children: [
                    CameraPreview(cameraController),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Container(
                    //     height: 120,
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // )
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
                              onPressed: () {
                                Get.to(() => PropertyInfo());
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
