import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:heroes/core/app_colors.dart';
import 'package:heroes/core/app_gradients.dart';
import 'package:heroes/core/app_images.dart';
import 'package:heroes/core/app_text_styles.dart';
import 'package:heroes/functions.dart';
import 'package:heroes/home/home_controller.dart';
import 'package:heroes/combat/combat_page.dart';
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
  final ValueNotifier<int> _favCounter = ValueNotifier<int>(0);
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
            child: ValueListenableBuilder(
                builder: (BuildContext context, int value, _) {
                  // This builder will only get called when the _favCounter is updated.
                  return Scrollbar(
                    isAlwaysShown: false,
                    showTrackOnHover: true,
                    child: GridView.count(
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 2,
                      crossAxisCount: 1,
                      childAspectRatio: 6,
                      padding: const EdgeInsets.all(8.0),
                      children: controller.heroes
                          .map((e) => Container(
                                //width: size.width * 0.9,
                                height: 100,
                                width: min(400, size.width * 0.9),
                                child: Container(
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    //mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 2),
                                          width: 80,

                                          ///height: 74,
                                          child: Container(
                                            //width: MediaQuery.of(context).size.width,
                                            //height: 74,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: e.photo is Uint8List
                                                    ? Image.memory(
                                                        e.photo,
                                                        //width: 160,
                                                        //height: 140,
                                                      ).image
                                                    : Image.asset(AppImages
                                                            .personOpac)
                                                        .image,
                                              ),
                                            ),
                                          ),
                                          /*Image.memory(e.photo,
                                              width: 65,
                                              height: 74,
                                              cacheHeight: 65,
                                              cacheWidth: 74,
                                              fit: BoxFit.fitWidth,
                                              filterQuality: FilterQuality.low), */
                                        ),
                                      ),
                                      Container(
                                        //alignment: Alignment.bottomLeft,
                                        //height: 74,
                                        //width: (size.width * 0.8) - 70,
                                        child: Column(
                                          children: [
                                            Container(
                                                //height: 38,
                                                //width: (size.width * 0.8) - 73,
                                                //alignment: Alignment.centerLeft,
                                                child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text.rich(TextSpan(
                                                text: e.nome,
                                                style: AppTextStyles.bodyBold,
                                                children: [
                                                  //TextSpan(
                                                  //  text: title,
                                                  //  style: AppTextStyles.titleBold,
                                                  //)
                                                ],
                                              )),
                                            )),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                  //width: (size.width * 0.8) - 73,
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 5),
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
                                                                    builder: (context) => HeroManutPage(
                                                                        id: e
                                                                            .id,
                                                                        nome: e
                                                                            .nome,
                                                                        photo: e
                                                                            .photo,
                                                                        peso: e
                                                                            .peso,
                                                                        velocidade: e
                                                                            .velocidade,
                                                                        altura: e
                                                                            .altura,
                                                                        universo: e
                                                                            .universo,
                                                                        action:
                                                                            'update')));
                                                          },
                                                          color: Colors.blue,
                                                          textColor:
                                                              Colors.white,
                                                          child: Tooltip(
                                                            message:
                                                                "Editar o cadastro do herói",
                                                            child: Icon(
                                                              Icons.edit,
                                                              size: 24,
                                                            ),
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(2),
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
                                                                    builder: (context) => HeroManutPage(
                                                                        id: e
                                                                            .id,
                                                                        nome: e
                                                                            .nome,
                                                                        photo: e
                                                                            .photo,
                                                                        peso: e
                                                                            .peso,
                                                                        velocidade: e
                                                                            .velocidade,
                                                                        altura: e
                                                                            .altura,
                                                                        universo: e
                                                                            .universo,
                                                                        action:
                                                                            'delete')));
                                                          },
                                                          color: Colors.blue,
                                                          textColor:
                                                              Colors.white,
                                                          child: Tooltip(
                                                            message:
                                                                "Excluir o cadastro do herói",
                                                            child: Icon(
                                                              Icons.delete,
                                                              size: 24,
                                                            ),
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          shape: CircleBorder(
                                                              side: BorderSide
                                                                  .none),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 45,
                                                        child: MaterialButton(
                                                          onPressed: () {
                                                            postManut(
                                                                context:
                                                                    context,
                                                                body: {
                                                                  "action":
                                                                      "favorite",
                                                                  "id": e.id,
                                                                  'favorito':
                                                                      e.favorito ==
                                                                              'S'
                                                                          ? 'N'
                                                                          : 'S'
                                                                },
                                                                onAfterPost:
                                                                    (success,
                                                                        message,
                                                                        heroId) {
                                                                  if (!success) {
                                                                    msgBox(
                                                                        title:
                                                                            "Ooops...",
                                                                        message:
                                                                            "Ocorreu uma falha na manutenção.\n\n" +
                                                                                message,
                                                                        boxContext:
                                                                            context);
                                                                  } else {
                                                                    controller
                                                                        .heroes[controller
                                                                            .heroes
                                                                            .indexOf(
                                                                                e)]
                                                                        .favorito = e.favorito ==
                                                                            'S'
                                                                        ? 'N'
                                                                        : 'S';
                                                                    if (_favCounter
                                                                            .value <
                                                                        100) {
                                                                      _favCounter
                                                                          .value++;
                                                                    } else {
                                                                      _favCounter
                                                                          .value = 0;
                                                                    }
                                                                  }
                                                                });
                                                          },
                                                          color: Colors.blue,
                                                          textColor:
                                                              Colors.white,
                                                          child: Tooltip(
                                                            message: e.favorito ==
                                                                    'N'
                                                                ? "Adicionar herói nos favoritos"
                                                                : "Remover herói dos favoritos",
                                                            child: Icon(
                                                              e.favorito == 'S'
                                                                  ? Icons
                                                                      .favorite_border_rounded
                                                                  : Icons
                                                                      .favorite,
                                                              size: 24,
                                                            ),
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          shape: CircleBorder(
                                                              side: BorderSide
                                                                  .none),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  );
                },
                valueListenable: _favCounter),
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
                              child: ButtonWidget.insert(onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HeroManutPage(
                                            id: "",
                                            nome: "",
                                            peso: "",
                                            velocidade: "",
                                            altura: "",
                                            universo: "",
                                            photo: null,
                                            action: 'insert')));
                              })),
                          SizedBox(
                            width: 20,
                          ),
                          controller.heroes.length > 0
                              ? Container(
                                  width: 150,
                                  child: ButtonWidget.combat(onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CombatPage()));
                                  }))
                              : Container(height: 0.0, width: 0.0)
                        ])),
              ),
            )),
      );
    }
  }
}
