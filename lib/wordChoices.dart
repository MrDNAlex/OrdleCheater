import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ordlecheater/WordClass.dart';

import 'UIManipulation.dart';


class WordChoices {

  late final WordClass wordClass;

  //probably use async and await things

  wordChoices (WordClass wClass) {
   // this.wordClass = wClass;




  }

  Future<Widget> idk (BuildContext context, WordClass wordClass) async {
    return await words(context, wordClass);
  }



  Future<Widget> words(BuildContext context, WordClass wordClass) async {

    this.wordClass = wordClass;

    return Container(
      padding: EdgeInsets.only(
          left: 0,
          top: UIManipulation.getScreenHeightPix(context) * 0.1,
          right: 0,
          bottom: 0),
      child: FractionallySizedBox(
        widthFactor: UIManipulation.getPlatformFac(0.7, 0.95),
        child: Container(
          alignment: Alignment.center,
          padding:
          EdgeInsets.all(UIManipulation.getScreenWidthPix(context) * 0.05),
          decoration: const BoxDecoration(
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child: Expanded(child: await buildGridView()),
        ),
      ),
    );
  }

  Future<Widget> buildGridView() async => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: platfromGridNum(),
      crossAxisSpacing: 20,
    ),
    itemBuilder: (context, index) {
      return BuildGridWidget(index);
    },
    itemCount: maxNum(wordClass.possibleWords.length),
  );

  Widget BuildGridWidget(int index) {
    return Container(
        alignment: Alignment.center,
        child: Container(
          height: platformFontSize() + 10,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.lightBlueAccent,
          ),
          child: Text(
            wordClass.possibleWords[index],
            maxLines: 1,
            style: TextStyle(fontSize: platformFontSize()),
          ),
        ));
  }

  int platfromGridNum() {
    if (kIsWeb) {
      return 4;
    } else {
      //Phones and Other Platforms
      return 2;
    }
  }

  double platformFontSize() {
    if (kIsWeb) {
      return 80;
    } else {
      //Phones and Other Platforms
      return 45;
    }
  }

  int maxNum(int length) {
    if (length > 100) {
      return 100;
    } else {
      return length;
    }
  }


}