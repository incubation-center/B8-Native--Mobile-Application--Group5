import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tukdak/config/routes.dart';
import 'package:tukdak/controller/NavController.dart';
import 'package:tukdak/controller/addCategoryController.dart';
import 'package:tukdak/screens/addCategory.dart';
import 'package:tukdak/screens/propertyList.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final AddCategoryController controller = Get.put(AddCategoryController());
  final NavBarController navControll = Get.put(NavBarController());
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAAC7D7),
      body: Column(
        children: [
          Container(
            height: 160,
            decoration: const BoxDecoration(color: Color(0xFFAAC7D7)),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          navControll.goToTab(0);
                          // Get.back();
                        },
                        icon: Icon(Icons.arrow_back_rounded, size: 30,),
                        color: Colors.white ,
                      ),
                    ],
                  ),
                  Row(
                  children: [
                    ZoomTapAnimation(
                      child: Container(
                        padding: const EdgeInsets.only(left: 15, top: 20),
                        child: ElevatedButton(
                          child: Text(
                              "+ Category",
                              style: TextStyle(
                                color: Color(0xFFAAC7D7),
                              ),
                          ),
                            onPressed: () {
                              Get.to( () => addCategory());
                              controller.categoryNameTextEditingController.text = '';
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )
                              ),
                            ),
                            ),
                      ),
                    ),
                  ],
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
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Expanded(
                            child: Obx(() => ListView.builder(
                              itemCount: controller.itemCount.value,
                              itemBuilder: ((context, index) {
                                return Container(
                                  margin: new EdgeInsets.only(top: 10) ,
                                  decoration: BoxDecoration(
                                    // color: Color(0xFFDFEBF7),
                                    // border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => PropertyList());
                                    },
                                    child: ListTile(
                                      contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10) ,
                                      title: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                                controller.category.value[index].categoryName!,
                                                style: const TextStyle(
                                                  color: Color(0xFF768A95),
                                                  fontSize: 24,
                                                ),
                                            ),
                                          ),
                                          ZoomTapAnimation(
                                            child: GestureDetector(
                                              child: const Icon(
                                                Icons.edit_rounded,
                                                color: Color(0xFF768A95),
                                              ),
                                              onTap: () {
                                                // int selectedIndex = index;
                                                isEdit = true;
                                                Get.to( () => const addCategory());
                                                controller.editCategory(
                                                    index,
                                                    controller.categoryNameTextEditingController.text);
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
                                                controller.removeCategory(index);
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
                  ),
        ],
      ),
    );
  }
}
