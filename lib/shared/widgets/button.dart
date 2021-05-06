import 'package:heroes/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color fontColor;
  final Color borderColor;
  final double width;
  final double height;
  final double fontSize;
  final VoidCallback onTap;

  ButtonWidget(
      {String label,
      Color backgroundColor,
      Color fontColor,
      Color borderColor,
      VoidCallback onTap,
      double fontSize = 15,
      double width = 0.0,
      double height = 48})
      : this.backgroundColor =
            (backgroundColor != null ? backgroundColor : AppColors.darkGreen),
        this.fontColor = (fontColor != null ? fontColor : AppColors.white),
        this.borderColor =
            (borderColor != null ? borderColor : AppColors.green),
        this.onTap = onTap,
        this.label = (label != null ? label : 'Ok'),
        this.width = width,
        this.fontSize = fontSize,
        this.height = height;

  ButtonWidget.confirm(
      {String label = 'Confirmar',
      VoidCallback onTap,
      double width = 0.0,
      double height = 48})
      : this.backgroundColor = AppColors.darkGreen,
        this.fontColor = AppColors.white,
        this.borderColor = AppColors.green,
        this.onTap = onTap,
        this.label = label,
        this.fontSize = 15,
        this.width = width,
        this.height = height;

  ButtonWidget.cancel(
      {String label = 'Cancelar',
      VoidCallback onTap,
      double width = 0.0,
      double height = 48})
      : this.backgroundColor = AppColors.purple,
        this.fontColor = AppColors.white,
        this.borderColor = AppColors.green,
        this.onTap = onTap,
        this.label = label,
        this.fontSize = 15,
        this.width = width,
        this.height = height;

  ButtonWidget.back(
      {String label = 'Voltar',
      VoidCallback onTap,
      double width = 0.0,
      double height = 48})
      : this.backgroundColor = AppColors.darkGreen,
        this.fontColor = AppColors.white,
        this.borderColor = AppColors.green,
        this.onTap = onTap,
        this.label = label,
        this.fontSize = 15,
        this.width = width,
        this.height = height;

  ButtonWidget.insert(
      {String label = 'Incluir',
      VoidCallback onTap,
      double width = 0.0,
      double height = 48})
      : this.backgroundColor = AppColors.darkGreen,
        this.fontColor = AppColors.white,
        this.borderColor = AppColors.green,
        this.onTap = onTap,
        this.label = label,
        this.fontSize = 15,
        this.width = width,
        this.height = height;

  ButtonWidget.combat(
      {String label = 'Combate',
      VoidCallback onTap,
      double width = 0.0,
      double height = 48})
      : this.backgroundColor = AppColors.purple,
        this.fontColor = AppColors.white,
        this.borderColor = AppColors.green,
        this.onTap = onTap,
        this.label = label,
        this.fontSize = 15,
        this.width = width,
        this.height = height;

  @override
  Widget build(BuildContext context) {
    var ret = Container(
        width: ((this.width != null && this.width > 0) ? this.width : null),
        height: ((this.height != null && this.height > 0) ? this.height : null),
        child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(this.backgroundColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              side: MaterialStateProperty.all(
                  BorderSide(color: this.borderColor))),
          onPressed: this.onTap,
          child: Text(this.label,
              //textAlign: TextAlign.center,
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w600,
                fontSize: ((this.fontSize != null && this.fontSize > 0)
                    ? this.fontSize
                    : 15),
                color: this.fontColor,
              )),
        ));
    //
    return ret;
  }
}
