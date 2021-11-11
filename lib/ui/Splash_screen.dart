// ignore_for_file: file_names

import 'dart:async';

import 'package:auctionbd/const/app_colours.dart';
import 'package:auctionbd/ui/login_screen.dart';
import 'package:auctionbd/ui/bottom_nav_pages/upload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, CupertinoPageRoute(builder: (_) => LoginScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.deep_purple,
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: 60.sp,
              width: double.infinity,
            ),
            Center(
              child: Lottie.asset('lib/res/bidd.zip'),
              // child: Lottie.network(
              //     "https://assets2.lottiefiles.com/private_files/lf30_KUbmMp.json"),
            ),
            Center(
              child: Text(
                "AUCBD",
                style: TextStyle(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
