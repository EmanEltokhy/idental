import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idental/shared/components/components.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: profileScreen(),
    );
  }
}

class profileScreen extends StatefulWidget {
  @override
  _profileScreenState createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {

  bool showPassword = false;
  bool edit = true;
  var nameController = TextEditingController();
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                      onPressed: (){
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
                      onPressed: (){
                        setState(() {
                          edit=!edit;
                        });
                      },),
                  ),
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
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            // color: Theme.of(context).scaffoldBackgroundColor),
                            color: Color(0xFD4D4D5FA)),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10)
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                            ))),
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
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.teal,
                        ),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            buildTextField("Full Name", "Eman El-Sayed Abd El-Aziz", false),
            buildTextField("User Name", "emaneltokhy", false),
            buildTextField("E-mail", "emaneltokhy@gmail.com", false),
            buildTextField("Password", "*******", true),
            buildTextField("Country", "Egypt", false),
            SizedBox(
              height: 35,
            ),
            defaultButton(size.width, 50.0, "Logout",false,(){
              print(nameController.text);
            })
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        controller: controller(labelText),
        readOnly: edit,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField?
            IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
            ): null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: GoogleFonts.montserrat(
                fontSize: 15,
                color: Colors.grey,
                fontWeight: FontWeight.bold),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
  TextEditingController? controller(String labelText)
  {
    if(labelText == "Full Name") {
      return nameController;
    }
    else if(labelText == "UserName") {
      return userNameController;
    }
    else if(labelText == "Email") {
      return emailController;
    }
    else if(labelText == "Password") {
      return passwordController;
    }
    else if(labelText == "Country") {
      return countryController;
    }
  }
}