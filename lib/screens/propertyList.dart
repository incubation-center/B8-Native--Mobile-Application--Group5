import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tukdak/config/services/property.dart';
import 'package:tukdak/controller/NavController.dart';
import 'package:tukdak/controller/propertryController.dart';
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
    final data = await fetchPropertyDataWithToken(); // Fetch data from the backend
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
      // Item successfully deleted, you can perform any necessary UI updates here.
      // showSuccessMessage('Deletion Success');
      print('Item with ID $id deleted successfully.');
    } catch (e) {
      // showErrorMessage('Deletion Failed');
      // Handle any errors that may occur during the delete operation.
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

  void navigateToEditPage(String name, String id,
      String categoryId,
      String price,
      String expired_at,
      String alert_at) {
    try {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PropertyInfo(
              id: id,
              name: name,
              categoryId: categoryId,
              price: price,
              expired_at: expired_at,
              alert_at: alert_at
          ),
        ),
      );
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
                      final expire = responseData[index]['expired_at'];
                      final properties = responseData[index]['properties']
                      as List<dynamic>?;

                      if (properties != null) {
                        final filterdProperties = properties.where((property) =>
                        property['categoryId'] == widget.selectedCategory)
                            .toList();
                        print('Selected Category: ${widget.selectedCategory}');
                        print('Properties for this item: $filterdProperties');
                        // final propertyNames = properties.map((property) => property['name'] as String).toList();
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => PropertyInfo());
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
                              for (var property in filterdProperties)

                                ListTile(
                                  contentPadding:
                                  const EdgeInsets.fromLTRB(20, 20, 40, 10),
                                  title: Row(
                                    children: [
                                      Container(
                                        width:
                                        35, // Set the width as needed
                                        height: 35,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            // border: Border.all(width: 1),
                                            borderRadius:
                                             BorderRadius.circular(10)),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              property['name'] as String? ??
                                                  'No name',
                                              // controller.property.value[index]
                                              //     .propertyName,
                                              style: const TextStyle(
                                                color: Color(0xFF768A95),
                                                fontSize: 18,
                                Dismissible(
                                  key: Key(property['id']),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    setState(() {
                                      onDeleteButtonPressed(property['id']);
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
                                  child: ListTile(
                                    contentPadding:
                                    EdgeInsets.fromLTRB(20, 20, 40, 10),
                                    title: Row(
                                      children: [
                                        Container(
                                          width:
                                          35, // Set the width as needed
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              // border: Border.all(width: 1),
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                property['name'] as String? ??
                                                    'No name',
                                                // controller.property.value[index]
                                                //     .propertyName,
                                                style: const TextStyle(
                                                  color: Color(0xFF768A95),
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                "Expired At: " +
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(DateTime.parse(
                                                        property['expired_at'])) as String? ??
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
                                              final name = property['name'];
                                              final id = property['id'];
                                              final categoryId = property['categoryId'];

                                              navigateToEditPage(property['name'],
                                                  property['id'],
                                                  property['categoryId'],
                                                  property['price'] as String,
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(DateTime.parse(
                                                      property['expired_at'])) as String,
                                                  property['alert_at']) as String;
                                              // print("property name------------------ $property['name']");
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