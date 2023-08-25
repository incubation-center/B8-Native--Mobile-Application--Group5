import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAAC7D7),
      body: Column(
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(color: Color(0xFFAAC7D7)),
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: 60),
              child: Row(
                children: [
                  ElevatedButton(
                    child: const Text(
                        "+ Category",
                        style: TextStyle(
                          color: Color(0xFFAAC7D7),
                        ),
                    ),
                      onPressed: () {},
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )
                        ),
                      ),
                      ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
          )
        ],
      ),

      // body: Container(
      //   child: Column(
      //       children: [
      //         Container(
      //         height: 160,
      //         color: Color(0xFFAAC7D7),
      //         child: Container(
      //           height: 2,
      //           width: 90,
      //           color: Colors.amberAccent,
                // child: ElevatedButton(
                //   child: const Text('Category'),
                //   onPressed: () {},
                //   style: ElevatedButton.styleFrom(
                //     // primary: Colors.white,
                //     minimumSize: Size(90, 20),
                //     textStyle: const TextStyle(
                //       // color: Color(0xFFAAC7D7),
                //       fontSize: 14,
                //       color: Colors.orangeAccent,
                //       fontStyle: FontStyle.normal,
                //     ),
                //   ),
                //   ),
              // ),
              // ),
              // Expanded(
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),
              //       child: Container(
              //         color: Colors.white,
              //       ),
              //     ),
              // ),
            // ],
      //   ),
      // ),
    );
  }
}
