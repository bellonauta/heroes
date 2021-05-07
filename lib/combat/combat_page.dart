import 'dart:math';
import 'dart:typed_data';
import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:heroes/core/app_colors.dart';
import 'package:heroes/core/app_gradients.dart';
import 'package:heroes/core/app_images.dart';
import 'package:heroes/core/app_text_styles.dart';
import 'package:heroes/functions.dart';
import 'package:heroes/combat/combat_controller.dart';
import 'package:heroes/home/home_page.dart';
import 'package:heroes/manut/heromanut_page.dart';
import 'package:heroes/shared/models/hero_model.dart';
import 'package:heroes/shared/widgets/appbar.dart';
import 'package:heroes/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroes/dartjs.dart';

import 'combat_state.dart';

class CombatPage extends StatefulWidget {
  CombatPage();

  @override
  _CombatPageState createState() => _CombatPageState();
}

class _CombatPageState extends State<CombatPage> {
  final controller = CombatController();
  final ValueNotifier<int> _selectedCombatant = ValueNotifier<int>(0);

  List<bool> isFavorited = [false, true];

  Map<String, HeroModel> _fighters = {"left": null, "right": null};

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

    if (controller.state != CombatState.success) {
      // Carregando...
      return Scaffold(
          body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
        ),
      ));
    } else {
      return Scaffold(
        appBar: AppBarWidget(title: "COMBATE!!  Selecione os combatentes!"),
        body: Center(
          child: Scrollbar(
            isAlwaysShown: false,
            showTrackOnHover: true,
            child: Column(
              children: [
                Scrollbar(
                  isAlwaysShown: false,
                  showTrackOnHover: true,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    width: min(400, size.width * 0.9),
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: min(400, size.width * 0.9),
                          height: 246,
                          child: Scrollbar(
                            isAlwaysShown: false,
                            showTrackOnHover: true,
                            child: GridView.count(
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 2,
                              crossAxisCount: 1,
                              childAspectRatio: 6,
                              padding: const EdgeInsets.all(3.0),
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
                                                      horizontal: 4,
                                                      vertical: 4),
                                                  child: Tooltip(
                                                      message:
                                                          'Clique duas vezes para selecionar.',
                                                      child: GestureDetector(
                                                          onDoubleTap: () {
                                                            if ((e ==
                                                                        _fighters[
                                                                            'left'] ||
                                                                    e ==
                                                                        _fighters[
                                                                            'right']) &&
                                                                (_fighters['left'] ==
                                                                        null ||
                                                                    _fighters[
                                                                            'right'] ==
                                                                        null)) {
                                                              msgBox(
                                                                  title:
                                                                      "Ooops...",
                                                                  message:
                                                                      "Esse herói já foi selecionado para o combate!",
                                                                  boxContext:
                                                                      context);
                                                            } else if (_selectedCombatant
                                                                        .value ==
                                                                    0 ||
                                                                (_fighters['left'] !=
                                                                        null &&
                                                                    _fighters[
                                                                            'right'] !=
                                                                        null)) {
                                                              this._fighters[
                                                                  'left'] = e;
                                                              this._fighters[
                                                                      'right'] =
                                                                  null;
                                                              _selectedCombatant
                                                                  .value = 1;
                                                            } else if (_selectedCombatant
                                                                    .value ==
                                                                1) {
                                                              this._fighters[
                                                                  'right'] = e;
                                                              _selectedCombatant
                                                                  .value = 0;
                                                            }
                                                          },
                                                          child: Container(
                                                            //width: MediaQuery.of(context).size.width,
                                                            //height: 74,
                                                            width: 80,
                                                            height: 74,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                fit:
                                                                    BoxFit.fill,
                                                                image: (e.photo !=
                                                                            null &&
                                                                        e.photo
                                                                            is Uint8List)
                                                                    ? Image
                                                                        .memory(
                                                                        e.photo,
                                                                        //width: 160,
                                                                        //height: 140,
                                                                      ).image
                                                                    : Image.asset(
                                                                            AppImages.person)
                                                                        .image,
                                                              ),
                                                            ),
                                                          ))),

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
                                                  child: Text.rich(TextSpan(
                                                text: e.nome,
                                                style: AppTextStyles.body20,
                                                children: [
                                                  //TextSpan(
                                                  //  text: title,
                                                  //  style: AppTextStyles.titleBold,
                                                  //)
                                                ],
                                              )))
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                        Container(
                            width: min(400, size.width * 0.9),
                            height: 50,
                            child: Scrollbar(
                              isAlwaysShown: false,
                              showTrackOnHover: true,
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(3),
                                  child: ToggleButtons(
                                      children: <Widget>[
                                        Tooltip(
                                            message:
                                                "Somente meus heróis favoritos",
                                            child: Icon(Icons.favorite)),
                                        Tooltip(
                                            message: "Todos os heróis",
                                            child: Icon(
                                                Icons.favorite_border_rounded)),
                                      ],
                                      isSelected: isFavorited,
                                      borderColor: Colors.blueAccent,
                                      disabledBorderColor: Colors.blueAccent,
                                      selectedBorderColor: Colors.lightBlue,
                                      borderWidth: 4,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          bottomRight: Radius.circular(25)),
                                      onPressed: (int index) {
                                        setState(() {
                                          if (isFavorited[index] == false) {
                                            for (int buttonIndex = 0;
                                                buttonIndex <
                                                    isFavorited.length;
                                                buttonIndex++) {
                                              if (buttonIndex == index) {
                                                isFavorited[buttonIndex] = true;
                                              } else {
                                                isFavorited[buttonIndex] =
                                                    false;
                                              }
                                            }
                                            if (index == 0) {
                                              controller.getFavoriteHeroes();
                                            } else {
                                              controller.getHeroes();
                                            }
                                          }
                                        });
                                      })),
                            ))
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(5.0) //
                        ),
                  ),
                  width: min(400, size.width * 0.9),
                  height: 100,
                  child: Scrollbar(
                    isAlwaysShown: false,
                    showTrackOnHover: true,
                    child: Center(
                      child: ValueListenableBuilder(
                          builder: (BuildContext context, int value, _) {
                            // This builder will only get called when the _favCounter is updated.
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 80,
                                  height: 74,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: (_fighters['left'] != null &&
                                                _fighters['left'].photo != null)
                                            ? Image.memory(
                                                    _fighters['left'].photo)
                                                .image
                                            : Image.asset(AppImages.person)
                                                .image),
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    "X",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 74,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: (_fighters['right'] != null &&
                                                _fighters['right'].photo !=
                                                    null)
                                            ? Image.memory(
                                                    _fighters['right'].photo)
                                                .image
                                            : Image.asset(AppImages.person)
                                                .image),
                                  ),
                                ),
                              ],
                            );
                          },
                          valueListenable: _selectedCombatant),
                    ),
                  ),
                )
              ],
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
                              child: ButtonWidget.back(onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              })),
                          SizedBox(
                            width: 20,
                          ),
                          controller.heroes.length > 0
                              ? Container(
                                  width: 150,
                                  child: ButtonWidget.combat(onTap: () {
                                    int w = winner(
                                        double.tryParse(_fighters['left'].peso),
                                        double.tryParse(
                                            _fighters['left'].altura),
                                        double.tryParse(
                                            _fighters['left'].velocidade),
                                        _fighters['left'].favorito == 'S',
                                        double.tryParse(
                                            _fighters['right'].peso),
                                        double.tryParse(
                                            _fighters['right'].altura),
                                        double.tryParse(
                                            _fighters['right'].velocidade),
                                        _fighters['right'].favorito == 'S');
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("E o vencedor é..."),
                                          content: Container(
                                              alignment: Alignment.center,
                                              width: 90,
                                              height: 94,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: Image.memory(
                                                  w == 1
                                                      ? _fighters['left'].photo
                                                      : _fighters['right']
                                                          .photo,
                                                  //width: 90,
                                                  //height: 94,
                                                ).image,
                                              ))),
                                          actions: [
                                            TextButton(
                                              child: Text("OK"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }))
                              : Container(height: 0.0, width: 0.0)
                        ])),
              ),
            )),
      );
    }
  }
}
