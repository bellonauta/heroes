import 'package:heroes/core/app_gradients.dart';
import 'package:heroes/core/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  AppBarWidget({String title = "HEROES - Seja bem vindo!"})
      : super(
            preferredSize: Size.fromHeight(80),
            child: SafeArea(
              top: true,
              child: Container(
                height: 80,
                child: Stack(
                  children: [
                    Container(
                      height: 80,
                      width: double.maxFinite,
                      //padding: const EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(gradient: AppGradients.linear),
                      child: Center(
                        child: Text.rich(TextSpan(
                          text: title,
                          style: AppTextStyles.title,
                          children: [
                            //TextSpan(
                            //  text: title,
                            //  style: AppTextStyles.titleBold,
                            //)
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ));
}
