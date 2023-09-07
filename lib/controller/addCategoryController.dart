import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tukdak/models/categoryName.dart';
import 'package:tukdak/screens/addCategory.dart';

class AddCategoryController extends GetxController {
  Rx<List<CategoryModel>> category = Rx<List<CategoryModel>>([]);
  TextEditingController categoryNameTextEditingController = TextEditingController();

  late CategoryModel categoryModel;
  var itemCount = 0.obs;
  bool isEdit = false;

  @override
  void onInit() {
    super.onInit();
    if(category != null) {
      isEdit = true;
      // categoryNameTextEditingController.text = category.value
      // editCategory(index, categoryName);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    categoryNameTextEditingController.dispose();
  }
  addNewCategory(String categoryName) {
    categoryModel = new CategoryModel(categoryName: categoryName);
    category.value.add(categoryModel);
    itemCount.value = category.value.length;
  }

  editCategory(int index, String categoryName) {
    if (index >= 0 && index < category.value.length) {
      isEdit = true;
      category.value[index].categoryName = categoryName;
      // index = newIndex;
    }
  }

  removeCategory(int index) {
    category.value.removeAt(index);
    itemCount.value = category.value.length;

  }
}