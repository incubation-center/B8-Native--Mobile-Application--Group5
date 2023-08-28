import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tukdak/config/routes.dart';
import 'package:tukdak/controller/addCategoryController.dart';
import 'package:tukdak/screens/addCategory.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final AddCategoryController controller = Get.put(AddCategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAAC7D7),
      body: Column(
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(color: Color(0xFFAAC7D7)),
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: 60),
              child: Row(
                children: [
                  ZoomTapAnimation(
                    child: ElevatedButton(
                      child: const Text(
                          "+ Category",
                          style: TextStyle(
                            color: Color(0xFFAAC7D7),
                          ),
                      ),
                        onPressed: () {
                          Get.to( () => addCategory());
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
                ],
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Expanded(
                            child: Obx(() => ListView.builder(
                              itemCount: controller.itemCount.value,
                              itemBuilder: ((context, index) {
                                return Container(
                                  margin: new EdgeInsets.only(top: 10) ,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFDFEBF7),
                                    // border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10) ,
                                    title: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              controller.category.value[index].categoryName!,
                                              style: TextStyle(
                                                color: Color(0xFF768A95),
                                                fontSize: 24,
                                              ),
                                          ),
                                        ),
                                        ZoomTapAnimation(
                                          child: GestureDetector(
                                            child: Icon(
                                              Icons.edit_rounded,
                                              color: Color(0xFF768A95),
                                            ),
                                            onTap: () {
                                              // Handle edit action here
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 16), // Add some spacing between icons
                                        ZoomTapAnimation(
                                          child: GestureDetector(
                                            child: Icon(
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
