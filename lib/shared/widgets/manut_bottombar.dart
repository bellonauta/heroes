import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heroes/functions.dart';
import 'package:heroes/shared/widgets/button.dart';

class ManutBottomBarWidget extends StatefulWidget {
  final bool show;
  final void Function() onConfirm;
  final void Function() onCancel;

  const ManutBottomBarWidget(
      {Key key, this.show, this.onConfirm, this.onCancel})
      : super(key: key);

  @override
  ManutBottomBarWidgetState createState() => ManutBottomBarWidgetState();
}

class ManutBottomBarWidgetState extends State<ManutBottomBarWidget> {
  bool isVisible = false;
  int stateCount = 0;

  void showBottomBar() async {
    if (!isVisible) {
      stateCount++;
      isVisible = true;
      setState(() {});
    }
  }

  void hideBottomBar() async {
    if (isVisible) {
      stateCount++;
      isVisible = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    this.isVisible = (this.isVisible || (stateCount == 0 && widget.show));

    return SafeArea(
        bottom: true,
        child: Visibility(
            visible: this.isVisible,
            child: Container(
              height: 80,
              width: min(400, size.width * 0.9),
              child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 150,
                              child: ButtonWidget.confirm(onTap: () {
                                if (widget.onConfirm != null) {
                                  //Validação dos campos...
                                  widget.onConfirm();
                                }
                              })),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              width: 150,
                              child: ButtonWidget.cancel(onTap: () {
                                hideBottomBar();
                                if (widget.onCancel != null) {
                                  widget.onCancel();
                                }
                              })),
                        ])),
              ),
            )));
  }
}
