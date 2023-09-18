import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tukdak/config/services/allproducexpired.dart';
import 'package:tukdak/screens/mainScreen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ProductAchivescreen extends StatefulWidget {
  ProductAchivescreen({super.key});

  @override
  State<ProductAchivescreen> createState() => _ProductArchivescreenState();
}

class _ProductArchivescreenState extends State<ProductAchivescreen> {
  final responseData = <Map<String, dynamic>>[].obs;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final data = await getAllexpiredProducts(); // Fetch data from the backend
    responseData.value = data!;
    print(responseData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAAC7D7),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: const BoxDecoration(color: Color(0xFFAAC7D7)),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
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
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(25)),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 40, top: 40),
                        child: const Text(
                          "All Products Expired",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF768A95),
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // const ListTile(
                      //   // leading: ClipRRect(
                      //   //   child: FancyShimmerImage(
                      //   //     imageUrl: productImageUrl,
                      //   //     height:
                      //   //         90, // Adjust the height as needed
                      //   //     width: 90, // Adjust the width as needed
                      //   //   ),
                      //   // ),
                      //   title: Text(
                      //     "productName",
                      //     style: TextStyle(
                      //       fontSize: 25,
                      //       fontWeight: FontWeight.w700,
                      //       color: Color.fromARGB(255, 81, 81, 81),
                      //     ),
                      //     maxLines: 2,
                      //   ),
                      //   subtitle: Row(
                      //     children: [
                      //       Text(
                      //         "Expired on",
                      //         style: TextStyle(
                      //           color: Colors.grey,
                      //           fontSize: 15,
                      //         ),
                      //       ),
                      //       SizedBox(width: 10),
                      //       Text(
                      //         "expirationDate",
                      //         style: TextStyle(
                      //           color: Colors.grey,
                      //           fontSize: 15,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Center(
                      //   child: FutureBuilder<List<dynamic>>(
                      //     future: getAllexpiredProducts(),
                      //     builder: (context, snapshot) {
                      //       print("object1 : ");
                      //       if (snapshot.connectionState ==
                      //           ConnectionState.waiting) {
                      //         print("object2 : ");
                      //         return const CircularProgressIndicator();
                      //       } else if (snapshot.hasError) {
                      //         print("object3 : ");
                      //         return Text("Error: ${snapshot.error}");
                      //       } else if (!snapshot.hasData ||
                      //           snapshot.data == null) {
                      //         print("object4 : ");
                      //         return const Text(
                      //             "Product information not available");
                      //       } else {
                      //         final productList = snapshot.data!;
                      //         print("list product : $productList ");
                      //         // Create a ListView to display each product
                      //         return ListView.builder(
                      //           itemExtent: 120,
                      //           itemCount: productList.length,
                      //           itemBuilder: (context, index) {
                      //             final product = productList[index];
                      //             final productName =
                      //                 product["name"] ?? "Name not available";
                      //             final productImageUrl =
                      //                 product["image"] ?? "url_not_available";
                      //             final expirationDate = product[
                      //                     "expired_at"] ??
                      //                 "N/A"; // Use the actual expiration date if available

                      //             return ListTile(
                      //               // leading: ClipRRect(
                      //               //   child: FancyShimmerImage(
                      //               //     imageUrl: productImageUrl,
                      //               //     height:
                      //               //         90, // Adjust the height as needed
                      //               //     width: 90, // Adjust the width as needed
                      //               //   ),
                      //               // ),
                      //               title: Text(
                      //                 productName,
                      //                 style: const TextStyle(
                      //                   fontSize: 25,
                      //                   fontWeight: FontWeight.w700,
                      //                   color: Color.fromARGB(255, 81, 81, 81),
                      //                 ),
                      //                 maxLines: 2,
                      //               ),
                      //               subtitle: Row(
                      //                 children: [
                      //                   const Text(
                      //                     "Expired on",
                      //                     style: TextStyle(
                      //                       color: Colors.grey,
                      //                       fontSize: 15,
                      //                     ),
                      //                   ),
                      //                   const SizedBox(width: 10),
                      //                   Text(
                      //                     expirationDate,
                      //                     style: const TextStyle(
                      //                       color: Colors.grey,
                      //                       fontSize: 15,
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             );
                      //           },
                      //         );
                      //       }
                      //     },
                      //   ),
                      // ),

                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Expanded(
                            child: Obx(() => ListView.builder(
                                  // itemCount: controller.propertyCount.value,
                                  itemCount: responseData.length,
                                  itemBuilder: ((context, index) {
                                    final name = responseData[index]['name'];
                                    final expire =
                                        responseData[index]['expired_at'];
                                    final properties = responseData[index]
                                        ['properties'] as List<dynamic>?;

                                    if (properties != null) {
                                      // final propertyNames = properties.map((property) => property['name'] as String).toList();
                                      return GestureDetector(
                                        onTap: () {
                                          Get.to(() => const MainScreen());
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              '',
                                              style: TextStyle(
                                                color: Color(0xFF768A95),
                                                fontSize: 24,
                                              ),
                                            ),
                                            for (var property in properties)
                                              ListTile(
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 20, 40, 10),
                                                title: Row(
                                                  children: [
                                                    Container(
                                                      width:
                                                          35, // Set the width as needed
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          // border: Border.all(width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            property['name']
                                                                    as String? ??
                                                                'No name',
                                                            // controller.property.value[index]
                                                            //     .propertyName,
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF768A95),
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                          Text(
                                                            // "Expired At: " +
                                                            //         DateFormat(
                                                            //                 'yyyy-MM-dd')
                                                            //             .format(DateTime
                                                            //                 .parse(
                                                            //                     responseData['expired_at'])) as String? ??
                                                            //     'No Expire',
                                                            // controller
                                                            //     .property.value[index].category,
                                                            // ,
                                                            "responseData",
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF768A95),
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
                                                          color:
                                                              Color(0xFF768A95),
                                                          size: 20,
                                                        ),
                                                        // onTap: () {
                                                        //   Get.to(() =>
                                                        //       PropertyInfo());
                                                        // },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        width:
                                                            12), // Add some spacing between icons
                                                    ZoomTapAnimation(
                                                      child: GestureDetector(
                                                        child: const Icon(
                                                          Icons.delete_rounded,
                                                          color:
                                                              Color(0xFF768A95),
                                                          size: 20,
                                                        ),
                                                        onTap: () {
                                                          // controller
                                                          // .removeProperty(
                                                          //     index);
                                                        },
                                                      ),
                                                    ),
                                                  ],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
