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
  void setCategories(List<CategoryModel> categories) {
    category.value = categories;
    itemCount.value = categories.length;
  }

  // addNewCategory(String categoryName) {
  //   categoryModel = new CategoryModel(id: id, name: name, createdAt: createdAt, updatedAt: updatedAt, userId: userId)
  //   category.value.add(categoryModel);
  //   itemCount.value = category.value.length;
  // }
  void addNewCategory(String name) {
    // You need to provide values for id, createdAt, updatedAt, and userId.
    final newCategory = CategoryModel(
      id: 'your_id_value', // Replace with an actual ID
      name: name,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      userId: 'your_user_id_value', // Replace with an actual user ID
    );

    category.value.add(newCategory);
    itemCount.value = category.value.length;
  }

  void setCategoryNames(List<String> name) {
    category.value = name.cast<CategoryModel>();
  }
  // editCategory(int index, String categoryName) {
  //   if (index >= 0 && index < category.value.length) {
  //     isEdit = true;
  //     category.value[index].name = categoryName;
  //     // index = newIndex;
  //   }
  // }
  void editCategory(int index, String name) {
    if (index >= 0 && index < category.value.length) {
      // You need to provide values for id, createdAt, updatedAt, and userId.
      category.value[index] = CategoryModel(
        id: 'your_id_value', // Replace with an actual ID
        name: name,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userId: 'your_user_id_value', // Replace with an actual user ID
      );

      isEdit = true;
    }
  }

  removeCategory(int index) {
    category.value.removeAt(index);
    itemCount.value = category.value.length;

  }
}