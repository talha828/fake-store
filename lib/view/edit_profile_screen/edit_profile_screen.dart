import 'dart:io';
import 'package:fake_store/constant/constant.dart';
import 'package:fake_store/widgets/faketextfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  File? image;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('name') ?? '';
      emailController.text = prefs.getString('email') ?? '';
    });
  }

  void _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', nameController.text);
    prefs.setString('email', emailController.text);
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:AppBar(
        iconTheme:const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: themeColorDart,
        title: const Text('Edit Profile',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon:const Icon(Icons.save),
            onPressed: () {
              _saveProfileData();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: image != null ? FileImage(image!) : null,
                    child: image == null ? const Icon(Icons.person, size: 60) : null,
                  ),
                ),
              ],
            ),
            SizedBox(height: width * 0.04),
            FakeTextField(controller: nameController, hintText: "name", labelText: "Name", obscureText: false),
            SizedBox(height: width * 0.04),
            FakeTextField(controller: emailController, hintText: "Email", labelText: "Email", obscureText: false),
            SizedBox(height: width * 0.04),

          ],
        ),
      ),
    );
  }
}
