import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defaultButton(width, height, text,arrow, fn) => TextButton(
    onPressed: fn,
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
          if(arrow)...[
            Icon(Icons.arrow_forward,color: Colors.white,)
          ]
          else

            Icon(Icons.logout_outlined,color: Colors.white),


        ],
      ),
    )
);


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  bool isPassword = false,
 String? Function(String?)? validate,
  required String label,
  required var prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
  TextStyle? style,
  GlobalKey<FormFieldState>? key,
  FloatingLabelBehavior? floatingLabelBehavior,
  String? intialvalue,



}) =>
    TextFormField(

      initialValue: intialvalue,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: '$label',
        labelStyle: GoogleFonts.montserrat(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        prefixIcon: Icon(prefix,
            color: Colors.black),
      ),
    );


void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );
//
// void showToast({
//   required String text,
//   required ToastStates state,
// }) =>
//     Fluttertoast.showToast(
//       msg: text,
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 5,
//       backgroundColor: chooseToastColor(state),
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );

// enum
// enum ToastStates { SUCCESS, ERROR, WARNING }
//
// Color chooseToastColor(ToastStates state) {
//   Color color;
//
//   switch (state) {
//     case ToastStates.SUCCESS:
//       color = Colors.green;
//       break;
//     case ToastStates.ERROR:
//       color = Colors.red;
//       break;
//     case ToastStates.WARNING:
//       color = Colors.amber;
//       break;
//   }
//
//   return color;
// }

// Widget buildTextField(String labelText, String placeholder, bool isPasswordTextField) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 35.0),
//     child: TextFormField(
//       controller: controller(labelText),
//       readOnly: edit,
//       obscureText: isPasswordTextField ? showPassword : false,
//       decoration: InputDecoration(
//           suffixIcon: isPasswordTextField?
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 showPassword = !showPassword;
//               });
//             },
//             icon: Icon(
//               Icons.remove_red_eye,
//               color: Colors.grey,
//             ),
//           ): null,
//           contentPadding: EdgeInsets.only(bottom: 3),
//           labelText: labelText,
//           labelStyle: GoogleFonts.montserrat(
//               fontSize: 15,
//               color: Colors.grey,
//               fontWeight: FontWeight.bold),
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           hintText: placeholder,
//           hintStyle: GoogleFonts.montserrat(
//               fontSize: 16,
//               color: Colors.black,
//               fontWeight: FontWeight.bold)),
//     ),
//   );
// }
// // TextEditingController? controller(String labelText)
// // {
// //   if(labelText == "Full Name") {
// //     return nameController;
// //   }
// //   else if(labelText == "UserName") {
// //     return userNameController;
// //   }
// //   else if(labelText == "Email") {
// //     return emailController;
// //   }
// //   else if(labelText == "Password") {
// //     return passwordController;
// //   }
// //   else if(labelText == "Country") {
// //     return countryController;
// //   }
// // }
