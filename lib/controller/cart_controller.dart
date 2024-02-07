import 'package:fake_store/model/product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartList = <Product>[].obs;

  void addToCart(Product product) {
    cartList.add(product);
  }
}