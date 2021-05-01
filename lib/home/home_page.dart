//import 'package:devquiz/challenge/challenge_page.dart';
//import 'package:devquiz/challenge/widgets/quiz/quiz_widget.dart';
//import 'dart:html';

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:heroes/core/app_colors.dart';
import 'package:heroes/core/app_gradients.dart';
import 'package:heroes/core/app_images.dart';
import 'package:heroes/core/app_text_styles.dart';
import 'package:heroes/home/home_controller.dart';
import 'package:heroes/manut/heromanut_page.dart';
import 'package:heroes/shared/widgets/appbar.dart';
import 'package:heroes/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        appBar: AppBarWidget(title: "Nossos Heróis"),
        body: Center(
          child: Container(
            width: min(400, size.width * 0.9),
            child: GridView.count(
              crossAxisSpacing: 1,
              mainAxisSpacing: 2,
              crossAxisCount: 1,
              childAspectRatio: 6,
              padding: const EdgeInsets.all(8.0),
              children: controller.heroes
                  .map((e) => Container(
                        //width: size.width * 0.9,
                        height: 74,
                        child: Container(
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            //mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                width: 65,
                                height: 74,
                                //Image.asset(AppImagese.photoUrl),
                                child: Image.asset(
                                  AppImages.photo,
                                  width: 65,
                                  height: 74,
                                ),
                              ),
                              Container(
                                height: 74,
                                //width: (size.width * 0.8) - 70,
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment..start,
                                  children: [
                                    Container(
                                        height: 15,
                                        //width: (size.width * 0.8) - 73,
                                        child: Text.rich(TextSpan(
                                          text: e.nome,
                                          style: AppTextStyles.bodyBold,
                                          children: [
                                            //TextSpan(
                                            //  text: title,
                                            //  style: AppTextStyles.titleBold,
                                            //)
                                          ],
                                        ))),
                                    Container(
                                        //width: (size.width * 0.8) - 73,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 45,
                                              child: MaterialButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HeroManutPage(
                                                                  id: e.id,
                                                                  nome: e.nome,
                                                                  peso: e.peso,
                                                                  velocidade: e
                                                                      .velocidade,
                                                                  altura:
                                                                      e.altura,
                                                                  universo: e
                                                                      .universo,
                                                                  photoUrl: e
                                                                      .photoUrl,
                                                                  action:
                                                                      'edit')));
                                                },
                                                color: Colors.blue,
                                                textColor: Colors.white,
                                                child: Icon(
                                                  Icons.edit,
                                                  size: 24,
                                                ),
                                                padding: EdgeInsets.all(2),
                                                shape: CircleBorder(),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 45,
                                              child: MaterialButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HeroManutPage(
                                                                  id: e.id,
                                                                  nome: e.nome,
                                                                  peso: e.peso,
                                                                  velocidade: e
                                                                      .velocidade,
                                                                  altura:
                                                                      e.altura,
                                                                  universo: e
                                                                      .universo,
                                                                  photoUrl: e
                                                                      .photoUrl,
                                                                  action:
                                                                      'delete')));
                                                },
                                                color: Colors.blue,
                                                textColor: Colors.white,
                                                child: Icon(
                                                  Icons.delete,
                                                  size: 24,
                                                ),
                                                padding: EdgeInsets.all(2),
                                                shape: CircleBorder(
                                                    side: BorderSide.none),
                                              ),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
            bottom: true,
            child: Container(
              height: 80,
              width: min(400, size.width * 0.9),
              child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 150,
                              child: ButtonWidget.insert(onTap: () {})),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              width: 150,
                              child: ButtonWidget.figth(onTap: () {})),
                        ])),
              ),
            )),
      );
    }
  }
}
