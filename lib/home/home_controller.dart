import 'package:flutter/cupertino.dart';
import 'package:heroes/core/app_images.dart';
import 'package:heroes/home/home_repos.dart';
import 'package:heroes/shared/models/hero_model.dart';

import 'home_state.dart';

class HomeController {
  final stateNotifier = ValueNotifier<HomeState>(HomeState.none);

  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  //Controla Heróis
  List<HeroModel>? heroes;

  final repository = HomeRepos();

  /// Instancia em [heroes] o objeto [HeroModel].
  void getHeroes() async {
    state = HomeState.loading;
    heroes = await repository.getHeroes();
    state = HomeState.success;
  }  
}
