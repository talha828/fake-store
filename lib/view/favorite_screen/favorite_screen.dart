import 'package:fake_store/constant/constant.dart';
import 'package:fake_store/controller/cart_controller.dart';
import 'package:fake_store/model/product_model.dart';
import 'package:fake_store/widgets/product_card_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
              'Favorite Product',
              style: TextStyle(color: Colors.white),
            ),
          ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: width * 0.04,horizontal: width * 0.04),
        child: Obx(() {
            return ListView.separated(
              itemCount: cartController.cartList.length,
              itemBuilder: (context, index) {
                Product product = cartController.cartList[index];
                return Dismissible(
                  key: Key(product.id.toString()),
                    onDismissed: (direction){
                      setState(() {
                        cartController.cartList.removeAt(index);
                      });
                    },
                    child: ProductCardView(product: product));
              },
              separatorBuilder: (context,index){
                return const SizedBox( height: 10,);
              },
            );
        }),
      ),
    ));
  }
}
