import 'package:fake_store/constant/constant.dart';
import 'package:fake_store/controller/cart_controller.dart';
import 'package:fake_store/controller/product_controller.dart';
import 'package:fake_store/generated/assets.dart';
import 'package:fake_store/model/product_model.dart';
import 'package:fake_store/view/favorite_screen/favorite_screen.dart';
import 'package:fake_store/view/login_screen/login_screen.dart';
import 'package:fake_store/widgets/product_card_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ProductController productController = Get.put(ProductController());

  final CartController cartController = Get.put(CartController());
  FirebaseAuth auth = FirebaseAuth.instanceFor(app: Firebase.app('Fake Store'));

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme:const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: themeColorDart,
        title: const Text('Products',style: TextStyle(color: Colors.white),),
      ),
      drawer:  Drawer(

        child: ListView(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: const BoxDecoration(
                color: themeColorDart,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: themeColorDart),
                accountName: const Text(
                  "Fake Store",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                accountEmail:  Text(auth.currentUser!.email!.toString(),
                  style:const TextStyle(color: Colors.white),
                ),
                currentAccountPictureSize: const Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Icon(Icons.person,size: width * 0.1,)),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorite Product'),
              onTap: ()=>Get.to(const FavoriteScreen())
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profile'),
              onTap: () async {
                },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () async {
                SharedPreferences prefer =
                await SharedPreferences.getInstance();
                prefer.setString("email", "null");
                prefer.setString("password", "null");
                Get.to(const LoginScreen());
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: width * 0.04,horizontal: width * 0.04),
        child: Obx(() {
          if (productController.productList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.separated(
              itemCount: productController.productList.length,
              itemBuilder: (context, index) {
                Product product = productController.productList[index];
                return ProductCardView(product: product);
              },
              separatorBuilder: (context,index){
                return const SizedBox( height: 10,);
              },
            );
          }
        }),
      ),
    );
  }
}
