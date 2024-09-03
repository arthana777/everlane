import 'package:everlane/questionnaire/questions.dart';
import 'package:flutter/material.dart';

class Qstmodalbottomsheet {
  static void moreModalBottomSheet(context) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: size.height * 0.6,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [Questions()],
              ),
            ),
          );
        });
  }
}
