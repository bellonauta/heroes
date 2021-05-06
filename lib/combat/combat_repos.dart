import 'dart:convert';
import 'dart:io';

import 'package:heroes/core/app_consts.dart';
import 'package:heroes/core/app_images.dart';
import 'package:heroes/shared/models/hero_model.dart';
import 'package:http/http.dart' as http;

import '../functions.dart';

class CombatRepos {
  //Future<HeroModel> getHero() async {
  //final response = await rootBundle.loadString("database/hero.json");
  //final user = HeroModel.fromJson(response);
  //return user;
  //}

  Future<List<HeroModel>> getHeroes({bool favoritos = false}) async {
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
    Map<String, dynamic> body = {
      "key": "WILSON",
      "favoritos": favoritos ? "S" : "N"
    };

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
            //if (false) {
            var list = resp['heroes'] as List;

            if (AppConsts.localDataBase) {
              heroes = [
                HeroModel(
                    id: 'adlajldf',
                    nome: 'Batman',
                    photo:
                        null, //await new File(AppImages.photo).readAsBytes(),
                    universo: 'Marvel',
                    altura: '1.90',
                    peso: '80',
                    velocidade: '21',
                    favorito: 'S'),
                HeroModel(
                    id: 'adlajldfdfadfas',
                    nome: 'Robin',
                    photo: null, // new File(AppImages.trophy).readAsBytes(),
                    universo: 'Marvel',
                    altura: '1.87',
                    peso: '75',
                    velocidade: '20',
                    favorito: 'N')
              ];
            } else {
              heroes = list.map((i) {
                if (!favoritos) {
                  return HeroModel(
                      id: i['id']['S'],
                      nome: i['nome']['S'],
                      photo: base64Decode(i['photo']['S']),
                      universo: i['universo']['S'],
                      altura: i['altura']['S'],
                      peso: i['peso']['S'],
                      velocidade: i['velocidade']['S'],
                      favorito: i['favorito']['S']);
                } else {
                  return HeroModel(
                      id: i['id'],
                      nome: i['nome'],
                      photo: base64Decode(i['photo']),
                      universo: i['universo'],
                      altura: i['altura'],
                      peso: i['peso'],
                      velocidade: i['velocidade'],
                      favorito: i['favorito']);
                }
              }).toList();
            }
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
