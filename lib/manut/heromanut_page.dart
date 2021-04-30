//import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:heroes/shared/widgets/appbar.dart';

class HeroManutPage extends StatefulWidget {
  final int id;
  final String nome;
  final double peso;
  final double velocidade;
  final double altura;
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
      : assert(action == "edit" || action == "delete" || action == "insert");

  @override
  _HeroManutPageState createState() => _HeroManutPageState();
}

class _HeroManutPageState extends State<HeroManutPage> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBarWidget(
            title: widget.action == 'edit'
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
                  // ignore: unnecessary_null_comparison
                  SizedBox(
                      child: Container(
                          child: _image == null
                              ? Text('No image selected.')
                              : Image.file(_image))),

                  SizedBox(
                    width: size.width - 48,
                    child: TextField(
                      maxLength: 60,
                      controller: TextEditingController()..text = widget.nome,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.person),
                          hintText: 'Informe o nome'),
                      readOnly: widget.action == 'delete',
                      onChanged: (text) => {},
                    ),
                  ),
                  //Peso...
                  SizedBox(
                    width: size.width - 48,
                    child: TextField(
                        maxLength: 9,
                        controller: TextEditingController()
                          ..text = widget.peso.toStringAsPrecision(9),
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.person),
                            hintText: 'Informe o peso do herói(em quilos)'),
                        readOnly: widget.action == 'delete',
                        onChanged: (text) => {}),
                  ),
                  //Altura...
                  SizedBox(
                    width: size.width - 48,
                    child: TextField(
                        maxLength: 9,
                        controller: TextEditingController()
                          ..text = widget.altura.toStringAsPrecision(9),
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.person),
                            hintText: 'Informe a altura do herói(em metros)'),
                        readOnly: widget.action == 'delete',
                        onChanged: (text) => {}),
                  ),
                  //Velocidade...
                  SizedBox(
                    width: size.width - 48,
                    child: TextField(
                        maxLength: 9,
                        controller: TextEditingController()
                          ..text = widget.peso.toStringAsPrecision(9),
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.person),
                            hintText:
                                'Informe a velocidade máxima herói(em km/hora)'),
                        readOnly: widget.action == 'delete',
                        onChanged: (text) => {}),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
