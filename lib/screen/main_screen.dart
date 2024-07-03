import 'package:flutter/material.dart';
import 'package:flutter_calculator/controller/calculate_controller.dart';
import 'package:flutter_calculator/theme/colors.dart';
import 'package:flutter_calculator/button/button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'history_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final List<String> buttons = [
    "CLR",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];

  final List<String> buttonsLandscape = [
    "CLR",
    "DEL",
    "9",
    "%",
    "/",
    "8",
    "7",
    "6",
    "5",
    "x",
    "4",
    "3",
    "2",
    "1",
    "+",
    "-",
    "0",
    ".",
    "ANS",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CalculateController>();
    final mediaQuery = MediaQuery.of(context);
    double fontSize = mediaQuery.size.aspectRatio * 2;
    double paddingValue = mediaQuery.size.width * 0.03;
    int crossAxisCount =
    (mediaQuery.size.width < 600 || mediaQuery.orientation == Orientation.portrait)
        ? 4
        : 5;

    if (mediaQuery.orientation == Orientation.landscape) {
      return Scaffold(
          backgroundColor: DarkColors.scaffoldBgColor,
          body: Row(
            children: [
              Expanded(
                flex: 1,
                child: History(),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    GetBuilder<CalculateController>(builder: (context) {
                      return outPutSection(controller, mediaQuery);
                    }),
                    GetBuilder<CalculateController>(builder: (context) {
                      return Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(paddingValue),
                            decoration: const BoxDecoration(
                                color: DarkColors.sheetBgColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                            child: GridView.builder(
                                shrinkWrap: true,
                                //physics: const NeverScrollableScrollPhysics(),
                                itemCount: buttonsLandscape.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  //childAspectRatio: (mediaQuery.size.aspectRatio)*1.5
                                ),
                                itemBuilder: (context, index) {
                                  switch (index) {
                                  /// CLEAR BTN
                                    case 0:
                                      return CustomAppButton(
                                          buttonTapped: () {
                                            controller.clearInputAndOutput();
                                          },
                                          color: DarkColors.leftOperatorColor,
                                          textColor: DarkColors.btnBgColor,
                                          text: buttonsLandscape[index],
                                          font_size: fontSize);

                                  /// DELETE BTN
                                    case 1:
                                      return CustomAppButton(
                                          buttonTapped: () {
                                            controller.deleteBtnAction();
                                          },
                                          color: DarkColors.leftOperatorColor,
                                          textColor: DarkColors.btnBgColor,
                                          text: buttonsLandscape[index],
                                          font_size: fontSize);

                                  /// ANS BTN
                                    case 18:
                                      return CustomAppButton(
                                          buttonTapped: () {
                                            controller.onAnsTapped();
                                          },
                                          color: DarkColors.btnBgColor,
                                          textColor: Colors.white,
                                          text: buttonsLandscape[index],
                                          font_size: fontSize);

                                  /// EQUAL BTN
                                    case 19:
                                      return CustomAppButton(
                                          buttonTapped: () {
                                            controller.equalPressed();
                                          },
                                          color: DarkColors.leftOperatorColor,
                                          textColor: DarkColors.btnBgColor,
                                          text: buttonsLandscape[index],
                                          font_size: fontSize);

                                    default:
                                      return CustomAppButton(
                                          buttonTapped: () {
                                            controller.onBtnTapped(buttonsLandscape, index);
                                          },
                                          color: DarkColors.btnBgColor,
                                          textColor: Colors.white,
                                          text: buttonsLandscape[index],
                                          font_size: fontSize);
                                  }
                                }),
                          ));
                    }),
                  ],
                ),
              ),
            ],
          ));
    } else {
      return Scaffold(
          backgroundColor: DarkColors.scaffoldBgColor,
          appBar: AppBar(
            title: const Text('Calculator',
                style: TextStyle(fontWeight: FontWeight.w400)),
            backgroundColor: DarkColors.scaffoldBgColor,
            actions: [
              IconButton(
                icon: const Icon(Icons.history, size: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => History()),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              GetBuilder<CalculateController>(builder: (context) {
                return outPutSection(controller, mediaQuery);
              }),
              inPutSection(controller, mediaQuery, Orientation.portrait),
            ],
          ));
    }
  }

  /// Enter Numbers
  Widget inPutSection(CalculateController controller, MediaQueryData mediaQuery,
      Orientation orientation) {
    double paddingValue = mediaQuery.size.width * 0.03;
    int crossAxisCount =
        (mediaQuery.size.width < 600 || orientation == Orientation.portrait)
            ? 4
            : 5;
    double fontSize = mediaQuery.size.aspectRatio * 2;

    return Expanded(
        flex: 2,
        child: Container(
          padding: EdgeInsets.all(paddingValue),
          decoration: const BoxDecoration(
              color: DarkColors.sheetBgColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: buttons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                //childAspectRatio: (mediaQuery.size.aspectRatio)*1.5
              ),
              itemBuilder: (context, index) {
                switch (index) {
                  /// CLEAR BTN
                  case 0:
                    return CustomAppButton(
                        buttonTapped: () {
                          controller.clearInputAndOutput();
                        },
                        color: DarkColors.leftOperatorColor,
                        textColor: DarkColors.btnBgColor,
                        text: buttons[index],
                        font_size: fontSize);

                  /// DELETE BTN
                  case 1:
                    return CustomAppButton(
                        buttonTapped: () {
                          controller.deleteBtnAction();
                        },
                        color: DarkColors.leftOperatorColor,
                        textColor: DarkColors.btnBgColor,
                        text: buttons[index],
                        font_size: fontSize);

                  /// ANS BTN
                  case 18:
                    return CustomAppButton(
                        buttonTapped: () {
                          controller.onAnsTapped();
                        },
                        color: DarkColors.btnBgColor,
                        textColor: Colors.white,
                        text: buttons[index],
                        font_size: fontSize);

                  /// EQUAL BTN
                  case 19:
                    return CustomAppButton(
                        buttonTapped: () {
                          controller.equalPressed();
                        },
                        color: DarkColors.leftOperatorColor,
                        textColor: DarkColors.btnBgColor,
                        text: buttons[index],
                        font_size: fontSize);

                  default:
                    return CustomAppButton(
                        buttonTapped: () {
                          controller.onBtnTapped(buttons, index);
                        },
                        color: DarkColors.btnBgColor,
                        textColor: Colors.white,
                        text: buttons[index],
                        font_size: fontSize);
                }
              }),
        ));
  }

  /// Show Result
  Widget outPutSection(
      CalculateController controller, MediaQueryData mediaQuery) {
    return Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Main Result
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 30, left: 20),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      controller.userInput,
                      style:
                          GoogleFonts.ubuntu(color: Colors.white, fontSize: 26),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      controller.userOutput,
                      style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  /// Operator Check
  bool isOperator(String y) {
    if (y == "%" || y == "/" || y == "x" || y == "-" || y == "+" || y == "=") {
      return true;
    }
    return false;
  }

  static void showSnackBar(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 600),
      ),
    );
  }
}
