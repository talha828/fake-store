import 'package:fake_store/constant/constant.dart';
import 'package:fake_store/model/product_model.dart';
import 'package:fake_store/view/product_detail_screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCardView extends StatelessWidget {
  const ProductCardView(
      {Key? key,
        required this.product,
        this.imageAlignment = Alignment.bottomCenter,
        this.onTap})
      : super(key: key);

  final Product product;
  final Alignment imageAlignment;
  final Function(String)? onTap;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: ()=>Get.to(ProductDetailScreen(product: product)),
      child: Container(
        padding:const EdgeInsets.symmetric(vertical: 15,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.grey.withOpacity(0.5))
        ),
        width: 150,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              SizedBox(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Hero(
                    tag: product.id,
                    child: Image.network(product.image,
                        alignment: imageAlignment, fit: BoxFit.contain),
                  )),
            ],
          ),
          const SizedBox(height: 8),
          ListTile(
            title: Text(product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
            subtitle:SizedBox(
                child: Text(product.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: Theme.of(context).textTheme.caption)),
            trailing: Text('${product.price} €',
                maxLines: 1,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: themeColorDart)),
          ),
        ]),
      ),
    );
  }
}