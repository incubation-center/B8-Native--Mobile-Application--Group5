import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tukdak/config/services/property.dart';
import 'package:tukdak/controller/NavController.dart';
import 'package:tukdak/screens/propertyInfo.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class PropertyList extends StatefulWidget {
  final String selectedCategory;
  const PropertyList({
    super.key,
    required this.selectedCategory,
  });

  @override
  State<PropertyList> createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  final NavBarController navControll = Get.put(NavBarController());
  final responseData = <Map<String, dynamic>>[].obs;

  @override
  void initState() {
    super.initState();
    print('Selected Category: ${widget.selectedCategory}');
    fetchData();
  }

  void fetchData() async {
    final data =
        await fetchPropertyDataWithToken(); // Fetch data from the backend
    responseData.value = data!;
    print(responseData);

    // Filter the responseData based on the selected category
    filterByCategory(widget.selectedCategory);
  }

  void filterByCategory(String category) {
    if (category.isNotEmpty) {
      responseData.value = responseData
          .where((item) =>
              item['name'] == category ||
              item['properties']
                  .any((property) => property['categoryId'] == category))
          .toList();
    }
  }

  Future<void> deletePropertyById(String id) async {
    try {
      await deletePropertyDataWithToken(id);
      print('Item with ID $id deleted successfully.');
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  void onDeleteButtonPressed(String name) async {
    deletePropertyById(name);
    fetchData();
    Get.snackbar(
      'Success',
      'Property has been deleted',
      backgroundColor: const Color.fromARGB(255, 170, 215, 206),
    );
    print("delete success.");
  }

  void navigateToEditPage( String id, String image, String name, String categoryId,
      String price, String expired_at, String alert_at) {
    try {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PropertyInfo(
              id: id,
              image: image,
              name: name,
              categoryId: categoryId,
              price: price,
              expired_at: expired_at,
              alert_at: alert_at),
        ),
      );
      print("id----------: $id");
      print(id.runtimeType);
      print("name----------: $name");
      print("categoryId-------:$categoryId");
      // print("price----------: $price");
      print("expire_at------: $expired_at");
      // print("alert_at----------: $alert_at");
    } catch (e) {
      print("Navigation error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFAAC7D7),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 160,
              decoration: const BoxDecoration(color: Color(0xFFAAC7D7)),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // navControll.goToTab(2);
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
            Expanded(
              child: Container(
                color: Colors.white,
                child: Expanded(
                  child: Obx(() => ListView.builder(
                        // itemCount: controller.propertyCount.value,
                        itemCount: responseData.length,
                        itemBuilder: ((context, index) {
                          final id = responseData[index]['id'];
                          final properties = responseData[index]['properties']
                              as List<dynamic>?;
                          if (properties != null) {
                            final filterdProperties = properties
                                .where((property) =>
                                    property['categoryId'] ==
                                    widget.selectedCategory)
                                .toList();
                            print(
                                'Selected Category: ${widget.selectedCategory}');
                            print(
                                'Properties for this item: $filterdProperties');
                            // final propertyNames = properties.map((property) => property['name'] as String).toList();
                            return GestureDetector(
                              onTap: () {
                                // Get.to(() => PropertyInfo());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '',
                                    style: TextStyle(
                                      color: Color(0xFF768A95),
                                      fontSize: 24,
                                    ),
                                  ),
                                  for (var property in properties)
                                    Dismissible(
                                      key: Key(property['id']),
                                      direction: DismissDirection.endToStart,
                                      onDismissed: (direction) {
                                        setState(() {
                                          onDeleteButtonPressed(property['id']);
                                          responseData.removeAt(index);
                                          fetchData();
                                        });
                                        print('object id: ${property['id']}');
                                        print('object id type: ${property['id'].runtimeType}');
                                      },
                                      background: Container(
                                        color: Colors.red,
                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: const Icon(Icons.delete,
                                            color: Colors.white),
                                      ),
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 20, 40, 10),
                                        title: Row(
                                          children: [
                                            Container(
                                              width:
                                                  35, // Set the width as needed
                                              height: 35,
                                              child: Image.network(property['image'] ?? "data:image/png;base64,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"),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    property['name']
                                                            as String? ??
                                                        'No name',
                                                    // controller.property.value[index]
                                                    //     .propertyName,
                                                    style: const TextStyle(
                                                      color: Color(0xFF768A95),
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  if(property['expired_at'] != null)
                                                    Text(
                                                      "Expired At: " + DateFormat('yyyy-MM-dd').format(DateTime.parse(property['expired_at'])) as String? ??
                                                          'No Expire',
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
                                                  size: 20,
                                                ),
                                                onTap: () {
                                                  if (property['name'] !=
                                                          null &&
                                                      id != null &&
                                                      property['categoryId'] !=
                                                          null &&
                                                      property['price'] !=
                                                          null )
                                                      // &&
                                                      // property['expired_at'] !=
                                                      //     null &&
                                                      // property['alert_at'] !=
                                                      //     null)
                                                  {
                                                    navigateToEditPage(
                                                        property['id'],
                                                        property['image'],
                                                        property['name'],
                                                        property['categoryId'],
                                                        property['price']
                                                            .toString(),
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(DateTime
                                                                .parse(property[
                                                                    'expired_at'])),
                                                        property['alert_at']
                                                            .toString());
                                                  } else {
                                                    throw ('Cannot open a null value');
                                                    print(
                                                        "can't not navigate to edit page");
                                                    // Handle the case where one or more values are null.
                                                  }

                                                  fetchData();
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                                width:
                                                    12), // Add some spacing between icons
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }
                        }),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
