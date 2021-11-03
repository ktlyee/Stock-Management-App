import 'package:csc344_project/style/color.dart';
import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  CustomStepper({
    // @required this.lowerLimit,
    // @required this.upperLimit,
    // @required this.stepValue,
    required this.iconSize,
    required this.value,
    this.increaseAmount,
    this.decreaseAmount,
  });

  // final int lowerLimit;
  // final int upperLimit;
  // final int stepValue;
  final double iconSize;
  final int value;
  final Function()? increaseAmount;
  final Function()? decreaseAmount;

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedIconButton(
          icon: Icons.remove,
          iconSize: widget.iconSize,
          onPress: widget.decreaseAmount!,
        ),
        Container(
          width: widget.iconSize,
          child: Text(
            '${widget.value}',
            style: TextStyle(
              fontSize: widget.iconSize * 0.8,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        RoundedIconButton(
          icon: Icons.add,
          iconSize: widget.iconSize,
          onPress: widget.increaseAmount!,
        ),
      ],
    );
  }
}

class RoundedIconButton extends StatelessWidget {
  RoundedIconButton({
    required this.icon,
    required this.onPress,
    required this.iconSize,
  });

  final IconData icon;
  final Function() onPress;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(width: iconSize, height: iconSize),
      elevation: 2.0,
      onPressed: onPress,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(iconSize * 0.8),
      ),
      fillColor: CollectionsColors.yellow,
      child: Icon(
        icon,
        color: Colors.white,
        size: iconSize * 0.8,
      ),
    );
  }
}
