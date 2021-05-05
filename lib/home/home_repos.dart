import 'dart:convert';

import 'package:heroes/core/app_consts.dart';
import 'package:heroes/shared/models/hero_model.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../functions.dart';

class HomeRepos {
  //Future<HeroModel> getHero() async {
  //final response = await rootBundle.loadString("database/hero.json");
  //final user = HeroModel.fromJson(response);
  //return user;
  //}

  Future<List<HeroModel>> getHeroes() async {
    //final response = await rootBundle.loadString("database/quizzes.json");
    var ret = new DefFnReturn();

    List<HeroModel> heroes = [];

    Map<String, String> headers = {
      "Access-Control-Allow-Origin": "*",
      //"Content-type": "application/x-www-form-urlencoded",
      'Content-type': 'application/json',
      //"Accept': "application/json"
    };

    //Fields do POST...
    Map<String, dynamic> body = {"key": "WILSON"};

    try {
      //Faz o request dos heróis...
      http.Response response = await http.post(
        Uri.parse(AppConsts.urlAPIList),
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
            var list = resp['heroes'] as List;
            heroes = list.map((i) {
              return HeroModel(
                id: i['id']['S'],
                nome: i['nome']['S'],
                universo: i['universo']['S'],
                altura: i['altura']['S'],
                peso: i['peso']['S'],
                velocidade: i['velocidade']['S'],
              );
            }).toList();
          }
        }
      }
    } catch (e) {
      ret.success = false;
      ret.message = e.toString();
    }
    return heroes;
  }
}
