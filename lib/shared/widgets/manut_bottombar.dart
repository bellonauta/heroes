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
  bool isConfirmVisible = false;
  bool isCancelVisible = false;

  bool get isVisible => (this.isConfirmVisible || this.isCancelVisible);
 
  int stateCount = 0;

  void showBottomBar({bool confirm = true, bool cancel = true}) {
    if (!this.isVisible) {
      this.stateCount++;
      this.isConfirmVisible = confirm;
      this.isCancelVisible = cancel;
      setState(() {});
    }
  }

  void hideBottomBar() {
    if (this.isVisible) {
      this.stateCount++;
      this.isConfirmVisible = false;
      this.isCancelVisible = false;      
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
        bottom: true,
        child: Visibility(
            visible: (this.isVisible || (this.stateCount == 0 && widget.show)),
            child: Container(
              height: 80,
              width: min(400, size.width * 0.9),
              child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          this.isConfirmVisible ?
                          Container(
                              width: 150,
                              child: ButtonWidget.confirm(onTap: () {
                                if (widget.onConfirm != null) {
                                  //Validação dos campos...
                                  widget.onConfirm();
                                }
                              }))
                           : Container(width: 0.0, height: 0.0),  
                          (this.isConfirmVisible && this.isCancelVisible)
                            ? SizedBox(
                               width: 20,
                            )
                            : Container(width: 0.0, height: 0.0),  
                          this.isCancelVisible ?  
                          Container(
                              width: 150,
                              child: ButtonWidget.cancel(onTap: () {
                                hideBottomBar();
                                if (widget.onCancel != null) {
                                  widget.onCancel();
                                }
                              }))
                          : Container(width: 0.0, height: 0.0),     
                        ])),
              ),
            )));
  }
}
