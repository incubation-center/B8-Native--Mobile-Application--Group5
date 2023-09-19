import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tukdak/config/services/property.dart';
import 'package:tukdak/config/services/search.dart';
import 'package:tukdak/controller/NavController.dart';
import 'package:tukdak/screens/mainScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Map<String, dynamic>> _allProducts = [];

  String _searchQuery = "";
// This list holds the data for the list view
  List<Map<String, dynamic>> _foundProducts = [];
  bool _isLoading = false;
  @override
  initState() {
    // at the beginning, all users are shown
    _foundProducts = _allProducts;
    _fetchProperties();
    super.initState();
  }

  Future<void> _fetchProperties() async {
    setState(() {
      _isLoading = true;
    });
    try {
      // Replace 'YOUR_API_ENDPOINT' with the actual API endpoint URL
      final response = await fetchPropertyDataWithToken();

      if (response != null) {
        // Create a list to store all properties
        List<Map<String, dynamic>> allProperties = [];

        // Iterate through the categories and collect properties
        for (var category in response) {
          List<dynamic> propertiesData = category['properties'];

          // Map the properties to the desired format and add them to the list
          allProperties.addAll(propertiesData.map((property) {
            return {
              "id": property['id'],
              "name": property['name'],
              "expired_at": property['expired_at'],
              "alert_at": property['alert_at'],
              "image": property['image']
              // Add more fields as needed
            };
          }).toList());
        }

        setState(() {
          _allProducts.addAll(allProperties);
          _isLoading = false;
        });
      } else {
        // Handle the case where there was an error or no token available.
        print('Error or no token available.');
        _isLoading = false;
      }
    } catch (error) {
      print("Error while fetching properties: $error");
      // Handle the error as needed
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
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
    Navigator.of(context).pushReplacementNamed('/');
    // Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (context) => const MainScreen()));
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
                            const Text(
                              "Expired on",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              product['expired_at'] != null
                                  ? DateFormat('dd MMMM yyyy').format(
                                      DateTime.parse(product['expired_at']))
                                  : 'N/A',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            const Spacer(),
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
      // appBar: AppBar(
      //   leading: GestureDetector(
      //       onTap: () {
      //         // Get.back();
      //         // Go back to the '/' route

      //         // Get.to(const MainScreen());
      //         // _navigateToMainScreen(context);
      //       },
      //       child: const Icon(IconlyLight.arrowLeft)),
      //   backgroundColor: const Color(0xFFAAC7D7),
      //   elevation: 0,
      // ),
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
              _isLoading // Show loading indicator if _isLoading is true
                  ? const CircularProgressIndicator()
                  : _foundProducts.isEmpty
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
                        ),
            ],
          )),
    );
  }
}
