//import 'package:devquiz/challenge/challenge_page.dart';
//import 'package:devquiz/challenge/widgets/quiz/quiz_widget.dart';
//import 'dart:html';

import 'package:heroes/core/app_colors.dart';
import 'package:heroes/core/app_gradients.dart';
import 'package:heroes/core/app_images.dart';
import 'package:heroes/home/home_controller.dart';
import 'package:heroes/manut/heromanut_page.dart';
import 'package:heroes/shared/widgets/appbar.dart';
import 'package:heroes/shared/widgets/button.dart';
import 'package:flutter/material.dart';

import 'home_state.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  // controller.createUser();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //controller.getHeroes();
    controller.getHeroes();
    // (IMPORTANTE)Tratar eventos de estado do controller...
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    //Pegar as métricas de tela do dispositivo...
    final size = MediaQuery.of(context).size;

    if (controller.state != HomeState.success) {
      // Carregando...
      return Scaffold(
          body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
        ),
      ));
    } else {
      return Scaffold(
          appBar: AppBarWidget(),
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /*LevelButtonWidget.easy(),
                  LevelButtonWidget.medium(),
                  LevelButtonWidget.hard(),
                  LevelButtonWidget.expert(),*/
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Expanded(
                    child: GridView.count(
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  crossAxisCount: 1,
                  children: controller.heroes!
                      .map((e) => Container(
                            child: Row(children: [
                              Image.asset(e.photoUrl),
                              Text(e.nome),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HeroManutPage(
                                              id: e.id,
                                              nome: e.nome,
                                              peso: e.peso,
                                              velocidade: e.velocidade,
                                              altura: e.altura,
                                              universo: e.universo,
                                              photoUrl: e.photoUrl,
                                              action: 'edit')));
                                },
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HeroManutPage(
                                                id: e.id,
                                                nome: e.nome,
                                                peso: e.peso,
                                                velocidade: e.velocidade,
                                                altura: e.altura,
                                                universo: e.universo,
                                                photoUrl: e.photoUrl,
                                                action: 'delete')));
                                  }),
                            ]),
                          ))
                      .toList(),
                ))
              ])));
    }
  }
}
