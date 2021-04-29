import 'package:heroes/core/app_gradients.dart';
import 'package:heroes/core/app_images.dart';
import 'package:heroes/core/app_text_styles.dart';
import 'package:heroes/shared/models/hero_model.dart';
import 'package:flutter/material.dart';
import 'package:heroes/core/app_consts.dart';

class AppBarWidget extends PreferredSize {
  AppBarWidget([String title = "HEROES - Seja bem vindo!"])
      : super(
          preferredSize: Size.fromHeight(80),
          child: Container(
            height: 50,
            child: Center(
                child: Text(
              title,
              style: AppTextStyles.titleBold,
            )),
          ),
        );
}
