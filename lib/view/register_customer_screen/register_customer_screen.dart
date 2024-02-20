import 'package:fake_store/constant/constant.dart';
import 'package:fake_store/generated/assets.dart';
import 'package:fake_store/widgets/fake_button.dart';
import 'package:fake_store/widgets/faketextfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterCustomerScreen extends StatefulWidget {
  const RegisterCustomerScreen({super.key});

  @override
  State<RegisterCustomerScreen> createState() => _RegisterCustomerScreenState();
}

class _RegisterCustomerScreenState extends State<RegisterCustomerScreen> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController rate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme:const IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: themeColorDart,
          leading: IconButton(icon:const Icon(Icons.arrow_back),onPressed: ()=>Get.back(),),
          title:const Text("Register Customer",style: TextStyle(color: Colors.white),),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: width * 0.04, horizontal: width * 0.04),
            child: Column(
              children: [
                // SizedBox(
                //   height: width * 0.04,
                // ),
                Image.asset(
                  Assets.imageCustomer,
                  // height: width * 0.4,
                  // fit: BoxFit.fitHeight,
                ),
                SizedBox(
                  height: width * 0.04,
                ),
                FakeTextField(
                    obscureText: false,
                    controller: name,
                    hintText: "Ahmed Faraz",
                    labelText: "Customer Name"),
                SizedBox(
                  height: width * 0.04,
                ),
                FakeTextField(
                    obscureText: false,
                    controller: number,
                    hintText: "03012070920",
                    labelText: "Customer Number"),
                SizedBox(
                  height: width * 0.04,
                ),
                FakeTextField(
                    obscureText: false,
                    controller: quantity,
                    hintText: "1",
                    labelText: "Milk Quantity (Liter wise)"),
                SizedBox(
                  height: width * 0.04,
                ),
                FakeTextField(
                    obscureText: false,
                    controller: rate,
                    hintText: "200L",
                    labelText: "Rate (Liter wise)"),
                SizedBox(
                  height: width * 0.04,
                ),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: IgnorePointer(
                    ignoring: true,
                    child: FakeTextField(
                        obscureText: false,
                        controller: name,
                        hintText: "12-12-2012",
                        labelText: "${selectedDate.toLocal()}".split(' ')[0]),
                  ),
                ),
                SizedBox(
                  height: width * 0.2,
                ),
                FakeButton(onTap: (){}, width: width, title: "Register Customer")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
