import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:tukdak/config/services/search.dart';
import 'package:tukdak/screens/mainScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Map<String, dynamic>> _allProducts = [
    {
      "id": 1,
      "name": "Shoes",
      "url": "https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png"
    },
    {
      "id": 2,
      "name": "Tie",
      "url": "https://m.media-amazon.com/images/I/81AneYFANBL._AC_UY1100_.jpg"
    },
    {
      "id": 3,
      "name": "Shirt",
      "url": "https://m.media-amazon.com/images/I/71+hAYAGnQL._AC_UY1100_.jpg"
    },
    {
      "id": 4,
      "name": "Pant",
      "url":
          "https://res.cloudinary.com/outlandusa/image/upload/q_auto,g_auto/w_800,c_limit/fl_force_strip.progressive/c_pad,h_650,w_800/a68ad625b14363d28786edfd8ae72c9a.jpg"
    },
    {
      "id": 5,
      "name": "Sneaker",
      "url": "https://i.ebayimg.com/images/g/rIYAAOSwe21iJZDy/s-l1200.jpg"
    },
    {
      "id": 6,
      "name": "Shoes Soccer",
      "url":
          "https://s.yimg.com/uu/api/res/1.2/Ba_5XykWvyps7ud3ATjTBw--~B/aD05MDA7dz0xNjAwO2FwcGlkPXl0YWNoeW9u/https://o.aolcdn.com/hss/storage/midas/fb17f61178099f434d4db930420ef6ce/204121737/nikemagista2lede.jpg.cf.jpg"
    },
    {
      "id": 7,
      "name": "Sock",
      "url": "https://m.media-amazon.com/images/I/61wVL6FvJLL._AC_SX425_.jpg"
    },
    {
      "id": 8,
      "name": "Glove",
      "url":
          "https://badworkwear.com.au/cdn/shop/products/bad-stealth-nitrile-grip-safe-insulated-work-gloves-690605.jpg"
    }
  ];

  String _searchQuery = "";
// This list holds the data for the list view
  List<Map<String, dynamic>> _foundProducts = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundProducts = _allProducts;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allProducts;
    } else {
      results = _allProducts
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundProducts = results;
      _searchQuery = enteredKeyword;
    });
  }

  void _navigateToMainScreen(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const MainScreen()),
    // );
    // Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    // Navigator.of(context).pushReplacementNamed('/');
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()));
  }

  void _onSearchButtonPressed() async {
    print("Search Query: $_searchQuery"); // Print the search query

    // Call the SearchData function to perform the search
    try {
      final List<Map<String, dynamic>>? searchResults =
          await SearchData(_searchQuery);

      if (searchResults != null) {
        // Update the UI with the search results
        setState(() {
          _foundProducts = searchResults;
        });
        print("Search Results:");
        for (var result in searchResults) {
          print("ID: ${result['id']}");
          print("Name: ${result['name']}");
          // Add more fields as needed
        }
      } else {
        print("No search results found.");
      }
    } catch (error) {
      print("Error while searching: $error");
      // Handle the error as needed
    }
  }

  Widget buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Expanded(
            child: IntrinsicWidth(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ClipRRect(
                  //   child: FancyShimmerImage(
                  //     imageUrl: product['url'],
                  //     height: 90,
                  //     width: 90,
                  //   ),
                  // ),
                  const SizedBox(
                    width: 10,
                  ),
                  IntrinsicWidth(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              child: Text(
                                product['name'],
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 81, 81, 81),
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
                                  icon: const Icon(IconlyLight.arrowRight),
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
                            Text(
                              "Expired on",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              product['expired_at'] != null
                                  ? product['expired_at'].toString()
                                  : "N/A",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            Spacer(),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Get.back();
              // _navigateToMainScreen(context);
            },
            child: const Icon(IconlyLight.arrowLeft)),
        backgroundColor: const Color(0xFFAAC7D7),
        elevation: 0,
      ),
      body: Container(
          color: const Color(0xFFAAC7D7),
          child: Column(
            children: [
              Container(
                color: const Color(0xFFAAC7D7),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: TextField(
                          onChanged: _runFilter,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Search',
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0, // Adjust the width as needed
                                color: Colors.white,
                                // Adjust the color as needed
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0, // Adjust the width as needed
                                color: Colors
                                    .white, // Set the default color to white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed:
                          _onSearchButtonPressed, // Call the function when the button is pressed
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    )

                    // IconButton(
                    //   onPressed: () {
                    //     // Add your search logic here.
                    //   },
                    //   icon: const Icon(
                    //     Icons.search,
                    //     color: Colors.white,
                    //   ),
                    // )
                  ],
                ),
              ),
              _foundProducts.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'No results found',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(35)),
                        child: ListView.builder(
                          itemCount: _foundProducts.length,
                          itemBuilder: (context, index) {
                            final product = _foundProducts[index];
                            return buildProductCard(product);
                          },
                        ),
                      ),
                    )
            ],
          )),
    );
  }
}
