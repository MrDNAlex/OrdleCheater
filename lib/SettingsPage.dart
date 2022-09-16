//import 'dart:html';

//import 'dart:html';

import 'allColorPalettes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';

import 'UIManipulation.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  List<List<Color>> palettes = Palettes;
  List<Color> currPal = Palettes[0];
  Color textColor = Colors.white;
  int choice = 0;

  Future<String> get idkPath async {
    late final directory;
    if (UIManipulation.isMobile()) {
      directory = await getApplicationDocumentsDirectory();
    } else {}

    String path = directory.path;
    path += "/settings.dna";

    return path;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getColors();
  }

  void getColors() async {
    final prefs = await SharedPreferences.getInstance();
    choice = prefs.getInt('ColorMode') ?? 0;

    setState(() {
      currPal = Palettes[choice];
      textColor = UIManipulation.ColorChoice(Colors.white, Colors.black, choice);
      // textColor = UIManipulation.ColorChoice(Colors.white, Colors.black, choice);
      // wordClass.textColor = UIManipulation.ColorChoice(Colors.white, Colors.black, choice);
    });
  }

  void saveInfo(int colorChoice) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("ColorMode", colorChoice);

    setState (() {
      currPal = Palettes[colorChoice];

      textColor = UIManipulation.ColorChoice(Colors.white, Colors.black, colorChoice);
    });


  }

  void saveFile() async {
//Saving Files into string format, maybe one day find the JSON
    // File file = File(await idkPath);
    //  file.writeAsString(firstPalette.toString());
  }

  void loadFile() async {
    //Load File from string maybe find JSON one day
    File file = File(await idkPath); // 1
    String fileContent = await file.readAsString(); // 2

    print('File Content: $fileContent');
  }

//Tomorrow lets try and figure out the loading system, or we manually set it every time it opens

  Widget colorPaletteChoice(int colorChoice) {

    return GestureDetector(
      onTap: () async {
        saveInfo(colorChoice);
      },
      child: Container(
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
        padding: EdgeInsets.only(
            left: 0,
            top: UIManipulation.getScreenWidthPix(context) *
                UIManipulation.getPlatformFac(0.005, 0.01),
            right: 0,
            bottom: UIManipulation.getScreenWidthPix(context) *
                UIManipulation.getPlatformFac(0.005, 0.01)),
        height: UIManipulation.getScreenHeightPix(context) *
            UIManipulation.getPlatformFac(0.4, 0.15),
        width: UIManipulation.getScreenWidthPix(context) * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
                child: Container(
              decoration: BoxDecoration(
                color: palettes[colorChoice][0],
                borderRadius: BorderRadius.horizontal(
                    right: Radius.zero, left: Radius.circular(20)),
              ),
            )),
            Flexible(
              flex: 1,
                child: Container(
              color: palettes[colorChoice][1],
            )),
            Flexible(
              flex: 1,
                child: Container(
              color: palettes[colorChoice][2],
            )),
            Flexible(
              flex: 1,
                child: Container(
              decoration: BoxDecoration(
                color: palettes[colorChoice][3],
                borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(20), left: Radius.zero),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget privacyPolicy() {







    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currPal[0],
      appBar: null,
      body: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: 0,
              top: UIManipulation.getScreenWidthPix(context) *
                  UIManipulation.getPlatformFac(0.02, 0.05),
              right: 0,
              bottom: 0),
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Settings",
                  style: TextStyle(
                      fontSize: UIManipulation.getScreenHeightPix(context) *
                          UIManipulation.getPlatformFac(0.2, 0.1),
                      color: textColor),
                ),
                Container(child: ,
                )
                colorPaletteChoice(0),
                colorPaletteChoice(1),
                colorPaletteChoice(2),
                colorPaletteChoice(3),
                colorPaletteChoice(4),
                colorPaletteChoice(5),
                colorPaletteChoice(6),
              ],
            ),
          )),
    );
    return Container(
      child: Text("Settings"),
    );
  }






}
