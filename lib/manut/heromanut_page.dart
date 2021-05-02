import 'dart:math';
import 'package:flutter/material.dart';
import 'package:heroes/core/app_images.dart';
import 'package:heroes/shared/widgets/image_uploader.dart';
import 'package:heroes/shared/widgets/appbar.dart';

import '../functions.dart';

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
                  SizedBox(
                    width: size.width - 48,
                    child: ImageUploaderWidget(
                        //Handler do evento de troca de foto...
                        onChange: (String fileName) {
                          msgBox(
                              title: 'Foto alterada!',
                              message: fileName,
                              boxContext: context);
                        },
                        imgUrl: AppImages.photo,
                        action: 'change',
                        uploadUrl: "http://localhost/upl.php"),
                  ),
                  SizedBox(
                    width: size.width - 48,
                    child: TextField(
                      maxLength: 60,
                      controller: TextEditingController()..text = widget.nome,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Image.asset(
                            AppImages.person,
                            width: 32,
                            height: 32,
                          ),
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
                            icon: Image.asset(
                              AppImages.weight,
                              width: 32,
                              height: 32,
                            ),
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
                            icon: Image.asset(
                              AppImages.height,
                              width: 32,
                              height: 32,
                            ),
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
                            icon: Image.asset(
                              AppImages.speed,
                              width: 32,
                              height: 32,
                            ),
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
