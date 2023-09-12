import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../controller/addCategoryController.dart';
import 'categoryScreen.dart';

class addCategory extends StatefulWidget {
  const addCategory({super.key});

  @override
  State<addCategory> createState() => _addCategoryState();
}
class _addCategoryState extends State<addCategory> {

  final AddCategoryController controller = Get.put(AddCategoryController());
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAAC7D7),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(color: Color(0xFFAAC7D7)),
              child:
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 20),
                  child: Row(
                    children: [
                     IconButton(
                          onPressed: () {
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
            child:
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(left:40, top: 40),
                                child: const Text(
                                  "Category Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF768A95),
                                      fontSize: 24,
                                  ),
                                ),
                              ),
                            Center(
                              child: Container(
                                width: 320,
                                padding: const EdgeInsets.only(top: 40),
                                child:
                                TextField(
                                  controller: controller.categoryNameTextEditingController,
                                  decoration: const InputDecoration(
                                    focusColor: Color(0xFF768A95),
                                    hintText: 'Enter category name',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFC6D0D6)
                                    )
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 320,
                                padding: const EdgeInsets.only(top: 40),
                                child:
                                  ZoomTapAnimation(
                                    child: ElevatedButton(
                                      child: Text(
                                        "Save",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () =>  {
                                      // if (isEdit) {
                                      //   controller.editCategory(index, controller.categoryNameTextEditingController.text)
                                      // } else {
                                      controller.addNewCategory(controller.categoryNameTextEditingController.text),
                                      // },
                                      Get.back(),
                                        },
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF768A95)),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                              ),
                            )
                          ],
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
