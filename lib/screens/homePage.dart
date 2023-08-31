import 'package:flutter/material.dart';
import 'package:tukdak/components/nav_bar.dart';
// import 'package:tukdak/components/profilebar.dart';

class SlideData {
  final String section;
  final String text;
  final IconData? icon;

  SlideData(this.section, this.text, [this.icon]);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xFFAAC7D7),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        // title: const ,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              // controller: _pageController,
              // itemCount: userGuideSlides.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // if (userGuideSlides[index].icon != null)
                      // Icon(userGuideSlides[index].icon, size: 64),
                    SizedBox(height: 16),
                    Text(
                      'hello'
                      // userGuideSlides[index].section,
                      // style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'hello'
                      // userGuideSlides[index].text,
                      // style: TextStyle(fontSize: 14, height: 1.5),
                      // textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 10), // Add spacing between content and indicators
          Padding(
            padding: EdgeInsets.only(bottom: 100), // Adjust this value as needed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // children: List.generate(userGuideSlides.length, (index) {
              //   return Container(
              //     width: 15,
              //     height: 10,
              //     margin: EdgeInsets.symmetric(horizontal: 4),
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       // color: _currentPage == index
              //       //     ? Color(0xFFAAC7D7) // Active color
              //       //     : Colors.grey, // Inactive color
              //     ),
              //   );
              // }),
            ),
          ),
        ],
      ),
    );
  }
}
