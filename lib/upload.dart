import 'dart:async';
import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idental/imagePreview.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreen createState() => _UploadScreen();
}

class _UploadScreen extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "upload any file",
      // theme: ThemeData(
      //   primaryColor: Colors.greenAccent[700],
      // ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isImageSelected = false;
  File? imageFile;
  ImagePicker image = ImagePicker();
  String url = "";
  var name;
  var color1 = Colors.redAccent[700];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child:isImageSelected
                    ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: FileImage(imageFile!),
                    ),
                  ),
                )
                    : Container(),
            ),

             TextButton(
               onPressed:  ()async{await getImagefromCamera();},
               child: Container(
                width: size.width-10,
                height: 50,
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
                    Icon(Icons.camera_alt,color: Colors.white,),
                    SizedBox(width: 20,),
                    Text("Take Photo",
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),


                  ],
                ),
            ),
             ),
            SizedBox(height: 5,),

            TextButton(
              onPressed: ()async{await getImage();},
              child: Container(
                width: size.width-10,
                height: 50,
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
                    Icon(Icons.cloud_upload,color: Colors.white,),
                    SizedBox(width: 20,),
                    Text("Upload from Gallery",
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),


                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            // Expanded(
            //   child: Stack(
            //     children: [
            //       Container(
            //         width: double.infinity,
            //           child: Image(image: AssetImage('images/blurred2.jpg'),fit:BoxFit.fill, )),
            //       Center(child: Icon(Icons.camera_alt,size: 150,color: Colors.white,)),
            //       Positioned(
            //         bottom: size.height/14.0,
            //         right: size.width/4.5,
            //         child: TextButton(
            //             child: Text("Take Photo",style: GoogleFonts.montserrat(
            //             fontSize: 35,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.white
            //         )
            //             ),onPressed: ()
            //            {
            //             getImagefromCamera();
            //
            //             Timer(Duration(seconds: 5), () {
            //               print('${isImageSelected} file ${imageFile}');
            //               Navigator.push(context, MaterialPageRoute(
            //                 builder: (context) => ImagePreview(isImageSelected: isImageSelected, imageFile: imageFile),
            //               ),
            //               );
            //             });
            //         },
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Expanded(
            //   child: Stack(
            //     children: [
            //       Positioned(
            //         left: size.width/4,
            //         bottom: size.height/5,
            //         child: Container(
            //           height: 190,
            //           width: 190,
            //           child: Image(
            //             image: AssetImage('images/galleryy.jpeg'),
            //           ),
            //         ),
            //       ),
            //       Positioned(
            //         bottom: size.height/7.0,
            //         right: size.width/11,
            //         child: TextButton(
            //           child: Text("Choose from Gallery",style: GoogleFonts.montserrat(
            //             fontSize: 30,
            //             fontWeight: FontWeight.bold,
            //             color: Color(0xFF39A3B8)
            //         )
            //         ),
            //           onPressed:
            //               (){
            //             getImage();
            //
            //             Timer(Duration(seconds: 1), () {
            //               print('${isImageSelected} file ${imageFile}');
            //                Navigator.push(context, MaterialPageRoute(
            //                 builder: (context) => ImagePreview(isImageSelected: isImageSelected, imageFile: imageFile),
            //               ),
            //               );
            //             });
            //
            //
            //           },
            //         ),
            //       )
            //     ],
            //   ),
            // ),

          ],
        ),
      ),
    );
  }



  Future getImage() async {
    try {
      final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
          isImageSelected = true;
          print('11${isImageSelected} file ${imageFile}');
        });
      } else {
        print('User didnt pick any image.');
      }
    } catch (e) {
      print(e.toString());
    }
    // var img = await image.pickImage(source: ImageSource.gallery);
    // img.path;
  }
  getImagefromCamera() async {
    try {
      final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
          isImageSelected = true;
        });
      } else {
        print('User didnt pick any image.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

}