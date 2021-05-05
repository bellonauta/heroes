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

  HeroModel(
      {this.id,
      this.nome,
      this.photo,
      this.universo,
      this.altura,
      this.peso,
      this.velocidade});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'universo': universo,
      'altura': altura,
      'peso': peso,
      'velocidade': velocidade,
      'photo': photo
    };
  }

  factory HeroModel.fromMap(Map<String, dynamic> map) {
    return HeroModel(
      id: map['id']['S'],
      nome: map['nome']['S'],
      universo: map['universo']['S'],
      altura: map['altura']['S'],
      peso: map['peso']['S'],
      velocidade: map['velocidade']['S'],
      photo: base64Decode(map['photo']['S'])
    );
  }

  String toJson() => json.encode(toMap());

  factory HeroModel.fromJson(String source) =>
      HeroModel.fromMap(json.decode(source));
}
