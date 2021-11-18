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
    color: CollectionsColors.black,
  );

  static const topicBoldTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w700,
    fontSize: bigSize,
    color: CollectionsColors.black,
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

  static const bodyBoldTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w700,
    fontSize: mediumSize,
    color: Colors.white,
  );

  static const bodyBlackTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w400,
    fontSize: mediumSize,
    color: Colors.black,
  );

  static const bodyBlackBoldTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w700,
    fontSize: mediumSize,
    color: Colors.black,
  );

  static const smallBodyTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w400,
    fontSize: regularSize,
    color: Colors.white,
  );

  static const smallBodyBlackTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w400,
    fontSize: regularSize,
    color: Colors.black,
  );

  static const descriptionBlackTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w400,
    fontSize: smallestSize,
    color: Colors.black,
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

  ///White

  static const descriptionTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w400,
    fontSize: smallestSize,
    color: Colors.white,
  );

  static const descriptionBoldTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w700,
    fontSize: smallestSize,
    color: Colors.white,
  );


  ///Purple

  static const topicBoldPurpleTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w700,
    fontSize: bigSize,
    color: CollectionsColors.deepPurple,
  );

  static const topicPurpleTextStyle = TextStyle(
    fontFamily: RobotoFont,
    fontWeight: FontWeight.w400,
    fontSize: bigSize,
    color: CollectionsColors.deepPurple,
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
}
