import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:idental/shared/components/components.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormFieldState> formFieldKey = GlobalKey();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool checkBoxValue = false;
  bool showPass = true;
  FocusNode? passwordFocus;
  @override
  void initState() {
    super.initState();
    passwordFocus = FocusNode();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordFocus?.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: DrawClip(),
                    child: Container(
                        color: Colors.teal[200],
                        height: size.height / 2.9),
                  ),
                  ClipPath(
                    clipper: DrawClip1(),
                    child: Container(
                        color: Colors.teal, height: size.height / 2.9),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Login",
                            style: GoogleFonts.montserrat(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,

                            )),
                        SizedBox(height: 5,),
                        Text("please sign in to continue",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Colors.grey,))
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Container(
                    //   decoration: BoxDecoration(
                    //     boxShadow:[BoxShadow(color: Colors.grey,blurRadius: 10)],
                    //   ),
                    //   child: TextFormField(
                    //     style: GoogleFonts.montserrat(
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.black,
                    //     ),
                    //
                    //     decoration: InputDecoration(
                    //       fillColor: Colors.white,
                    //       filled: true,
                    //       labelText: 'EMAIL',
                    //       labelStyle: GoogleFonts.montserrat(
                    //           fontSize: 15,
                    //           fontWeight: FontWeight.w400,
                    //           color: Colors.grey),
                    //       enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(5),
                    //           borderSide:
                    //           BorderSide(color: Colors.white)),
                    //       border:
                    //       UnderlineInputBorder(borderSide: BorderSide.none),
                    //       prefixIcon: Icon(Icons.email_rounded,
                    //           color: Colors.black),
                    //     ),
                    //   ),
                    // ),
                    TextFormField(
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      key: formFieldKey,
                      controller: emailController,
                      validator: (value) => EmailValidator.validate(emailController.text)?null : "Please enter a valid email",
                      decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey)),
                        prefixIcon: Icon(Icons.email_outlined,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 60,
                      child: TextFormField(
                        obscureText: showPass,
                        controller: passwordController,
                        focusNode: passwordFocus,
                        onTap: (){
                          setState(() {
                            FocusScope.of(context).unfocus();
                            FocusScope.of(context).requestFocus(passwordFocus);
                          });
                        },
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey)),
                          prefixIcon: Icon(Icons.lock_outline_sharp,
                              color: Colors.black),
                          suffixIcon: Container(
                            width: 50,
                            alignment: AlignmentDirectional.center,
                              child: Text("Forget",style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.teal),),
                          ),
                          suffix: IconButton(
                            icon: Icon(Icons.remove_red_eye,
                              color: Colors.black),
                              onPressed: ()=> setState(() {
                                showPass = !showPass;
                              }),
                            alignment: AlignmentDirectional.bottomCenter,
                          ),
                          ),
                        ),
                    ),

                    new FlutterPwValidator(
                        controller: passwordController,
                        minLength: 6,
                        uppercaseCharCount: 1,
                        specialCharCount: 1,
                        width: 400,
                        height: 85,
                        onSuccess: (){},
                        onFail: (){}
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // Row(
                    //   children: [
                    //     Checkbox(
                    //       value: checkBoxValue,
                    //       onChanged: (bool? value) {
                    //         setState(() {
                    //           if (checkBoxValue == true) {
                    //             checkBoxValue = false;
                    //           } else {
                    //             checkBoxValue = true;
                    //           }
                    //         });
                    //       },
                    //       activeColor: Color(0xff54ccf5),
                    //     ),
                    //     Text(
                    //       'I agree to the terms and conditions',
                    //       overflow: TextOverflow.fade,
                    //       softWrap: true,
                    //       style: GoogleFonts.montserrat(
                    //           color: Colors.grey.shade600,
                    //           fontWeight: FontWeight.w300,
                    //           fontSize:14,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    SizedBox(
                      height: 30,
                    ),
                    defaultButton(150.0, 50.0, 'LOGIN', formFieldKey)
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: size.height/10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      child: Text("Don't have an account?",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Colors.grey,)),
                    ),
                    SizedBox(width: 5,),
                    TextButton(
                        onPressed: (){},
                        child: Text("Sign up",
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: Colors.teal,))
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawClip1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width*0.95, 0);
    path.lineTo(size.width * 0.65, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.65-10, size.height * 0.3+10, size.width * 0.65, size.height * 0.4 );
    path.lineTo(size.width * 0.75, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.75+10, size.height * 0.6+10, size.width * 0.75 + 20, size.height * 0.6+5);
    path.lineTo(size.width, size.height*0.4+20);
    path.lineTo(size.width, 0);
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width*0.83, 0);
    path.lineTo(size.width * 0.58, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.58-10, size.height * 0.2+10, size.width * 0.58-3, size.height * 0.3);
    path.lineTo(size.width * 0.67, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.67+10, size.height * 0.6+10, size.width * 0.67 + 20, size.height * 0.6+5);
    path.lineTo(size.width, size.height*0.4+20);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
