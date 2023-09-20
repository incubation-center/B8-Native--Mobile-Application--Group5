import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tukdak/config/services/allproducexpired.dart';

class ProductAchivescreen extends StatefulWidget {
  ProductAchivescreen({super.key});

  @override
  State<ProductAchivescreen> createState() => _ProductArchivescreenState();
}

class _ProductArchivescreenState extends State<ProductAchivescreen> {
  List<Map<String, dynamic>> responseData = []; // Changed to a regular list

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final data = await getAllexpiredProducts(); // Fetch data from the backend
    setState(() {
      responseData = data ?? []; // Update the response data
    });
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
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                ),
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
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
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: responseData.length,
                          itemBuilder: (context, index) {
                            final product = responseData[index];
                            final productName = product['name'] ?? 'No Name';
                            final expiredAt = product['expired_at'] ?? 'N/A';
                            final imageUrl = product['image'];
                            final formattedExpiredAt = expiredAt != 'N/A'
                                ? DateFormat('dd MMMM yyyy')
                                    .format(DateTime.parse(expiredAt))
                                : 'N/A';
                            return Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        child: imageUrl != null
                                            ? FancyShimmerImage(
                                                imageUrl:
                                                    imageUrl, // Use the API image URL
                                                height: 90,
                                                width: 90,
                                              )
                                            : Container(
                                                height: 90,
                                                width: 90,
                                                decoration: BoxDecoration(
                                                  color: Colors
                                                      .grey, // Set a background color for the container
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10), // Apply rounded corners if desired
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(
                                                              0.3), // Apply a shadow to the container
                                                      spreadRadius: 2,
                                                      blurRadius: 4,
                                                      offset: Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Image.asset(
                                                    'assets/images/dimg.png',
                                                    height:
                                                        60, // Adjust the height and width of the image as needed
                                                    width: 60,
                                                    fit: BoxFit
                                                        .contain, // Adjust the image fit as needed (e.g., BoxFit.cover)
                                                  ),
                                                ),
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              productName,
                                              style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromARGB(
                                                    255, 81, 81, 81),
                                              ),
                                            ),
                                            Text(
                                              "Expired on $formattedExpiredAt",
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            );
                          },
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
