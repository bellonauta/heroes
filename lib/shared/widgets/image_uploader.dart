import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:heroes/core/app_consts.dart';
import 'package:heroes/core/app_images.dart';
import 'package:heroes/shared/widgets/button.dart';
import 'package:http/http.dart' as http;

import '../../functions.dart';

class ImageUploaderWidget extends StatefulWidget {
  final String imgUrl;
  final String action;
  final void Function(String) onChange;

  bool showBtnImgUpdate;
  bool showBtnCancelImgUpdate;

  ImageUploaderWidget({this.imgUrl = "", this.action, this.onChange})
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

  void uploadImgFile(BuildContext context) async {
    //Cria o pacote http multipart request object...
    var ret = new DefFnReturn();

    final request = http.MultipartRequest(
      "POST",
      Uri.parse(AppConsts.urlAPIManut),
    );
    //Parâmetros...
    request.fields["id"] = "herophoto";

    try {
      //Adiciona o arquivo selecionado no request...
      request.files.add(new http.MultipartFile(
          "herophoto", objFile.readStream, objFile.size,
          filename: objFile.name));
      //Faz o request(POST)...
      var response = await request.send();
      if (response.statusCode != 200) {
        ret.success = false;
        ret.message = response.stream.bytesToString() as String;
      }
    } catch (e) {
      ret.success = false;
      ret.message =
          'Falha ao enviar o arquivo. Tente novamente.\n\n' + e.toString();
    }
    if (!ret.success) {
      msgBox(boxContext: context, title: "Ooops...", message: ret.message);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              child: Image.asset(
                (widget.action == 'insert' && objFile == null)
                    ? Icons.image_search
                    : widget.imgUrl,
                width: 160,
                height: 140,
              ),
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
            //MaterialButton(
            //    child: Text("Alterar"), onPressed: () => chooseImgFile()),
            if (widget.showBtnCancelImgUpdate)
              ButtonWidget(
                  label: "Cancelar",
                  width: 160,
                  height: 38,
                  fontSize: 15,
                  onTap: () {
                    uploadImgFile(context);
                  }),
            //MaterialButton(
            //    child: Text("Cancelar"),
            //    onPressed: () {
            //      uploadImgFile(context);
            //}),
            //------Show file name when file is selected
            //if (objFile != null)
            //  Text("File name : ${objFile.name}"),
            //------Show file size when file is selected
            //if (objFile != null)
            //  Text("File size : ${objFile.size} bytes"),
            //------Show upload utton when file is selected
            //MaterialButton(
            //    child: Text("Upload"),
            //    onPressed: () => uploadSelectedFile()),
          ],
        ),
      ),
    );
  }
}
