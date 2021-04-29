import 'dart:math';

import 'package:heroes/core/app_gradients.dart';
import 'package:heroes/core/app_images.dart';
// import 'package:heroes/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:heroes/home/home_page.dart';

class SplashPage extends StatelessWidget {
  SplashPage();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // pushReplacement = Sobrepoe a tela atual(Splash) com outra(Home)
    Future.delayed(Duration(seconds: 2)).then((_) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        ));
    return Scaffold(
      //appBar: AppBar(title: Text(size.toString())),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.linear,
        ),
        child: Center(
          child: Image.asset(
            AppImages.logo,
            fit: BoxFit.fitWidth,
            width: min(500, size.width * 0.9),
            height: min(670, size.height * 0.9),
            scale: 0.8,
          ),
        ),
      ),
    );
  }
}
