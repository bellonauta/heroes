import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:heroes/core/app_consts.dart';
import 'package:heroes/core/app_images.dart';
import 'package:heroes/shared/widgets/button.dart';
import 'package:http/http.dart' as http;

import 'package:heroes/functions.dart';

class ImageUploaderWidget extends StatefulWidget {
  final String action;
  final Uint8List image;
  final void Function(PlatformFile, bool) onChange;

  ImageUploaderWidget({Key key, this.image = null, this.action, this.onChange})
      : assert(action == "none" || action == "new" || action == "change"),
        super(key: key);

  @override
  ImageUploaderWidgetState createState() => ImageUploaderWidgetState();
}

class ImageUploaderWidgetState extends State<ImageUploaderWidget> {
  // ValueNotifier<Uint8List> _imgBytes = ValueNotifier<Uint8List>(null);
  PlatformFile objFile;

  bool showBtnImgUpdate = true;
  bool showBtnCancelImgUpdate = false;

  void chooseImgFile() async {
    //Mostra seleção de arquivo,
    var result = await FilePicker.platform.pickFiles(
      //withReadStream: true, // Abre o stream com o arquivo selecionado
      withData: true,
      allowMultiple: false,
      type: FileType.image,
      //allowedExtensions: ["jpg", "png",]
    );
    if (result != null) {
      objFile = result.files.single;
      this.showBtnImgUpdate = false;
      this.showBtnCancelImgUpdate = true;
      setState(() {});
      if (widget.onChange != null) {
        widget.onChange(objFile, true);
      }
    } else {
      objFile = null;
    }
  }

  DefFnReturn saveImgFile({String fileId}) {
    DefFnReturn ret = DefFnReturn();
    if (objFile != null) {
      //putB64ImgToRepo(fileId: fileId, b64: Base64Codec().encode(objFile.bytes))
      putB64ImgToRepo(fileId: fileId, b64: base64Encode(objFile.bytes))
          .then((res) {
        ret = res;
      });
    }
    //
    return ret;
  }

  void cancelPhotoChange() {
    objFile = null;
    this.showBtnImgUpdate = true;
    this.showBtnCancelImgUpdate = false;
    if (widget.onChange != null) {
      widget.onChange(null, false);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    //
    //Code here...
  }

  @override
  Widget build(BuildContext context) {
    /*
    if (widget.action == 'new' && objFile == null) {
      loadHeroImgFile(
          fileId: "",
          context: context,
          onLoad: (bytes) {
            _imgBytes = bytes as ValueNotifier<Uint8List>;
          });
    } else if (objFile != null) {
      _imgBytes = objFile.bytes as ValueNotifier<Uint8List>;
    } else {
      loadHeroImgFile(
          fileId: widget.fileId,
          context: context,
          onLoad: (bytes) {
            _imgBytes = bytes as ValueNotifier<Uint8List>;
          });
    }
    */

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
            /*
            ValueListenableBuilder(
              builder: (BuildContext context, Uint8List value, _) {
                // This builder will only get called when the _imgBytes
                // is updated.
                return value == null
                    ? new Image.asset(AppImages.person)
                    : new Image.memory(value,
                        width: 200,
                        height: 200,
                        cacheHeight: 200,
                        cacheWidth: 200,
                        fit: BoxFit.fitWidth,
                        filterQuality: FilterQuality.low);
              },
              valueListenable: _imgBytes,
            ), */

            Container(
              //padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              width: 160,
              height: 140,
              child: (widget.action == 'new' &&
                      objFile == null &&
                      widget.image == null)
                  ? Opacity(
                      opacity: 0.2,
                      child: Image.asset(
                        AppImages.person,
                      ),
                    )
                  : objFile != null
                      ? Container(
                          //width: MediaQuery.of(context).size.width,
                          //height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: Image.memory(
                                objFile.bytes,
                                //width: 160,
                                //height: 140,
                              ).image,
                            ),
                          ),
                        )

                      /*FittedBox(
                          child: Image.memory(
                            objFile.bytes,
                            width: 160,
                            height: 140,
                          ),
                          fit: BoxFit.fill,
                        )*/
                      : widget.image != null
                          ? Container(
                              //width: MediaQuery.of(context).size.width,
                              //height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: Image.memory(
                                    widget.image,
                                    //width: 160,
                                    //height: 140,
                                  ).image,
                                ),
                              ),
                            )
                          : Opacity(
                              opacity: 0.2,
                              child: Image.asset(
                                AppImages.person,
                              ),
                            ),
            ),
            if (this.showBtnImgUpdate && widget.action != 'none')
              ButtonWidget(
                  label: "Alterar",
                  width: 160,
                  height: 38,
                  fontSize: 15,
                  onTap: () {
                    chooseImgFile();
                  }),
            if (this.showBtnCancelImgUpdate && widget.action != 'none')
              ButtonWidget(
                  label: "Cancelar",
                  width: 160,
                  height: 38,
                  fontSize: 15,
                  onTap: () {
                    cancelPhotoChange();
                  }),
          ],
        ),
      ),
    );
  }
}
