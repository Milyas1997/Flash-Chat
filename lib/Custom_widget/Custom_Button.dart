import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Color color;
  String title;
  CustomButton({required this.color, required this.title}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: color,
      ),
      child: Center(
        child: Text(
          '$title',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
