import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPropertyController extends GetxController {

  final Rx<File?> _imageFile = Rx<File?>(null);

  // Getter method to access the File object
  File? get imageFile => _imageFile.value;

  void setImageFile(File? file) {
    _imageFile.value = file;
  }

  @override
  void onInit() {
    super.onInit();
  }




}