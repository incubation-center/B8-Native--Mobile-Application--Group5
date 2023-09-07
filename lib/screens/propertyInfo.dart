import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tukdak/controller/dateController.dart';
import 'package:tukdak/controller/propertryController.dart';
import 'package:tukdak/screens/addProperty.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class PropertyInfo extends StatefulWidget {
  const PropertyInfo({super.key});

  @override
  State<PropertyInfo> createState() => _PropertyInfoState();
}



class _PropertyInfoState extends State<PropertyInfo> {
  final AddPropertyController controller = Get.put(AddPropertyController());
  DateController dateController = Get.put(DateController());
  bool expire = false;
  String selectedValue = "Foods";


  @override
  Widget build(BuildContext context) {
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
                                fit: BoxFit.cover,
                              ),
                              // color: Colors.cyanAccent,
                              // border: Border.all(width: 1),
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
                                    controller: controller.propertyNameTextEditingController,
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
                          child:
                          DropdownButton(
                            // controller: controller.categoryNameTextEditingController,
                              value: selectedValue,
                              onChanged: (String? newValue){
                                setState(() {
                                  selectedValue = newValue!;
                                });
                              },
                              items: dropdownItems
                          ),

                          ),
                      Container(
                        padding: const EdgeInsets.only(left:40,top: 20),
                        child: const Text(
                          "Value",
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
                        const TextField(
                          // controller: controller.categoryNameTextEditingController,
                          decoration: InputDecoration(
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
                                controller: dateController.dateController,
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
                                      dateController.dateController.text = formattedDate; //set foratted date to TextField value.
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
                                controller.addProperty(controller.propertyNameTextEditingController.text,
                                  'Skincare',
                                  '#20',
                                  true,
                                  DateTime.now(),
                                  0,            ),
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
          ],
        ),
      ),
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Foods"),value: "Foods"),
    DropdownMenuItem(child: Text("Utilities"),value: "Utilities"),
    DropdownMenuItem(child: Text("Skincare"),value: "Skincare"),
  ];
  return menuItems;
}