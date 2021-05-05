import 'dart:convert';

class HeroModel {
  final String id;
  final String nome;
  final String photoUrl;
  final String universo;
  final String altura;
  final String peso;
  final String velocidade;

  HeroModel(
      {this.id,
      this.nome,
      this.universo,
      this.altura,
      this.peso,
      this.velocidade,
      this.photoUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'photoUrl': photoUrl,
      'universo': universo,
      'altura': altura,
      'peso': peso,
      'velocidade': velocidade,
    };
  }

  factory HeroModel.fromMap(Map<String, dynamic> map) {
    return HeroModel(
      id: map['id']['S'],
      nome: map['nome']['S'],
      photoUrl: map['photoUrl']['S'],
      universo: map['universo']['S'],
      altura: map['altura']['S'],
      peso: map['peso']['S'],
      velocidade: map['velocidade']['S'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HeroModel.fromJson(String source) =>
      HeroModel.fromMap(json.decode(source));
}
