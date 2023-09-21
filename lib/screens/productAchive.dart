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
                                      SizedBox(
                                        child: Text(
                                          productName,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color:
                                            Color(0xFF768A95),
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              // Add your logic here for what should happen when the arrow button is clicked.
                                            },
                                            icon: const Icon(
                                                IconlyLight.arrowRight,
                                            color: Color(0xFF768A95),),
                                            iconSize: 16,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Expired on",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        formattedExpiredAt,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
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
