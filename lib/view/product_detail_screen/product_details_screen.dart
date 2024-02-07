import 'package:fake_store/constant/constant.dart';
import 'package:fake_store/controller/cart_controller.dart';
import 'package:fake_store/model/product_model.dart';
import 'package:fake_store/widgets/fake_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Get.back(),
          ),
          backgroundColor: themeColorDart,
          title: const Text(
            'Product Details',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: width * 0.04, horizontal: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: widget.product.id,
                child: Image.network(
                  widget.product.image,
                  height: width * 0.7,
                ),
              ),
              SizedBox(
                height: width * 0.04,
              ),
              Text(
                widget.product.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: width * 0.05),
              ),
              SizedBox(
                height: width * 0.04,
              ),
              Text(
                widget.product.description,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: width * 0.04,
              ),
              Text(
                "${widget.product.price.toString()} €",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.08,
                    color: themeColorDart),
              ),
              SizedBox(
                height: width * 0.04,
              ),
              Text(
                widget.product.category,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: width * 0.2,
              ),
              FakeButton(onTap: (){
                cartController.addToCart(widget.product);
                }, width: width, title:"Favorites"),
            ],
          ),
        ),
      ),
    );
  }
}
