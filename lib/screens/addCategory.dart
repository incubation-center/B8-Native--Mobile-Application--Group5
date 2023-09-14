import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tukdak/config/services/category.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../controller/addCategoryController.dart';

class addCategory extends StatefulWidget {
  final Map? category;
  const addCategory({
    super.key,
    this.category,
  });

  @override
  State<addCategory> createState() => _addCategoryState();
}

class _addCategoryState extends State<addCategory> {
  final AddCategoryController controller = Get.put(AddCategoryController());
  final TextEditingController categoryController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final category = widget.category;
    if (category != null) {
      isEdit = true;
      final name = category['name'];
      categoryController.text = name;
    }
  }

  void submitData() async {
    // final data = await postCategoryDataWithToken();
    final category = categoryController.text;
    final body = {
      "name": category,
    };
    try {
      final response = await postCategoryDataWithToken(
          body); // Call the post function with your data
      if (response != null) {
        categoryController.text = '';
        // Handle the response from the server here
        showSuccessMessage('Creation Success');
        print("Response from server: $response");
      }
    } catch (e) {
      showErrorMessage('Creation Failed');
      // Handle any errors that may occur during the request
      print("Error sending data to server: $e");
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void updateData() {}

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
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        size: 30,
                      ),
                      color: Colors.white,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 40, top: 40),
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
                          child: TextField(
                            controller: categoryController,
                            // controller: controller.categoryNameTextEditingController,
                            decoration: const InputDecoration(
                                focusColor: Color(0xFF768A95),
                                hintText: 'Enter category name',
                                hintStyle: TextStyle(color: Color(0xFFC6D0D6))),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 320,
                          padding: const EdgeInsets.only(top: 40),
                          child: ZoomTapAnimation(
                            child: ElevatedButton(
                              onPressed: () => {
                                setState(() {
                                  isEdit ? updateData : submitData();
                                }),
                                // Get.back(),
                                Navigator.pop(context),
                              },
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF768A95)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                              ),
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                  color: Colors.white,
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
