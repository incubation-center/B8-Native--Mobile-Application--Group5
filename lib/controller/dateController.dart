import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DateController extends GetxController {
  TextEditingController dateController = TextEditingController();

  @override
  void onInit(){
    super.onInit();
    dateController.text = "";
  }
}