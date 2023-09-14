import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tukdak/config/services/property.dart';
import 'package:tukdak/controller/NavController.dart';
import 'package:tukdak/controller/propertryController.dart';
import 'package:tukdak/screens/propertyInfo.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class PropertyList extends StatefulWidget {
  const PropertyList({super.key});

  @override
  State<PropertyList> createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  final AddPropertyController controller = Get.put(AddPropertyController());
  final NavBarController navControll = Get.put(NavBarController());
  final responseData = <Map<String, dynamic>>[].obs;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final data =
    await fetchPropertyDataWithToken(); // Fetch data from the backend
    responseData.value = data!;
    print(responseData);
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
                            if (properties != null)
                              for (var property in properties)
                                ListTile(
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
                                        // child: Image.asset(
                                        //   'assets/your_image.png', // Replace with the path to your image asset
                                        //   // Set the height as needed
                                        //   // You can also use other Image constructors for network images, etc.
                                        // ),
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
                                              "Expired At: " + DateFormat('yyyy-MM-dd').format(DateTime.parse(property['expired_at'])) as String? ?? 'No Expire',
                                              // controller
                                              //     .property.value[index].category,
                                              // ,
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
                                      const SizedBox(
                                          width:
                                          16), // Add some spacing between icons
                                      ZoomTapAnimation(
                                        child: GestureDetector(
                                          child: const Icon(
                                            Icons.delete_rounded,
                                            color: Color(0xFF768A95),
                                          ),
                                          onTap: () {
                                            controller
                                                .removeProperty(index);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ],
                        ),
                      );
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