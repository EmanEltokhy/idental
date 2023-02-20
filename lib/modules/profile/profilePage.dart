import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:idental/shared/components/components.dart';
import 'package:idental/shared/cubits/cubits.dart';
import 'package:idental/shared/cubits/states.dart';
class profileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    bool showPassword = false;
    bool edit = true;
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var clinic_nameController = TextEditingController();
    var clinic_addController = TextEditingController();

    return BlocProvider(
        create:(BuildContext context) => AppCubit()..getUserData(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state){},
          builder: (context,state) {


            Size size = MediaQuery.of(context).size;
            if(state is GetDentistDataSuccessState){
              var model = state.dentist;
              // String? profle_image = model.profileimage;
              nameController.text= model.name!;
              phoneController.text = model.phone!;
              clinic_nameController.text = model.clinicname!;
              clinic_addController.text = model.clinicaddress!;
              return Scaffold(
                // appBar: AppBar(
                //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                //   elevation: 1,
                //   leading: IconButton(
                //     icon: Icon(
                //       Icons.arrow_back,
                //       color: Colors.green,
                //     ),
                //     onPressed: () {},
                //   ),
                //   actions: [
                //     IconButton(
                //       icon: Icon(
                //         Icons.settings,
                //         color: Colors.green,
                //       ),
                //       onPressed: () {
                //         // Navigator.of(context).push(MaterialPageRoute(
                //         //     builder: (BuildContext context) => SettingsPage()));
                //       },
                //     ),
                //   ],
                // ),
                body: Container(
                  padding: EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      Row(

                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  "Edit Profile",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 25),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                  child: Text("Edit",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        color: Colors.teal,)),
                                  onPressed: () {

                                    AppCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone:phoneController.text,
                                      clinic_name:clinic_nameController.text,
                                      clinic_address: clinic_addController.text,
                                    ); }
                              ),
                            )
                          ]
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              // decoration: BoxDecoration(
                              //     border: Border.all(
                              //         width: 4,
                              //         // color: Theme.of(context).scaffoldBackgroundColor),
                              //         color: Color(0xFD4D4D5FA)),
                              //     boxShadow: [
                              //       BoxShadow(
                              //           spreadRadius: 2,
                              //           blurRadius: 10,
                              //           color: Colors.black.withOpacity(0.1),
                              //           offset: Offset(0, 10)
                              //       )
                              //     ],
                              //     shape: BoxShape.circle,
                              //     image: DecorationImage(
                              //         fit: BoxFit.cover,
                              //         image: NetworkImage(
                              //           '${state.dentist.profileimage}'
                              //    )
                              //     )
                              // ),
                         child: CircleAvatar(
                            radius: 64.0,
                            backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                            child: state.dentist.profileimage!.startsWith('https')?CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage(state.dentist.profileimage!)

                            ):CircleAvatar(
                          radius: 60.0,
                          backgroundImage:  FileImage(File(state.dentist.profileimage!))

              ),
                            ),

                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 3,
                                      color: Theme
                                          .of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child:
                                  IconButton(
                                    icon: Icon(Icons.camera_alt_outlined),
                                    color: Colors.teal,
                                    onPressed: (){
                                      AppCubit.get(context).getProfileImage();
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      defaultFormField(
                        // controller:TextEditingController(text: state.dentist.name),
                        controller: nameController,
                        //intialvalue:EditProfileCubit.get(context).model.name,
                        type: TextInputType.name,
                        label: 'NAME',
                        prefix: Icons.person,
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      defaultFormField(
                        // controller:TextEditingController(text: state.dentist.phone),
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: 'PHONE',
                        prefix: Icons.phone_android,
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      defaultFormField(
                        // controller:TextEditingController(text: state.dentist.clinicname),
                        controller: clinic_nameController,
                        type: TextInputType.text,
                        label: 'CLINIC',
                        prefix: Icons.home,
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      defaultFormField(
                        // controller:TextEditingController(text: state.dentist.clinicaddress),
                        controller: clinic_addController,
                        type: TextInputType.text,
                        label: 'ADDRESS',
                        prefix: Icons.location_on,
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      // buildTextField(
                      //     "Full Name", "Eman El-Sayed Abd El-Aziz", false),
                      // buildTextField("User Name", "emaneltokhy", false),
                      // buildTextField("E-mail", "emaneltokhy@gmail.com", false),
                      // buildTextField("Password", "***", true),
                      // buildTextField("Country", "Egypt", false),
                      SizedBox(
                        height: 35,
                      ),
                      defaultButton(size.width, 50.0, "Logout", false, () {
                        print(nameController.text);
                      })
                    ],
                  ),
                ),
              );
            }
            else if(state is GetDentistDataLoadingState){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(state is GetDentistDataErrorState ){
              return Center(
                child: Text(state.error),
              );
            }
            else if (state is UpdateDentistDataErrorState){
              return Center(
                child: Text(state.error),
              );
            }
            else{
              return SizedBox();
            }

          },
        )
    );
  }
}