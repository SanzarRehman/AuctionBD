import 'dart:io';

import 'package:auctionbd/const/app_colours.dart';
import 'package:auctionbd/ui/bottom_nav_controller.dart';
import 'package:auctionbd/widgets/custom_button.dart';
import 'package:auctionbd/widgets/myTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class Uploadpic extends StatefulWidget {
  @override
  _UploadpicState createState() => _UploadpicState();
}

class _UploadpicState extends State<Uploadpic> {
  String imageUrl = "https://www.linkpicture.com/q/download-1_55.png";

  TextEditingController _productname = TextEditingController();
  TextEditingController _productdesciption = TextEditingController();
  TextEditingController _productprice = TextEditingController();
  TextEditingController _producturl = TextEditingController();

  List<String> gender = ["Male", "Female", "Other"];

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null) setState(() {});
  }

  sendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("bid_data");
    return _collectionRef
        .doc()
        .set({
          "name": _productname.text,
          "dis": _productdesciption.text,
          "price": _productprice.text,
          "img-path": _producturl.text,
        })
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (_) => BottomNavController())))
        .catchError((error) => print("something is wrong. $error"));
  }

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions

    bool permissionStatus = true;

    if (permissionStatus) {
      //Select Image
      image = (await _imagePicker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('images/imageName')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
          _producturl.text = imageUrl;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "StartBidding.",
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: AppColours.deep_purple,
                  ),
                ),
                Text(
                  "Share your product",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFFBBBBBB),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                myTextField(
                    "enter product name", TextInputType.text, _productname),
                myTextField(
                    "enter product price", TextInputType.number, _productprice),

                myTextField("enter description", TextInputType.number,
                    _productdesciption),

                SizedBox(
                  height: 50.h,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(4.sp),
                          padding: EdgeInsets.all(5.sp),
                          height: 120.sp,
                          width: 120.sp,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            border: Border.all(color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(2, 2),
                                spreadRadius: 2,
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: (imageUrl != null)
                              ? Image.network(imageUrl)
                              : Image.network(
                                  'https://www.linkpicture.com/view.php?img=LPic618d6700d0be836161662')),
                    ],
                  ),
                ),
                customButton("Select Image", () => uploadImage()),
                SizedBox(
                  height: 5.sp,
                ),
                // elevated button
                customButton("Continue", () => sendUserDataToDB()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
