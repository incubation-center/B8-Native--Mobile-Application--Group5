import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tukdak/models/propertryModel.dart';
import 'package:tukdak/screens/propertyInfo.dart';

class AddPropertyController extends GetxController {
  Rx<List<PropertyModel>> property = Rx<List<PropertyModel>>([]);
  Rx<List<PropertyModel>> expire = Rx<List<PropertyModel>>([]);
  TextEditingController propertyNameTextEditingController = TextEditingController();
  TextEditingController valueTextEditingController = TextEditingController();
  TextEditingController DateEditingController = TextEditingController();
  final Rx<File?> _imageFile = Rx<File?>(null);

  // Getter method to access the File object
  File? get imageFile => _imageFile.value;


  late PropertyModel propertyModel;
  var propertyCount = 0.obs;


  void setImageFile(File? file) {
    _imageFile.value = file;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    propertyNameTextEditingController.dispose();
  }

  void handleEdit(){

  }

  addProperty(
      String propertyName,
      String category,
      String value,
      bool expire,
      DateTime pickedDate,
      int alert,
      ) {
      propertyModel = new PropertyModel(propertyName: propertyName, category: category, value: value, expire: expire, pickedDate: pickedDate, alert: alert);
      property.value.add(propertyModel);
      propertyCount.value = property.value.length;
  }

  removeProperty(int index) {
    property.value.removeAt(index);
    propertyCount.value = property.value.length;

  }

  editProperty(int index, String propertyName, String category, String value, bool expire, DateTime pickedDate, int alert) {
    if (index >= 0 && index < property.value.length) {
      PropertyModel updatedProperty = PropertyModel(
        propertyName: propertyName,
        category: category,
        value: value,
        expire: expire,
        pickedDate: pickedDate,
        alert: alert,
      );

      property.value[index] = updatedProperty;
    }
  }

}