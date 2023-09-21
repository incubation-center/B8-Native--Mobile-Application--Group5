import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tukdak/config/services/property.dart';
import 'package:tukdak/controller/propertryController.dart';
import 'package:tukdak/screens/addProperty.dart';
import 'package:tukdak/screens/propertyList.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



class PropertyInfo extends StatefulWidget {
  final String? id;
  final String? name;
  final String? categoryId;
  final String? price;
  final String? expired_at;
  final String? alert_at;

  const PropertyInfo({
    super.key,
    this.id,
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

  bool isEdit = false;

  List data = [];
  // int _value = 1;
  String selectedValue = "";
  List categoryItemlist = [];
  var dropdownvalue;
  // String selectedValue = "Foods";

  @override
  void initState(){
    super.initState();
    final propData = widget.name;
    final categoryId = widget.categoryId;
    final price = widget.price != null ? widget.price.toString() : "";
    final expired_at = widget.expired_at != null ? widget.expired_at.toString() : "";
    final alert_at = widget.alert_at != null ? widget.alert_at.toString() : "";
    if (propData != null) {
      isEdit = true;
      final name = propData;
      final category = categoryId;
      final priceId = price;
      final expireId = expired_at;
      final alertId = alert_at;
      propertyController.text = name;
      dropdownvalue = category;
      priceController.text = priceId;
      dateController.text = expireId;
      alertController.text = alertId;
    }

    // List<int> imageBytes = controller.imageFile!.readAsBytesSync();
    // String imageString = base64Encode(imageBytes);
    // print('--------------------------------------------------');
    // print(imageString.runtimeType);
  }

  Future getData() async {
    final token = await secureStorage.read(key: 'auth_token');
    // final url = Uri.parse('http://127.0.0.1:8000/category/all');
    final url = Uri.parse('http://18.140.59.77:8000/category/all');

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



//   void onSubmitData() async {
//     // final data = await postCategoryDataWithToken();
//     final property = propertyController.text;
//     final price = priceController.text;
//     final alert = alertController.text;
//     final date = dateController.text;
//     final imageFile = controller.imageFile!;
//     // final bytes = await File(imageFile).readAsBytes();
//     // final img.Image image = img.decodeImage(bytes);
//     // final String filePath = imageFile!.path; // Replace with the actual method or property
//
// // Create a File object from the file path
// //     final File file = File(filePath);
// //     final image = imageFile.readAsBytesSync();
//
//     // Create a FormData object to hold your data
//     final formData = http.MultipartRequest('POST', Uri.parse('http://18.140.59.77:8000/property'));
//     formData.fields.addAll({
//       'name': property,
//       'price': price,
//       'categoryId': dropdownvalue,
//       'expired_at': date,
//       'alert_at': alert,
//     });
//     // print(image.runtimeType);
//     print(imageFile.runtimeType);
//
//     if (imageFile != null) {
//       // Stream<List<int>> imageStream = Stream.fromIterable([image]);
//       // http.ByteStream stream = http.ByteStream(imageStream);
//       // final imageStream= http.ByteStream(imageFile.openRead());
//       // final imageLength = await imageFile.length();
//
//       formData.files.add(
//         http.Mu(
//           'image',
//           imageFile,
//           filename: 'image.jpg',
//         ),
//       );
//     }

    // Send the request
    // final response = await formData.send();
    //
    // if (response.statusCode == 200) {
    //   // Request was successful
    //   propertyController.text = '';
    //   showSuccessMessage('Creation Success');
    //   print("Response from server: ${await response.stream.bytesToString()}");
    // } else {
    //   // print(image.runtimeType);
    //   print(imageFile.runtimeType);
    //   // Handle errors here
    //   showErrorMessage('Creation Failed');
    //   print("Error sending data to server: ${response.reasonPhrase}");
    // }
    // final image = imageBytes;
    // final body = {
    //   "name" : property,
    //   "price" : price,
    //   "categoryId": dropdownvalue,
    //   "expired_at" : date,
    //   "alert_at" : alert,
    //   "image" : ,
    // };
    // formData.fields.add(MapEntry('name', property));
    // formData.fields.add(MapEntry('price', price));
    // formData.fields.add(MapEntry('categoryId', dropdownvalue));
    // formData.fields.add(MapEntry('expired_at', date));
    // formData.fields.add(MapEntry('alert_at', alert));
    //
    // // Check if an image file is available and add it to the FormData
    // if (imageFile != null) {
    //   formData.files.add(
    //     MapEntry(
    //       'image', // This should match the server's expected field name for the image
    //       MultipartFile.fromFile(
    //         'image',
    //         imageFile.readAsBytesSync(),
    //         filename: 'image.jpg', // You can change the filename as needed
    //       ),
    //     ),
    //   );
    // }
    // try {
    //   final response = await postPropertyDataWithToken(formData); // Call the post function with your data
    //   if (response != null) {
    //     propertyController.text = '';
    //     // Handle the response from the server here
    //     showSuccessMessage('Creation Success');
    //     print("Response from server: $response");
    //   }
    // } catch (e) {
    //   showErrorMessage('Creation Failed');
    //   // Handle any errors that may occur during the request
    //   print("Error sending data to server: $e");
    //   // print(imageBytes.runtimeType);
    // }
  // }

  // Future<File> getImageFileFromAsset(String assetPath) async {
  //   final ByteData data = await rootBundle.load(assetPath);
  //   final List<int> bytes = data.buffer.asUint8List();
  //   final tempDir = await getTemporaryDirectory();
  //   final tempFile = File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png');
  //   await tempFile.writeAsBytes(bytes, flush: true);
  //   return tempFile;
  // }

  void onSubmitData() async {
    // final data = await postCategoryDataWithToken();
    final property = propertyController.text;
    final price = priceController.text;
    final alert = alertController.text;
    final date = dateController.text;
    var imageFile = controller.imageFile!;
    // if (imageFile != null){
    //   final image = imageFile.readAsBytesSync();
    //   final propImage = base64Encode(image);
    // }
    //
    final body = {
      "name" : property,
      "price" : price,
      "categoryId": dropdownvalue,
      "expired_at" : date,
      "alert_at" : alert,
      "image" : imageFile
    };
    try {
      print(body);
      final response = await postPropertyDataWithToken(body); // Call the post function with your data
      if (response != null) {
        // propertyController.text = '';
        // Handle the response from the server here
        Get.snackbar(
          'Success',
          'Property has been created',
          backgroundColor: const Color.fromARGB(255, 170, 215, 206),
        );
        print("Response from server: $response");
      }
    } catch (e) {
      // Handle any errors that may occur during the request
      print("Error sending data to server: $e");
    }
  }

  void _onSaveButtonPressed() {
    onSubmitData();
    // if(propertyController.text != null &&
    //   dropdownvalue != null &&
    //   priceController.text != null &&
    //   dateController.text != null &&
    //   alertController.text != null
    // ) {
    //   // final imageFile = controller.imageFile!;
    //   // final image = imageFile.readAsBytesSync();
    //   // final propImage = base64Encode(image);
    //   // Get.to(() => PropertyList(selectedCategory: dropdownvalue));
    //   Get.back();
    // } else {
    //   Get.snackbar(
    //     'Error',
    //     'Input cannot be empty',
    //     backgroundColor: const Color.fromARGB(255, 170, 215, 206),
    //   );
    // }
  }


  @override
  Widget build(BuildContext context) {
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: new EdgeInsets.only(left: 40, top: 25),
                                width: 80 ,
                                height: 110,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(controller.imageFile!),
                                    // image: FileImage(File(controller.imageFile!.path)),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                            ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 40, top: 50),
                                    child: const Text(
                                      "Name",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF768A95),
                                        fontSize: 24,
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
                                    value: this.expire,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        this.expire = value!;
                                      });
                                    },
                                    ),
                                ),
                                ),

                                ],
                              ),
                        if(expire)
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
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(
                                      color: Colors.white,
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

