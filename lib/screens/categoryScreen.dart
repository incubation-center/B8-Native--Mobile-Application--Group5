import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tukdak/config/services/category.dart';
import 'package:tukdak/controller/NavController.dart';
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
    // print('id of item: $id')
    try {
      await deleteCategoryDataWithToken(id);
      print('id to delete: $id');
      print('Item with ID $id deleted successfully.');
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  void onDeleteButtonPressed(String name) async {
    try {
      deleteById(name);
      fetchData();
      Get.snackbar(
        'Failed',
        // 'Category is Deleted',
        'Cannot delete category with associated properties',
        backgroundColor: const Color.fromARGB(255, 170, 215, 206),
      );
      print("Cannot delete category with associated properties.");
    } catch (e){
      print('category cannot delete $e');
    }
  }

  //navigate to add page
  void navigateToEditPage(String name, id) {
    try {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => addCategory(category: name, id: id),
        ),
      );
    } catch (e) {
      print("Navigation error: $e");
    }
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
                          navControll.goToTab(0);
                          // Get.back();
                        },
                        icon: const Icon(
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
                            child:  Text(
                              "+ Category",
                              style: TextStyle(
                                color: Color(0xFFAAC7D7),
                              ),
                            ),
                            onPressed: () {
                              setState(() async {
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                    builder: (context) =>
                                    const addCategory()))
                                    .then((_) {
                                  fetchData();
                                });
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
                      itemCount: responseData.length,
                      itemBuilder: ((context, index) {
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
                            key: Key(id),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() {
                                  onDeleteButtonPressed(name);
                                  responseData.removeAt(index);
                                  fetchData();
                              });
                              print("category id: $id");
                              print("category id type: ${id.runtimeType}");
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(
                                  Icons.delete, color: Colors.white),
                            ),
                            child: Container(
                              margin:  new EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  final String categorySelected = id.toString();
                                  print("id: $id");
                                  print("id: ${id.runtimeType}");
                                  Get.to(() => PropertyList(selectedCategory: id ?? ""));
                                },
                                child: ListTile(
                                  contentPadding:
                                  const EdgeInsets.fromLTRB(20, 10, 10, 10),
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
                                          onTap: () {
                                              navigateToEditPage(name, id);
                                              fetchData();
                                          },
                                          child: const Icon(
                                            Icons.edit_rounded,
                                            color: Color(0xFF768A95),
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                          width:
                                          12),
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
