import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tukdak/config/services/category.dart';
import 'package:tukdak/controller/NavController.dart';
import 'package:tukdak/controller/addCategoryController.dart';
import 'package:tukdak/screens/addCategory.dart';
import 'package:tukdak/screens/propertyInfo.dart';
import 'package:tukdak/screens/propertyList.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final AddCategoryController controller = Get.put(AddCategoryController());
  final NavBarController navControll = Get.put(NavBarController());
  final responseData = <Map<String, dynamic>>[].obs;
  bool hasPropertiesInCategory(String categoryId, List<Map<String, dynamic>> properties) {
    return properties.any((property) => property['categoryId'] == categoryId);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final data = await fetchDataWithToken(); // Fetch data from the backend
    responseData.value = data!;
    print(responseData);
  }

  Future<void> deleteById(String id) async {
    try {
      await deleteCategoryDataWithToken(id);
      // Item successfully deleted, you can perform any necessary UI updates here.
      // showSuccessMessage('Deletion Success');
      print('Item with ID $id deleted successfully.');
    } catch (e) {
      // showErrorMessage('Deletion Failed');
      // Handle any errors that may occur during the delete operation.
      print('Error deleting item: $e');
    }
  }

  void onDeleteButtonPressed(String id, String name, List<Map<String, dynamic>> properties) async {
      // deleteById(name);
      // fetchData();
      // print("property is null");
      Get.snackbar(
        'Error',
        'Category cannot be deleted',
        backgroundColor: const Color.fromARGB(255, 170, 215, 206),
      );
      print("Cannot delete category with associated properties.");

  }

  //navigate to add page
  void navigateToEditPage(Map name) {
    final route = MaterialPageRoute(
      builder: (context) => addCategory(category: name),
    );
    Navigator.push(context, route);
  }

  void onCategorySelected(String selectedCategoryId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PropertyInfo(),
      ),
    );
    // fetchData();
  }

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
                          // _handleApiCall();
                          // navControll.goToTab(0);
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
                              setState(() async {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                    builder: (context) =>
                                    const addCategory()))
                                    .then((_) {
                                  fetchData();
                                });
                                // Get.to(() => addCategory());
                              });
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  )),
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
              borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(25)),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Expanded(
                    child: Obx(() => ListView.builder(
                      // itemCount: controller.itemCount.value,
                      itemCount: responseData.length,
                      itemBuilder: ((context, index) {
                        // final category = controller.category.value[index];
                        // if (index >= 0 && index < responseData.length) {
                          final name = responseData[index]['name'];
                          final id = responseData[index]['id'];
                          final propertiesRaw = responseData[index]['properties'];
                          final properties = (propertiesRaw != null &&
                              propertiesRaw is List)
                              ? propertiesRaw.map((property) =>
                          property as Map<String, dynamic>)
                              .toList()
                              : <Map<String, dynamic>>[];
                          return Dismissible(
                            key: Key(name),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() {
                                  onDeleteButtonPressed(id, name, properties);
                                  responseData.removeAt(index);
                                  fetchData();
                              });
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(
                                  Icons.delete, color: Colors.white),
                            ),
                            child: Container(
                              margin: new EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                // color: Color(0xFFDFEBF7),
                                // border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => const PropertyList());
                                },
                                child: ListTile(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          name,
                                          style: const TextStyle(
                                            color: Color(0xFF768A95),
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      ZoomTapAnimation(
                                        child: GestureDetector(
                                          child: const Icon(
                                            Icons.edit_rounded,
                                            color: Color(0xFF768A95),
                                            size: 20,
                                          ),
                                          onTap: () {
                                            navigateToEditPage(name);
                                            // Get.to(() => const addCategory());
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                          width:
                                          12),
                                      // Add some spacing between icons
                                      // ZoomTapAnimation(
                                      //   child: GestureDetector(
                                      //     child: const Icon(
                                      //       Icons.delete_rounded,
                                      //       color: Color(0xFF768A95),
                                      //       size: 20,
                                      //     ),
                                      //     onTap: () {
                                      //       setState(() {
                                      //         onDeleteButtonPressed(id);
                                      //       });
                                      //     },
                                      //   ),
                                      // ),
                                    ],
                                  ),
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
