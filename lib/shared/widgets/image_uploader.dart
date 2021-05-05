import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:heroes/core/app_consts.dart';
import 'package:heroes/core/app_images.dart';
import 'package:heroes/shared/widgets/button.dart';
import 'package:http/http.dart' as http;

import '../../functions.dart';

class ImageUploaderWidget extends StatefulWidget {
  final String fileId;
  final String action;
  final void Function(String) onChange;

  bool showBtnImgUpdate;
  bool showBtnCancelImgUpdate;

  ImageUploaderWidget({this.fileId = "", this.action, this.onChange})
      : assert(action == "none" || action == "new" || action == "change") {
    showBtnImgUpdate = this.action != 'none';
    showBtnCancelImgUpdate = false;
  }

  @override
  _ImageUploaderWidgetState createState() => _ImageUploaderWidgetState();
}

class _ImageUploaderWidgetState extends State<ImageUploaderWidget> {
  PlatformFile objFile;

  void chooseImgFile() async {
    //Mostra seleção de arquivo,
    var result = await FilePicker.platform.pickFiles(
      withReadStream: true, // Abre o stream com o arquivo selecionado
    );
    if (result != null) {
      objFile = result.files.single;
      widget.showBtnImgUpdate = false;
      widget.showBtnCancelImgUpdate = true;
      setState(() {});
      if (widget.onChange != null) {
        widget.onChange(objFile.name);
      }
    } else {
      objFile = null;
    }
  }

  DefFnReturn saveImgFile({String fileId}) {
    DefFnReturn ret = DefFnReturn();
    if (objFile != null) {
      ret = putB64ImgToRepo(fileId: fileId, b64: base64Encode(objFile.bytes))
          as DefFnReturn;
    }
    //
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    Image loadImgFile({String fileId}) {
      Image ret = new Image.asset(AppImages.person);
      if (fileId != '') {
        DefFnReturn b64 =
            getB64ImgFromRepo(fileId: widget.fileId) as DefFnReturn;
        if (!b64.success) {
          msgBox(title: "Ooops...", message: b64.message, boxContext: context);
        } else {
          //Uint8List bytes = BASE64.decode(b64.data);
          Uint8List bytes = Base64Codec().decode(b64.data);
          ret = new Image.memory(bytes);
        }
      }
      //
      return ret;
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 2, // to apply margin in the main axis of the wrap
          runSpacing: 2, // to apply margin in the cross axis of the wrap
          children: [
            Container(
              //padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              width: 160,
              height: 140,
              //Image.asset(AppImagese.photoUrl),
              child: (widget.action == 'insert' || objFile == null)
                  ? loadImgFile(fileId: "")
                  : loadImgFile(fileId: widget.fileId),
              //width: 160,
              //height: 140,
            ),
            if (widget.showBtnImgUpdate)
              ButtonWidget(
                  label: "Alterar",
                  width: 160,
                  height: 38,
                  fontSize: 15,
                  onTap: () {
                    chooseImgFile();
                  }),
            if (widget.showBtnCancelImgUpdate)
              ButtonWidget(
                  label: "Cancelar",
                  width: 160,
                  height: 38,
                  fontSize: 15,
                  onTap: () {
                    setState(() {});
                    if (widget.action == 'insert') {
                      //Recarrega "smith photo"...
                      loadImgFile(fileId: "");
                    } else {
                      //Recarrega photo oficial...
                      loadImgFile(fileId: widget.fileId);
                    }
                  }),
          ],
        ),
      ),
    );
  }
}
