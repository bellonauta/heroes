import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class HeroModel {
  final String id;
  final String nome;
  final Uint8List photo;
  final String universo;
  final String altura;
  final String peso;
  final String velocidade;
  String favorito;

  HeroModel(
      {this.id,
      this.nome,
      this.photo,
      this.universo,
      this.altura,
      this.peso,
      this.velocidade,
      this.favorito});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'universo': universo,
      'altura': altura,
      'peso': peso,
      'velocidade': velocidade,
      'photo': photo,
      'favorito': favorito,
    };
  }

  String toJson() => json.encode(toMap());
}
