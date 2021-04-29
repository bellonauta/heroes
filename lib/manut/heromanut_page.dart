import 'package:flutter/material.dart';
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
      {required this.id,
      required this.nome,
      required this.peso,
      required this.velocidade,
      required this.altura,
      required this.universo,
      required this.photoUrl,
      required this.action})
      : assert(action == "edit" || action == "delete");

  @override
  _HeroManutPageState createState() => _HeroManutPageState();
}

class _HeroManutPageState extends State<HeroManutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(widget.action == 'edit'
            ? "Alterar dados do herói"
            : "Excluir herói"),
        body: Column(
          children: [
            TextField(
              maxLength: 60,
              controller: TextEditingController()..text = widget.nome,
              readOnly: widget.action == 'delete',
              onChanged: (text) => {},
            ),
            //Peso...
            TextField(
                maxLength: 9,
                controller: TextEditingController()
                  ..text = widget.peso.toStringAsPrecision(9),
                keyboardType: TextInputType.numberWithOptions(
                    signed: false, decimal: true),
                readOnly: widget.action == 'delete',
                onChanged: (text) => {}),
          ],
        ));
  }
}
