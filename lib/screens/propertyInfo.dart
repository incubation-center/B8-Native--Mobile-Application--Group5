import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tukdak/config/services/property.dart';
import 'package:tukdak/controller/dateController.dart';
import 'package:tukdak/controller/propertryController.dart';
import 'package:tukdak/screens/addProperty.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class PropertyInfo extends StatefulWidget {
  const PropertyInfo({super.key});

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
  final TextEditingController imageController = TextEditingController();

  List data = [];
  // int _value = 1;
  String selectedValue = "";
  List categoryItemlist = [];
  var dropdownvalue;
  // String selectedValue = "Foods";

  @override
  void initState(){
    super.initState();
    dateController.text = "";
    getData();
  }

  Future getData() async {
    final token = await secureStorage.read(key: 'auth_token');
    final url = Uri.parse('http://127.0.0.1:8000/category/all');

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
    // final data = await postCategoryDataWithToken();
    final property = propertyController.text;
    final price = priceController.text;
    final alert = alertController.text;
    final date = dateController.text;
    final image = imageController.text;
    final body = {
      "name" : property,
      "price" : price,
      "categoryId": dropdownvalue,
      "expired_at" : date,
      "alert_at" : alert,
      "image" : "",
    };
    try {
      final response = await postPropertyDataWithToken(body); // Call the post function with your data
      if (response != null) {
        propertyController.text = '';
        // Handle the response from the server here
        showSuccessMessage('Creation Success');
        print("Response from server: $response");
      }
    } catch (e) {
      showErrorMessage('Creation Failed');
      // Handle any errors that may occur during the request
      print("Error sending data to server: $e");
    }
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
                                  // image: FileImage(controller.imageFile!),
                                  image: FileImage(File(controller.imageFile!.path)),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10)
                              ),
                          ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                  dropdownvalue = newValue!;
                                });
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
                            padding: const EdgeInsets.only(top: 20),
                            child:
                            ZoomTapAnimation(
                              child: ElevatedButton(
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () =>  {
                                  // controller.addProperty(controller.propertyNameTextEditingController.text,
                                    setState(() {
                                      onSubmitData();
                                    }),
                                    'Skincare',
                                    '#20',
                                    true,
                                    DateTime.now(),
                                    0,
                                  // Get.to(() => PropertyList()),
                                  // controller.addNewCategory(controller.categoryNameTextEditingController.text),
                                  Get.back(),
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

