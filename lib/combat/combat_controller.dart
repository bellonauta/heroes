import 'package:flutter/cupertino.dart';
import 'package:heroes/core/app_images.dart';
import 'package:heroes/combat/combat_repos.dart';
import 'package:heroes/shared/models/hero_model.dart';

import 'combat_state.dart';

class CombatController {
  final stateNotifier = ValueNotifier<CombatState>(CombatState.none);

  set state(CombatState state) => stateNotifier.value = state;
  CombatState get state => stateNotifier.value;

  //Controla Heróis
  List<HeroModel> heroes;

  final repository = CombatRepos();

  /// Instancia em [heroes] o objeto [HeroModel].
  void getHeroes() async {
    state = CombatState.loading;
    heroes = await repository.getHeroes(favoritos: false);
    state = CombatState.success;
  }

  /// Instancia em [heroes] o objeto [HeroModel] somente
  /// dos heróis marcados como favoritos.
  void getFavoriteHeroes() async {
    state = CombatState.loading;
    heroes = await repository.getHeroes(favoritos: true);
    state = CombatState.success;
  }
}
