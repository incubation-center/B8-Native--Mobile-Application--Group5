import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Eachproductscreen extends StatefulWidget {
  final String id;
  final String name;
  final String price;
  final String image;
  final String createdAt;
  final String expired_at;

  const Eachproductscreen(
      {Key? key,
      required this.id,
      required this.name,
      required this.price,
      required this.image,
      required this.createdAt,
      required this.expired_at})
      : super(key: key);

  @override
  State<Eachproductscreen> createState() => _EachproductscreenState();
}

class _EachproductscreenState extends State<Eachproductscreen> {
  final TextEditingController property = TextEditingController();
  // final TextEditingController priceId = TextEditingController();
  // final TextEditingController priceId = TextEditingController();
  var propertyName;
  var propertyPrice;
  var propertyImage;
  var propcreatedAt;
  var propexpiredAt;

  @override
  void initState() {
    super.initState();
    final propData = widget.name;
    final propPrice = widget.price != null ? widget.price.toString() : "noce";
    final propImage = widget.image;
    final propCreateat = widget.createdAt;
    final propexpiredat = widget.expired_at;

    if (propData != null
        // && propPrice != null
        ) {
      final name = propData;
      final price = propPrice;
      final image = propImage;
      final createAt = propCreateat;
      final expired_at = propexpiredat;
      property.text = name;
      // priceId.text = price;
      propertyName = name;
      propertyPrice = price;
      propertyImage = image;
      propcreatedAt = createAt;
      propexpiredAt = expired_at;
      print(propexpiredAt);
      print(propertyImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAAC7D7),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 120,
              decoration: const BoxDecoration(color: Color(0xFFAAC7D7)),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
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
                child: Center(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                // margin: const EdgeInsets.only(left: 40, top: 25),
                                width: 120,
                                height: 170,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(propertyImage),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    propertyName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    'Create At $propcreatedAt',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'Expired At $propexpiredAt',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'price \$$propertyPrice',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
