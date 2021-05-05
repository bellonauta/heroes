import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heroes/core/app_consts.dart';
import 'package:heroes/core/app_images.dart';
import 'package:heroes/home/home_page.dart';
import 'package:heroes/shared/widgets/button.dart';
import 'package:heroes/shared/widgets/image_uploader.dart';
import 'package:heroes/shared/widgets/manut_bottombar.dart';
import 'package:heroes/shared/widgets/appbar.dart';
import 'package:http/http.dart' as http;

import '../functions.dart';

class HeroManutPage extends StatefulWidget {
  final String id;
  final String nome;
  final String peso;
  final String velocidade;
  final String altura;
  final String universo;
  final String photoUrl;
  final String action;

  HeroManutPage(
      {this.id,
      this.nome,
      this.peso,
      this.velocidade,
      this.altura,
      this.universo,
      this.photoUrl,
      this.action})
      : assert(action == "update" || action == "delete" || action == "insert");

  @override
  _HeroManutPageState createState() => _HeroManutPageState();
}

class _HeroManutPageState extends State<HeroManutPage> {
  final fldNomeController = TextEditingController();
  final fldAlturaController = TextEditingController();
  final fldPesoController = TextEditingController();
  final fldVelocidadeController = TextEditingController();
  final fldUniversoController = TextEditingController();

  final fldNomeFocus = FocusNode();
  final fldAlturaFocus = FocusNode();
  final fldPesoFocus = FocusNode();
  final fldVelocidadeFocus = FocusNode();
  final fldUniversoFocus = FocusNode();

  bool hasUpdates = false;
  bool get getHasUpdates => this.hasUpdates;
  set setHasUpdates(bool hasUpdates) => {
        if (this.hasUpdates != hasUpdates)
          {
            this.hasUpdates = hasUpdates,
          }
      };

  void postManut(
      {BuildContext context,
      String action,
      String heroId,
      Function(bool, String) onAfterPost}) async {
    //Cria o pacote http multipart request object...
    var ret = new DefFnReturn();

    Map<String, String> headers = {
      "Access-Control-Allow-Origin": "*",
      //"Content-type": "application/x-www-form-urlencoded",
      'Content-type': 'application/json',
      //"Accept': "application/json"
    };

    //Fields do POST...
    Map<String, dynamic> body = {
      "action": action,
      "id": action == 'insert' ? "" : heroId,
      "nome": fldNomeController.text,
      "altura": fldAlturaController.text,
      "peso": fldPesoController.text,
      "velocidade": fldVelocidadeController.text,
      "universo": fldUniversoController.text,
    };

    //nt statusCode = response.statusCode;
    //String responseBody = response.body;

    /*
    var request =
        new http.MultipartRequest("POST", Uri.parse(AppConsts.urlAPIManut));

    request.fields["action"] = action;
    request.fields["id"] = fldNomeController.text;
    request.fields["nome"] = fldNomeController.text;
    request.fields["universo"] = fldUniversoController.text;
    request.fields["altura"] = fldAlturaController.text;
    request.fields["peso"] = fldPesoController.text;
    request.fields["velocidade"] = fldVelocidadeController.text;

    request.headers.addAll(headers);
    */

    try {
      //Faz o request(POST)...

      //http.Response response =
      //    await http.Response.fromStream(await request.send());

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
          }
        }
      }
    } catch (e) {
      ret.success = false;
      ret.message = e.toString();
    }

    //
    if (onAfterPost != null) {
      onAfterPost(ret.success, ret.message);
    }
  }

  @override
  void initState() {
    super.initState();
    //
    //Code here...
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    fldNomeController.dispose();
    fldAlturaController.dispose();
    fldPesoController.dispose();
    fldVelocidadeController.dispose();
    fldUniversoController.dispose();
    //
    fldNomeFocus.dispose();
    fldAlturaFocus.dispose();
    fldPesoFocus.dispose();
    fldVelocidadeFocus.dispose();
    fldUniversoFocus.dispose();
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    this.hasUpdates = (widget.action == 'delete');

    //Para acessar recursos públicos de uma classe:
    GlobalKey<ManutBottomBarWidgetState> _bottomBarKey = GlobalKey();

    return Scaffold(
      appBar: AppBarWidget(
          title: widget.action == 'update'
              ? "Alterar dados do herói"
              : widget.action == 'delete'
                  ? "Excluir herói"
                  : "Incluir herói"),
      body: Center(
        child: Container(
          width: min(400, size.width * 0.9),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            child: Column(
              children: [
                SizedBox(
                  width: size.width - 48,
                  child: ImageUploaderWidget(
                    //Handler do evento de troca de foto...
                    onChange: (String fileName) {
                      this.setHasUpdates = true;
                      _bottomBarKey.currentState.showBottomBar();
                      msgBox(
                          title: 'Foto alterada!',
                          message: fileName,
                          boxContext: context);
                    },
                    imgUrl: AppImages.photo,
                    action: 'change',
                  ),
                ),
                SizedBox(
                  width: size.width - 48,
                  child: TextField(
                    maxLength: 60,
                    controller: fldNomeController..text = widget.nome,
                    focusNode: fldNomeFocus,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Image.asset(
                          AppImages.person,
                          width: 32,
                          height: 32,
                        ),
                        hintText: 'Informe o nome'),
                    readOnly: widget.action == 'delete',
                    onChanged: (text) => {
                      this.setHasUpdates = true,
                      _bottomBarKey.currentState.showBottomBar(),
                      //msgBox(
                      //    title: "Nome...",
                      //    message: fldNomeController.text,
                      //    boxContext: context)
                    },
                  ),
                ),
                SizedBox(
                  width: size.width - 48,
                  child: TextField(
                    maxLength: 20,
                    controller: fldUniversoController..text = widget.universo,
                    focusNode: fldUniversoFocus,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Image.asset(
                          AppImages.person,
                          width: 32,
                          height: 32,
                        ),
                        hintText: 'Informe o universo do herói'),
                    readOnly: widget.action == 'delete',
                    onChanged: (text) => {
                      this.setHasUpdates = true,
                      _bottomBarKey.currentState.showBottomBar(),
                    },
                  ),
                ),
                //Peso...
                SizedBox(
                  width: size.width - 48,
                  child: TextField(
                      maxLength: 9,
                      controller: fldPesoController
                        ..text = widget.peso, //.toStringAsPrecision(9),
                      focusNode: fldPesoFocus,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Image.asset(
                            AppImages.weight,
                            width: 32,
                            height: 32,
                          ),
                          hintText: 'Informe o peso do herói(em quilos)'),
                      readOnly: widget.action == 'delete',
                      onChanged: (text) => {
                            this.setHasUpdates = true,
                            _bottomBarKey.currentState.showBottomBar()
                          }),
                ),
                //Altura...
                SizedBox(
                  width: size.width - 48,
                  child: TextField(
                      maxLength: 9,
                      controller: fldAlturaController
                        ..text = widget.altura, //.toStringAsPrecision(9),
                      focusNode: fldAlturaFocus,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Image.asset(
                            AppImages.height,
                            width: 32,
                            height: 32,
                          ),
                          hintText: 'Informe a altura do herói(em metros)'),
                      readOnly: widget.action == 'delete',
                      onChanged: (text) => {
                            this.setHasUpdates = true,
                            _bottomBarKey.currentState.showBottomBar()
                          }),
                ),
                //Velocidade...
                SizedBox(
                  width: size.width - 48,
                  child: TextField(
                      maxLength: 9,
                      controller: fldVelocidadeController
                        ..text = widget.peso, //.toStringAsPrecision(9),
                      focusNode: fldVelocidadeFocus,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Image.asset(
                            AppImages.speed,
                            width: 32,
                            height: 32,
                          ),
                          hintText:
                              'Informe a velocidade máxima do herói(em km/hora)'),
                      readOnly: widget.action == 'delete',
                      onChanged: (text) => {
                            this.setHasUpdates = true,
                            _bottomBarKey.currentState.showBottomBar()
                          }),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ManutBottomBarWidget(
          key: _bottomBarKey,
          show: this.hasUpdates,
          onConfirm: () {
            //Salva alterações...
            //Validação
            var doubleVeloc = ((fldVelocidadeController.text == null ||
                    fldVelocidadeController.text == "")
                ? 0
                : double.tryParse(fldVelocidadeController.text));
            var doublePeso = ((fldPesoController.text == null ||
                    fldPesoController.text == "")
                ? 0
                : double.tryParse(fldPesoController.text));
            var doubleAltura = ((fldAlturaController.text == null ||
                    fldAlturaController.text == "")
                ? 0
                : double.tryParse(fldAlturaController.text));
            if (fldNomeController.text == "") {
              fldNomeFocus.requestFocus();
              msgBox(
                  title: "Nome...",
                  message: "Informe o nome do herói.",
                  boxContext: context);
            } else if (doubleVeloc == null || doubleVeloc < 5) {
              fldVelocidadeFocus.requestFocus();
              msgBox(
                  title: "Velocidade...",
                  message:
                      "Informe uma velocidade maior ou igual a 5 Km/hora.\n" +
                          "Para as decimais, use o '.'(ponto).",
                  boxContext: context);
            } else if (doublePeso == null || doublePeso <= 0) {
              fldPesoFocus.requestFocus();
              msgBox(
                  title: "Peso...",
                  message: "Informe o peso do herói em quilos.\n" +
                      "Para as decimais, use o '.'(ponto).",
                  boxContext: context);
            } else if (doubleAltura == null || doubleAltura <= 0) {
              fldAlturaFocus.requestFocus();
              msgBox(
                  title: "Peso...",
                  message: "Informe a altura do herói em metros.\n" +
                      "Para as decimais, use o '.'(ponto).",
                  boxContext: context);
            } else {
              postManut(
                  context: context,
                  action: widget.action,
                  heroId: widget.id,
                  onAfterPost: (success, message) {
                    if (!success) {
                      fldAlturaFocus.requestFocus();
                      msgBox(
                          title: "Ooops...",
                          message:
                              "Ocorreu uma falha na manutenção.\n\n" + message,
                          boxContext: context);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                  });
            }
          },
          onCancel: () {
            //Desfaz alterações...
            fldNomeController.text = widget.nome;
            fldPesoController.text = widget.peso; //.toStringAsPrecision(9);
            fldAlturaController.text = widget.altura; //.toStringAsPrecision(9);
            fldUniversoController.text = widget.universo;
            fldVelocidadeController.text =
                widget.velocidade; //.toStringAsPrecision(9);
          }),
    );
  }
}
