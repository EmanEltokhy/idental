import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defaultButton(width, height, text, formFieldKey,{nameFiledKey}) => TextButton(
    onPressed: (){
      formFieldKey.currentState!.validate();
      nameFiledKey.currentState!.validate();
      },
    child: Container(
      width: width,
      height: height,
      alignment: AlignmentDirectional.centerEnd,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(colors: [
            Colors.teal,
            Color(0xFF80CBC4),
          ])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$text",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w500)),
          SizedBox(width: 20,),
          Icon(Icons.arrow_forward,color: Colors.white,)
        ],
      ),
    )
);