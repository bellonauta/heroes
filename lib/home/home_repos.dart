import 'dart:convert';

import 'package:heroes/shared/models/hero_model.dart';
import 'package:flutter/services.dart';

class HomeRepos {
  //Future<HeroModel> getHero() async {
  //final response = await rootBundle.loadString("database/hero.json");
  //final user = HeroModel.fromJson(response);
  //return user;
  //}

  Future<List<HeroModel>> getHeroes() async {
    //final response = await rootBundle.loadString("database/quizzes.json");
    final List response = [
      {
        "id": 1,
        "nome": 'Jaum',
        'photoUrl': "",
        'universo': 'MARVEL',
        'altura': 1.70,
        'peso': 95.300,
        'velocidade': 200.000
      },
      {
        "id": 2,
        "nome": 'Pedro',
        'photoUrl': "",
        'universo': 'MARVEL',
        'altura': 1.70,
        'peso': 95.300,
        'velocidade': 200.000
      },
    ];
    //final list = jsonDecode(response) as List;
    final heroes = response.map((e) => HeroModel.fromMap(e)).toList();
    //final List<HeroModel> heroes = [];
    return heroes;
  }
}
