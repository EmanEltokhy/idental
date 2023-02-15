
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:idental/modules/signup/cubit/cubit.dart';
import 'package:idental/modules/signup/cubit/states.dart';
import 'package:idental/shared/components/components.dart';

import '../../layout/home_screen.dart';


class Signup extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> emailFieldKey = GlobalKey();
  final GlobalKey<FormFieldState> nameFieldKey = GlobalKey();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmedPassController = TextEditingController();

  // bool showPass = true;
  //
  // // FocusNode? passwordFocus;
  // bool confShowPass = true;
  // FocusNode? confPasswordFocus;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state){
if(state is CreateDentistSucessState){
  navigateAndFinish(context, HomeScreen());
}

        },
        builder: (context,state){
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
                              Text("CREATE ACCOUNT",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          defaultFormField(

                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            controller: nameController,
                            validate: (value) {
                              if(nameController.text.isEmpty)
                                return 'Name is required';
                              else
                                null;
                            },
                            onSubmit: (value){
                              nameFieldKey.currentState!.validate();
                            },
                            key: nameFieldKey,

                            type: TextInputType.name,
                            label: 'NAME',
                            prefix: Icons.person,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                              type: TextInputType.emailAddress,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              key: emailFieldKey,
                              controller: emailController,
                              onSubmit: (value){
                                emailFieldKey.currentState!.validate();
                              },
                              validate: (value) => EmailValidator.validate(emailController.text)?null : "Please enter a valid email",
                              label: 'EMAIL',
                              prefix: Icons.email_outlined
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 60,
                            child:
                            defaultFormField(
                              // obscureText: showPass,
                              controller: passwordController,
                              // focusNode: ,
                              // onTap: (){
                              //   setState(() {
                              //     FocusScope.of(context).unfocus();
                              //     FocusScope.of(context).requestFocus(passwordFocus);
                              //
                              //   });
                              // },
                              type: TextInputType.visiblePassword,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              label: 'PASSWORD',
                              prefix: Icons.lock_outline_sharp,
                              suffix: RegisterCubit.get(context).suffix,
                              onSubmit: (value){},
                              isPassword: RegisterCubit.get(context).isPassword,
                              suffixPressed: (){
                                RegisterCubit.get(context).changePasswordVisibility();
                              },

                            ),
                          ),
                          new FlutterPwValidator(
                              controller: passwordController,
                              minLength: 6,
                              uppercaseCharCount: 1,
                              specialCharCount: 1,
                              width: 400,
                              height: 90,
                              onSuccess: (){},
                              onFail: (){}
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 60,
                            child: defaultFormField(
                              type:TextInputType.visiblePassword,
                              controller: confirmedPassController,
                              // focusNode: RegisterCubit.get(context).confpasswordFocus,
                              // onTap: (){
                              //   setState(() {
                              //     FocusScope.of(context).unfocus();
                              //     FocusScope.of(context).requestFocus(confPasswordFocus);
                              //   });
                              // },
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              label: 'CONFIRM PASSWORD',
                              prefix: Icons.lock_outline_sharp,
                              suffix: RegisterCubit.get(context).suffix,
                              onSubmit: (value){},
                              isPassword: RegisterCubit.get(context).isPassword,
                              suffixPressed: (){
                                RegisterCubit.get(context).changePasswordVisibility();
                              },
                            ),
                          ),
                          new FlutterPwValidator(
                              controller: confirmedPassController,
                              minLength: 6,
                              uppercaseCharCount: 1,
                              specialCharCount: 1,
                              width: 400,
                              height: 90,
                              onSuccess: (){},
                              onFail: (){}
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: RegisterCubit.get(context).checkBoxValue,
                                onChanged: (bool? value) {
                                  RegisterCubit.get(context).ChangeCheckBox();
                                },
                                activeColor: Color(0xff54ccf5),
                              ),
                              Text(
                                'I agree to the terms and conditions',
                                overflow: TextOverflow.fade,
                                softWrap: true,
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w300,
                                  fontSize:14,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                              condition: state is! RegisterLoadingState,
                              builder: (context) => defaultButton(
                                  150.0, 50.0, 'SIGNUP', true,(){
                                if(formKey.currentState?.validate()==null)
                                {
                                  RegisterCubit.get(context).DentistRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => HomeScreen(),
                                //   ),
                                // );
                              }
                              )),
                  // defaultButton(150.0, 50.0, 'SIGNUP',true, (){
                          //   if(formKey.currentState!.validate()){
                          //     RegisterCubit.get(context).DentistRegister(name: nameController.text,
                          //         email: emailController.text, password: passwordController.text);
                          //   }
                          //
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => HomeScreen(),
                          //     ),
                          //   );
                          // }

          ],
                      ),
                    ),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
            ),
          );
        },
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