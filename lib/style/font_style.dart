import 'package:csc344_project/style/color.dart';
import 'package:flutter/material.dart';

const smallestSize = 12.0;
const regularSize = 14.0;
const mediumSize = 16.0;
const bigSize = 20.0;

const String RobotoFont = 'Roboto';

class FontCollection {
  static const topicTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w400,
    fontSize: bigSize,
    color: Color(0xFF512DA8),
  );

  static const topicBoldTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w700,
    fontSize: bigSize,
    color: Color(0xFF512DA8),
  );
  //
  // static const  appbarTextStyle = TextStyle(
  //   fontFamily: NotoSansFont,
  //   fontWeight: FontWeight.w400,
  //   fontSize: bigSize,
  //   color: Colors.black,
  // );
  //
  // static const orderDetailHeaderTextStyle = TextStyle(
  //   fontFamily: NotoSansFont,
  //   fontWeight: FontWeight.w700,
  //   fontSize: bigSize,
  //   color: CollectionsColors.orange,
  // );

  static const bodyTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w400,
    fontSize: mediumSize,
    color: Colors.white,
  );

  static const bodyBlackTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w400,
    fontSize: mediumSize,
    color: Colors.black,
  );

  static const bodyBoldTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w700,
    fontSize: mediumSize,
    color: Colors.black,
  );

  static const bodyBoldPurpleTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w700,
    fontSize: mediumSize,
    color: CollectionsColors.deepPurple,
  );

  static const bodyPurpleTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w400,
    fontSize: mediumSize,
    color: CollectionsColors.deepPurple,
  );

  static const smallBodyTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w400,
    fontSize: regularSize,
    color: Colors.white,
  );

  static const descriptionTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w400,
    fontSize: smallestSize,
    color: Colors.white,
  );

  // static const buttonTextStyle = TextStyle(
  //   fontFamily: NotoSansFont,
  //   fontWeight: FontWeight.w400,
  //   fontSize: bigSize,
  //   color: Colors.black,
  // );
  //
  static const underlineButtonTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w400,
    fontSize: regularSize,
    color: Colors.black,
    decoration: TextDecoration.underline,
  );
  //
  // static const underlineSmallButtonTextStyle = TextStyle(
  //   fontFamily: NotoSansFont,
  //   fontWeight: FontWeight.w400,
  //   fontSize: smallestSize,
  //   color: Colors.black,
  //   decoration: TextDecoration.underline,
  // );
}
