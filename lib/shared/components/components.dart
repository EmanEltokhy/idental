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
  IconData? prefix,
  IconData? suffix,
 void Function()? suffixPressed,
  bool isClickable = true,
  TextStyle? style,
  GlobalKey<FormFieldState>? key,
  FloatingLabelBehavior? floatingLabelBehavior,





}) =>
    TextFormField(
      // hintText: placeholder,
      // hintStyle: GoogleFonts.montserrat(
      //     fontSize: 16,
      //     color: Colors.black,
      //     fontWeight: FontWeight.bold
      //
      // ),
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
suffixIcon: suffix!= null?
IconButton(onPressed: suffixPressed,
    icon: Icon(suffix,
    color: Colors.black,),) : null,

      ),


    );

Widget buildReportItem({
  required context,
  required String dentistname,
  required String patientname,
  required String observation,
}) => Card(
  clipBehavior: Clip.antiAliasWithSaveLayer,
  elevation: 10.0,
  margin: EdgeInsets.symmetric(
    horizontal: 8.0,
  ),
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Row(
          children: [

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${dentistname}',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),

                    ],
                  ),
                  Text(
                    'Febrauray 20, 2023 at 11:00 pm',

                  ),
                ],
              ),
            ),

          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        Text(
          'Patient Name: ${patientname}',


        ),
        SizedBox(width: 15.0,),
        Text(
          'Observation: ${observation}'
        ),



      ],
    ),
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

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}



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
