import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tukdak/config/services/objectDetection.dart';
import 'package:tukdak/config/services/property.dart';
import 'package:tukdak/controller/propertryController.dart';
import 'package:tukdak/screens/addProperty.dart';
import 'package:tukdak/screens/propertyList.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



class PropertyInfo extends StatefulWidget {
  final String? id;
  final String? image;
  final String? name;
  final String? categoryId;
  final String? price;
  final String? expired_at;
  final String? alert_at;

  const PropertyInfo({
    super.key,
    this.id,
    this.image,
    this.name,
    this.categoryId,
    this.price,
    this.expired_at,
    this.alert_at,
  });

  @override
  State<PropertyInfo> createState() => _PropertyInfoState();
}



class _PropertyInfoState extends State<PropertyInfo> {
  final AddPropertyController controller = Get.put(AddPropertyController());
  final TextEditingController dateController = TextEditingController();
  bool expire = false;
  final TextEditingController propertyController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController alertController = TextEditingController();
  var imageUrlStirng;
  var downloadedImage;

  bool isEdit = false;

  List data = [];
  // int _value = 1;
  String selectedValue = "";
  List categoryItemlist = [];
  var dropdownvalue;

  @override
  void initState() {
    super.initState();
    onDetectObject();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final propData = widget.name;
    final imageUrl = widget.image ?? "";
    final categoryId = widget.categoryId;
    final price = widget.price ?? "";
    final expired_at = widget.expired_at ?? "";
    final alert_at = widget.alert_at ?? "";

    downloadedImage = await downloadImage(imageUrl);

    print("imageUrl: $imageUrl");

    if (propData != null) {
      setState(() {
        isEdit = true;
        propertyController.text = propData;
        dropdownvalue = categoryId;
        priceController.text = price;
        dateController.text = expired_at;
        alertController.text = alert_at;
        imageUrlStirng = imageUrl;
      });
    }
  }

  Future<File> downloadImage(String imageId) async {
    final response = await http.get(Uri.parse(imageId));

    if (response.statusCode == 200) {
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/image.jpg');
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception('Failed to download image');
    }
  }

  Future getData() async {
    final token = await secureStorage.read(key: 'auth_token');
    final url = Uri.parse('http://18.143.209.45/category/all');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body) as List;
      setState(() {
        categoryItemlist = jsonData;
      });
    }
  }

    void showSuccessMessage(String message) {
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    void showErrorMessage(String message) {
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  void onSubmitData() async {
    final property = propertyController.text;
    final price = priceController.text;
    final alert = alertController.text;
    final date = dateController.text;
    var imageFile = controller.imageFile;
    Map<String, dynamic> body = {};
    try {
      if(date != null && alert != null){
        body = {
          "name": property,
          "price": price,
          "categoryId": dropdownvalue,
          "expired_at": date,
          "alert_at": alert,
          "image": imageFile
        };
      } else {
        body = {
          "name": property,
          "price": price,
          "categoryId": dropdownvalue,
          "expired_at": "",
          "alert_at": "",
          "image": imageFile
        };
      }
      print(body);
      final response = await postPropertyDataWithToken(body); // Call the post function with your data
      // if (response != null) {
        Get.snackbar(
          'Success',
          'Property has been created',
          backgroundColor: const Color.fromARGB(255, 170, 215, 206),
        );
        print("Response from server: $response");
      // }
    } catch (e) {
      // Handle any errors that may occur during the request
      print("Error sending data to server: $e");
    }
  }

  void onDetectObject() async {
    var imageFile = controller.imageFile;
    final body = {
      "image" : imageFile
    };
    try {
      print("image file: $imageFile");
      print(body);
      final response = await postDetectionImage(body); // Call the post function with your data
      if (response != null) {
        propertyController.text = response;
        print("Response from server: $response");
      } else {
        propertyController.text = '';
      }
    } catch (e) {
      // Handle any errors that may occur during the request
      print("Error sending image to server: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Image String: $imageUrlStirng");
    getData();
    return Scaffold(
      backgroundColor: Color(0xFFAAC7D7),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(color: Color(0xFFAAC7D7)),
              child:
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_rounded, size: 30,),
                      color: Colors.white ,
                    ),
                  ],
                ),
              ),
            ),
            // SingleChildScrollView(
              Expanded(
                child:
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),
                  child: Center(
                    child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if(isEdit == true)
                                Container(
                                  margin: new EdgeInsets.only(left: 40, top: 25),
                                  width: 80,
                                  height: 110,
                                  child: imageUrlStirng != null
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    // child: Image(
                                    //   // image: FileImage(controller.imageFile!),
                                    //   image: FileImage(downloadedImage),
                                    //   fit: BoxFit.cover,
                                    // )
                                    child: Image.network(imageUrlStirng),
                                  )
                                      : const Center(
                                    child: Text(
                                      'No Image', // Display a message when image is empty
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                              ),
                                if(isEdit == false)
                                  Container(
                                    margin: new EdgeInsets.only(left: 40, top: 25),
                                    width: 80,
                                    height: 110,
                                    child: controller.imageFile
                                        != null
                                        ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                        image: FileImage(controller.imageFile!),
                                        // image: FileImage(downloadedImage),
                                        fit: BoxFit.cover,
                                      )
                                      // child: Image.network(imageUrlStirng),
                                    )
                                        : const Center(
                                      child: Text(
                                        'No Image', // Display a message when image is empty
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 40, top: 50),
                                      child: const Text(
                                        "Name",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF768A95),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        width: 200,
                                        padding: const EdgeInsets.only(left:40),
                                        child:
                                        TextField(
                                          // controller: controller.propertyNameTextEditingController,
                                          controller: propertyController,
                                          decoration: const InputDecoration(
                                              focusColor: Color(0xFF768A95),
                                              hintText: 'Enter name',
                                              hintStyle: TextStyle(
                                                  color: Color(0xFFC6D0D6)
                                              )
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                            ],
                            ),

                            Container(
                              padding: const EdgeInsets.only(left:40,top: 20),
                              child: const Text(
                                "Category",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF768A95),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                                width: 300,
                                padding: const EdgeInsets.only(left:40),
                                child: DropdownButton(
                                  value: dropdownvalue,
                                  items: categoryItemlist.map((item) {
                                    return DropdownMenuItem(
                                      value: item['id'].toString(),
                                      child: Text(item['name'].toString()),
                                    );
                                  }).toList(),
                                  onChanged: ( newValue) {
                                    setState(() {
                                      dropdownvalue = newValue;
                                    });
                                    print("category list----------- $dropdownvalue");
                                  },
                                ),

                                ),
                            Container(
                              padding: const EdgeInsets.only(left:40,top: 20),
                              child: const Text(
                                "Price",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF768A95),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              width: 300,
                              padding: const EdgeInsets.only(left:40),
                              child:
                              TextField(
                                // controller: controller.categoryNameTextEditingController,
                                controller: priceController,
                                decoration: const InputDecoration(
                                    focusColor: Color(0xFF768A95),
                                    hintText: 'Enter the price worth',
                                    hintStyle: TextStyle(
                                        color: Color(0xFFC6D0D6)
                                    )
                                ),
                              ),
                            ),

                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left:40),
                                  child: const Text(
                                    "Expired",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF768A95),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left:40),
                                  child: Transform.scale(
                                    scale: 0.7,
                                    child: Checkbox(
                                      activeColor: Color(0xFF768A95),
                                      value: isEdit ? true : this.expire,
                                      onChanged: (bool? value) {
                                        if (isEdit) {
                                          this.expire = true;
                                        } else {
                                          this.expire = value!;
                                        }
                                      },
                                      ),
                                  ),
                                  ),

                                  ],
                                ),
                          if(expire || isEdit)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 300,
                                  padding: const EdgeInsets.only(left:40),
                                  child: TextField(
                                      style: const TextStyle(
                                        fontSize: 16,
                                        // color: Color(0xFFC6D0D6)
                                      ),
                                      controller: dateController,
                                      decoration: const InputDecoration(//icon of text field
                                        hintText: "Enter Date" ,
                                        hintStyle: TextStyle(
                                            color: Color(0xFFC6D0D6)
                                        ),
                                        suffixIcon: Icon(Icons.calendar_today),
                                        //label text of field
                                      ),
                                      readOnly: true,  // when true user cannot edit text
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(), //get today's date
                                          firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2101),
                                          builder: (BuildContext context, Widget? child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith( // Customize the theme here
                                                primaryColor: Color(0xFF768A95), // Change the header color
                                                hintColor: Color(0xFF768A95),  // Change the selected date color
                                                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), // Change the button text color
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if(pickedDate != null ){
                                          print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                          print(formattedDate); //formatted date output using intl package =>  2022-07-04
                                          //You can format date as per your need

                                          setState(() {
                                            dateController.text = formattedDate; //set foratted date to TextField value.
                                          });
                                        }else{
                                          print("Date is not selected");
                                        }
                                      }
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left:40,top: 20),
                                  child: const Text(
                                    "Alert",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF768A95),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Row(
                                  // mainAxisSize: MainAxisSize.min,
                                  children:[
                                  Container(
                                    width: 200,
                                    padding: const EdgeInsets.only(left:40),
                                      child: TextField(
                                        controller: alertController,
                                        keyboardType: TextInputType.number, // Set numeric keyboard
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly // Allow only digits
                                        ],
                                        decoration: const InputDecoration(
                                            focusColor: Color(0xFF768A95),
                                            hintText: 'Enter duration',
                                            hintStyle: TextStyle(
                                                color: Color(0xFFC6D0D6)
                                            ),
                                        ),
                                      ),
                                  ),
                                    const Text(
                                      "Day(s) before",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF768A95),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Center(
                              child: Container(
                                width: 320,
                                padding: const EdgeInsets.only(top: 20, bottom: 40),
                                child:
                                ZoomTapAnimation(
                                  child: ElevatedButton(
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        onSubmitData();
                                        Get.back();
                                      });
                                    },
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF768A95)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            // ),
          ],
        ),
      ),
    );
  }


// List<DropdownMenuItem<String>> get dropdownItems{
//   List<DropdownMenuItem<String>> menuItems = [
//     DropdownMenuItem(child: Text("Foods"),value: "Foods"),
//     DropdownMenuItem(child: Text("Utilities"),value: "Utilities"),
//     DropdownMenuItem(child: Text("Skincare"),value: "Skincare"),
//   ];
//   return menuItems;
// }
}
