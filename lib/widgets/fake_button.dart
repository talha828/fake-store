
import 'package:fake_store/constant/constant.dart';
import 'package:flutter/material.dart';

class FakeButton extends StatelessWidget {
  const FakeButton({
    super.key,
    required this.onTap,
    required this.width,
    required this.title,
  });

  final void Function()? onTap;
  final double width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            vertical: width * 0.04, horizontal: width * 0.04),
        decoration: BoxDecoration(
            color: themeColorDart,
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
