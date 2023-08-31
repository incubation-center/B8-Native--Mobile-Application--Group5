import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:get/get.dart';

class PropertyList extends StatefulWidget {
  const PropertyList({super.key});

  @override
  State<PropertyList> createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAAC7D7),
      body: SafeArea(
        child: Column(
          children: [
            Container(
            height: 160,
            decoration: BoxDecoration(color: Color(0xFFAAC7D7)),
            child: Padding(
                padding: EdgeInsets.only(left: 15, top: 60)
            ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),
                child: Container(
                  color: Colors.white,
                  child: Expanded(
                    child: Obx(() => ListView.builder(
                      // itemCount: controller.itemCount.value,
                      itemBuilder: ((context, index) {
                        return Container(
                          margin: new EdgeInsets.only(top: 10) ,
                          decoration: BoxDecoration(
                            // color: Color(0xFFDFEBF7),
                            // border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10) ,
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'hello'
                                    // controller.category.value[index].categoryName!,
                                    // style: const TextStyle(
                                    //   color: Color(0xFF768A95),
                                    //   fontSize: 24,
                                    // ),
                                  ),
                                ),
                                ZoomTapAnimation(
                                  child: GestureDetector(
                                    child: const Icon(
                                      Icons.edit_rounded,
                                      color: Color(0xFF768A95),
                                    ),
                                    onTap: () {

                                    },
                                  ),
                                ),
                                const SizedBox(width: 16), // Add some spacing between icons
                                ZoomTapAnimation(
                                  child: GestureDetector(
                                    child: const Icon(
                                      Icons.delete_rounded,
                                      color: Color(0xFF768A95),
                                    ),
                                    onTap: () {
                                      // controller.removeCategory(index);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    )),
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
