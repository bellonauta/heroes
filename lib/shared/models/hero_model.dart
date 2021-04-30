import 'dart:convert';

class HeroModel {
  final int id;
  final String nome;
  final String photoUrl;
  final String universo;
  final double altura;
  final double peso;
  final double velocidade;

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
      id: map['id'],
      nome: map['nome'],
      photoUrl: map['photoUrl'],
      universo: map['universo'],
      altura: map['altura'],
      peso: map['peso'],
      velocidade: map['velocidade'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HeroModel.fromJson(String source) =>
      HeroModel.fromMap(json.decode(source));
}
