import 'package:fake_store/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartList = <Product>[].obs;

  void addToCart(Product product) async {
    if (!cartList.any((item) => item.id == product.id)) {
      cartList.add(product);
      Get.snackbar(
        "Item added successfully",
        "This action adds the item to your favorites",
        duration: const Duration(seconds: 5),
        snackPosition: SnackPosition.TOP,
      );
    } else {

      Get.snackbar(
          "Already Exist",
          "Product already exists in cart.",
          duration: const Duration(seconds: 5),
    snackPosition: SnackPosition.TOP,);
    }
  }
}