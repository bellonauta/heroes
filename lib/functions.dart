import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:heroes/core/app_consts.dart';
import 'package:heroes/core/app_images.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class DefFnReturn {
  bool success = true;
  String message = "";
  String data = "";

  bool get getSuccess => this.success;
  set setSuccess(bool success) => this.success = success;

  String get getMessage => this.message;
  set setMessage(String message) => this.message = message;
}

void msgBox({String title, String message, BuildContext boxContext}) {
  showDialog(
      context: boxContext,
      builder: (BuildContext boxContext) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Entendi'),
              onPressed: () {
                Navigator.of(boxContext).pop();
              },
            ),
          ],
        );
      });
}

Future<DefFnReturn> createFolder({String folder}) async {
  DefFnReturn ret = new DefFnReturn();

  //Diretório de documentos da App...
  final Directory _appDocDir = await getApplicationDocumentsDirectory();
  //Une...
  final Directory _appDocDirFolder =
      Directory('${_appDocDir.path}/${AppConsts.photosFolder}');
  //
  if (!(await _appDocDirFolder.exists())) {
    //Não existe - Cria o folder...
    try {
      await _appDocDirFolder.create(recursive: true);
    } catch (e) {
      ret.success = false;
      ret.message = e.toString();
    }
  }
  //
  return ret;
}

///  Coloca uma imagem no repositório(AWS S3), com
///  seu conteúdo codificado em base64.
///  String fileId - ID do arquivo de imagem
///  String b64 - base64Encode da imagem (Ex: base64Encode(objFile.bytes))
Future<DefFnReturn> putB64ImgToRepo({String fileId, String b64}) async {
  //Cria o pacote http multipart request object...
  DefFnReturn ret = new DefFnReturn();

  Map<String, String> headers = {
    "Access-Control-Allow-Origin": "*",
    //"Content-type": "application/x-www-form-urlencoded",
    'Content-type': 'application/json',
    //"Accept': "application/json"
  };

  //Fields do POST...
  Map<String, dynamic> body = {"action": "save", "fileId": fileId, "b64": b64};

  try {
    //Faz o request(POST)...
    http.Response response = await http.post(
      Uri.parse(AppConsts.urlAPIPhoto),
      headers: headers,
      body: json.encode(body),
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode != 200) {
      ret.success = false;
      ret.message = 'HTTP Fault ' + response.statusCode.toString();
    } else {
      //Decodifica o retorno...
      if (response.body == null || response.body == '') {
        ret.success = false;
        ret.message = 'Retorno do request é inválido.';
      } else {
        var resp = jsonDecode(response.body);
        if (!resp['success']) {
          ret.success = false;
          ret.message = resp['message'];
        }
      }
    }
  } catch (e) {
    ret.success = false;
    ret.message = e.toString();
  }

  /*
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
    */

  return ret;
}

///  Lê uma imagem do repositório(AWS S3) e  retorna
///  o código base64 da mesma, na propriedade [DefFnReturn.data] do
///  retorno da função.
///  String fileId - ID do arquivo de imagem
Future<DefFnReturn> getB64ImgFromRepo({String fileId}) async {
  //Cria o pacote http multipart request object...
  DefFnReturn ret = new DefFnReturn();

  //var base64Str = base64Encode(objFile.bytes);

  Map<String, String> headers = {
    "Access-Control-Allow-Origin": "*",
    //"Content-type": "application/x-www-form-urlencoded",
    'Content-type': 'application/json',
    //"Accept': "application/json"
  };

  //Fields do POST...
  Map<String, dynamic> body = {"action": "read", "fileId": fileId};

  try {
    //Faz o request(POST)...
    http.Response response = await http.post(
      Uri.parse(AppConsts.urlAPIPhoto),
      headers: headers,
      body: json.encode(body),
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode != 200) {
      ret.success = false;
      ret.message = 'HTTP Fault ' + response.statusCode.toString();
    } else {
      //Decodifica o retorno...
      if (response.body == null || response.body == '') {
        ret.success = false;
        ret.message = 'Retorno do request é inválido.';
      } else {
        var resp = jsonDecode(response.body);
        if (!resp['success']) {
          ret.success = false;
          ret.message = resp['message'];
        } else {
          ret.data = resp['b64'];
        }
      }
    }
  } catch (e) {
    ret.success = false;
    ret.message = e.toString();
  }
  //
  return ret;
}

/// Busca a imagem do herói e retorna um [Uint8List] da mesma.
Future<Image> loadHeroImgFile(
    {String fileId, BuildContext context, Function(Uint8List) onLoad}) async {
  Image ret = null;
  //
  if (fileId == '') {
    ret = Image.asset(AppImages.person);
    if (onLoad != null) {
      onLoad(null);
    }
    msgBox(title: "Ooops...", message: 'ID vazio!!??', boxContext: context);
  } else {
    var res = await getB64ImgFromRepo(fileId: fileId);
    if (!res.success) {
      ret = Image.asset(AppImages.person);
      msgBox(title: "Ooops...", message: res.message, boxContext: context);
    } else if (res.data == '') {
      ret = Image.asset(AppImages.person);
      msgBox(
          title: "Ooops...",
          message: 'Imagem não encontrada.',
          boxContext: context);
    }
    if (ret == null && onLoad != null) {
      onLoad(null);
    } else {
      //Uint8List bytes = BASE64.decode(b64.data);
      //Uint8List bytes = Base64Codec().decode(res.data);
      Uint8List bytes = base64Decode(res.data);
      if (onLoad != null) {
        onLoad(bytes);
      }
      //Uint8List bytes = Base64Decoder().convert(
      //    'TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb2');
      //var bytes = base64.decode(
      //    'TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb2');
      ret = Image.memory(bytes,
          width: 200,
          height: 200,
          cacheHeight: 200,
          cacheWidth: 200,
          fit: BoxFit.fitWidth,
          filterQuality: FilterQuality.low);
      msgBox(title: "Ok", message: "Imagem recuperada.", boxContext: context);
    }
  }
  //
  return ret;
}

void postManut(
    {BuildContext context,
    Map<String, dynamic> body,
    Function(bool, String, String) onAfterPost}) async {
  //Cria o pacote http multipart request object...
  DefFnReturn ret = new DefFnReturn();

  Map<String, String> headers = {
    "Access-Control-Allow-Origin": "*",
    //"Content-type": "application/x-www-form-urlencoded",
    'Content-type': 'application/json',
    //"Accept': "application/json"
  };

  try {
    //Faz o request(POST)...
    http.Response response = await http.post(
      Uri.parse(AppConsts.urlAPIManut),
      headers: headers,
      body: json.encode(body),
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode != 200) {
      ret.success = false;
      ret.message = 'HTTP Fault ' + response.statusCode.toString();
    } else {
      //Decodifica o retorno...
      if (response.body == null || response.body == '') {
        ret.success = false;
        ret.message = 'Retorno do request é inválido.';
      } else {
        var resp = jsonDecode(response.body);
        if (!resp['success']) {
          ret.success = false;
          ret.message = resp['message'];
        } else {
          ret.data = resp['id'];
        }
      }
    }
  } catch (e) {
    ret.success = false;
    ret.message = e.toString();
  }
  //
  if (onAfterPost != null) {
    onAfterPost(ret.success, ret.message, ret.data);
  }
}
