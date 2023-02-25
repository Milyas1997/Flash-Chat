import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Widget CustomField(String lbeltxt,String hintxt,TextEditingController controller,{required Function validator} ){
//   return TextFormField(
//     controller: controller,
//     decoration: InputDecoration(
//       labelText: lbeltxt,
//       hintText: hintxt,
//       border: OutlineInputBorder(),
//     ),
//     validator:validator()
//   );
// }
class CustomField extends StatelessWidget {
  CustomField(
      {Key? key,
      required this.lbeltxt,
      required this.hintxt,
     
      required this.txtclr
      })
      : super(key: key);
  String lbeltxt;
  String hintxt;
  String? fieldtxt;
  TextEditingController txtclr;

//TextEditingController controller;
// Function validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
         controller: txtclr,
        decoration: InputDecoration(
          labelText: lbeltxt,
          hintText: hintxt,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          fieldtxt = value;
        });
  }
}
