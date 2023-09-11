import 'package:flutter/material.dart';
import 'package:tukdak/controller/NavController.dart';
import 'package:tukdak/controller/propertryController.dart';
import 'package:tukdak/screens/addProperty.dart';
import 'package:tukdak/screens/propertyInfo.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:get/get.dart';

class PropertyList extends StatefulWidget {
  const PropertyList({super.key});

  @override
  State<PropertyList> createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {

  final AddPropertyController controller = Get.put(AddPropertyController());
  final NavBarController navControll = Get.put(NavBarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAAC7D7),
      body: SafeArea(
          child: Column(
                children: [
                  Container(
                    height: 160,
                    decoration: const BoxDecoration(color: Color(0xFFAAC7D7)),
                    child: Padding(
                    padding: EdgeInsets.only(left: 15, top: 20),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            // navControll.goToTab(2);
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back_rounded, size: 30,),
                          color: Colors.white ,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(25)),
                    child: Container(
                      color: Colors.white,
                      child: Expanded(
                        child: Obx(() => ListView.builder(
                          // itemCount: controller.itemCount.value,
                          itemCount: controller.propertyCount.value,
                          itemBuilder: ((context, index) {
                            return Container(
                              margin: const EdgeInsets.only(top: 10) ,
                              decoration: BoxDecoration(
                                // color: Color(0xFFDFEBF7),
                                // border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: GestureDetector(
                              onTap: () {
                                Get.to(() => PropertyInfo());
                              },
                                child: ListTile(
                                  contentPadding: EdgeInsets.fromLTRB(40, 20, 10, 10),
                                  title: Row(
                                    children: [
                                      Container(
                                        width: 35, // Set the width as needed
                                        height: 35,
                                        decoration: BoxDecoration(
                                            color: Colors.cyanAccent,
                                            // border: Border.all(width: 1),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        // child: Image.asset(
                                        //   'assets/your_image.png', // Replace with the path to your image asset
                                        //   // Set the height as needed
                                        //   // You can also use other Image constructors for network images, etc.
                                        // ),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                            controller.property.value[index].propertyName,
                                            style: const TextStyle(
                                              color: Color(0xFF768A95),
                                              fontSize: 24,
                                            ),
                                          ),
                                            Text(
                                            controller.property.value[index].category,
                                            style: const TextStyle(
                                              color: Color(0xFF768A95),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                        ),
                                      ),
                                      ZoomTapAnimation(
                                        child: GestureDetector(
                                          child: const Icon(
                                            Icons.edit_rounded,
                                            color: Color(0xFF768A95),
                                          ),
                                          onTap: () {
                                            Get.to(() => PropertyList());
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 16), // Add some spacing between icons
                                      ZoomTapAnimation(
                                        child: GestureDetector(
                                          child: const Icon(
                                            Icons.delete_rounded,
                                            color: Color(0xFF768A95),
                                          ),
                                          onTap: () {
                                            controller.removeProperty(index);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        )),
                      ),
                    ),
                  ),
                ),
            ],
          ),
      ),
    );
  }
}
