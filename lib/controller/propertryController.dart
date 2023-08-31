import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tukdak/models/propertryModel.dart';

class AddPropertyController extends GetxController {
  Rx<List<PropertyModel>> property = Rx<List<PropertyModel>>([]);
  Rx<List<PropertyModel>> expire = Rx<List<PropertyModel>>([]);
  TextEditingController propertyNameTextEditingController = TextEditingController();

  late PropertyModel propertyModel;
  var propertyCount = 0.obs;

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

  addProperty(
      String propertyName,
      String category,
      String value,
      bool expire,
      DatePickerDialog datePicker,
      int alert,
      ) {
      // propertyModel = PropertyModel(propertyName: propertyName);
      // propertyModel = PropertyModel(category: category);
      property.value.add(propertyModel);
      propertyCount.value = property.value.length;

  }

}