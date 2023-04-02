import 'dart:async';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'classifier/classifier.dart';


String _labelsFileName = '';
String _modelFileName = '';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreen createState() => _UploadScreen();
  const UploadScreen({required this.index});
  final int index;
}
enum _ResultStatus {
  notStarted,
  notFound,
  found,
}

class _UploadScreen extends State<UploadScreen> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(index: widget.index,),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
  const Home({required this.index});
  final int index;
}

class _HomeState extends State<Home> {
  bool _isAnalyzing = false;
  final picker = ImagePicker();
  File? _selectedImageFile;
  bool isImageSelected = false;
  String title = '';

  // Result
  _ResultStatus _resultStatus = _ResultStatus.notStarted;
  String Label = ''; // Name of Error Message
  double _accuracy = 0.0;

  late Classifier _classifier;

  void initState() {
    super.initState();
    _loadClassifier(widget.index);
  }

  Future<void> _loadClassifier(index) async {
    if(index == 0)
    {
    _modelFileName = 'Periodontal2.tflite';
    _labelsFileName = 'assets/perio_labels.txt';
    title = 'Periodontal Diagnosis';
    }
    else if(index == 1)
    {
      _modelFileName = 'newModel1.tflite';
      _labelsFileName = 'assets/labels.txt';
      title = 'Oral Diagnosis';
    }

    debugPrint(
      'Start loading of Classifier with '
          'labels at $_labelsFileName, '
          'model at $_modelFileName',
    );

    final classifier = await Classifier.loadWith(
      labelsFileName: _labelsFileName,
      modelFileName: _modelFileName,
    );
    _classifier = classifier!;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text('$title',style: GoogleFonts.parisienne(
                fontSize: 35,
              ),
            ),
            ),
            Expanded(
                child:isImageSelected
                    ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image(
                        image: FileImage(_selectedImageFile!),
                      ),
                    )
                    : Container(),
              flex: 3,
            ),

            _buildAnalyzingText(),
            Expanded(child: _buildResultView(),flex: 1,),
            // SizedBox(height: 70,),
            _buildPickPhotoButton(
              title: 'Take a photo',
              source: ImageSource.camera,
              size: size,
            ),
            SizedBox(height: 5,),
            _buildPickPhotoButton(
              title: 'Pick from gallery',
              source: ImageSource.gallery,
              size: size,
            ),
            // TextButton(
            //   onPressed: ()async{await getImage();},
            //   child: Container(
            //     width: size.width-10,
            //     height: 50,
            //     alignment: AlignmentDirectional.centerEnd,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(30),
            //         gradient: LinearGradient(colors: [
            //           Colors.teal,
            //           Color(0xFF80CBC4),
            //         ])),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Icon(Icons.cloud_upload,color: Colors.white,),
            //         SizedBox(width: 20,),
            //         Text("Upload from Gallery",
            //             style: GoogleFonts.montserrat(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.w500)),
            //
            //
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
  Widget _buildAnalyzingText() {
    if (!_isAnalyzing) {
      return const SizedBox.shrink();
    }
    return const Text('Analyzing...', style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400));
  }
  void _setAnalyzing(bool flag) {
    setState(() {
      _isAnalyzing = flag;
    });
  }

  // Future getImage() async {
  //   try {
  //     final pickedImage = await image.pickImage(source: source);
  //
  //     if (pickedImage != null) {
  //       setState(() {
  //         imageFile = File(pickedImage.path);
  //         isImageSelected = true;
  //         print('11${isImageSelected} file ${imageFile}');
  //       });
  //     } else {
  //       print('User didnt pick any image.');
  //     }
  //     _analyzeImage(pickedImage);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //
  //   // var img = await image.pickImage(source: ImageSource.gallery);
  //   // img.path;
  // }
  // getImagefromCamera() async {
  //   try {
  //     final pickedImage =
  //     await ImagePicker().pickImage(source: ImageSource.camera);
  //     if (pickedImage != null) {
  //       setState(() {
  //         imageFile = File(pickedImage.path);
  //         isImageSelected = true;
  //       });
  //     } else {
  //       print('User didnt pick any image.');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  Widget _buildPickPhotoButton({
    required ImageSource source,
    required String title,
    required Size size,
  }) {
    return TextButton(
      onPressed: () => _onPickPhoto(source),
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
            Text("$title",
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),


          ],
        ),
      ),
    );
  }
  void _onPickPhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      return;
    }

    final imageFile = File(pickedFile.path);
    setState(() {
      _selectedImageFile = imageFile;
      isImageSelected = true;
    });

    _analyzeImage(imageFile);
  }
  Widget _buildResultView() {
    var title = '';

    if (_resultStatus == _ResultStatus.notFound) {
      title = 'Fail to recognise';
    } else if (_resultStatus == _ResultStatus.found) {
      title = Label;
    } else {
      title = '';
    }

    //
    var accuracyLabel = '';
    if (_resultStatus == _ResultStatus.found) {
      accuracyLabel = 'Accuracy: ${(_accuracy * 100).toStringAsFixed(1)}%';
    }

    return Column(

      children: [
        Text(title, style:GoogleFonts.montserrat(
            // fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
        )),
        const SizedBox(height: 10),
        Text(accuracyLabel,style:GoogleFonts.montserrat(
          // fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
        ))
      ],
    );
  }
  void _analyzeImage(File image) {
    _setAnalyzing(true);

    final imageInput = img.decodeImage(image.readAsBytesSync())!;

    final resultCategory = _classifier.predict(imageInput);

    final result = resultCategory.score >= 0.8
        ? _ResultStatus.found
        : _ResultStatus.notFound;
    final plantLabel = resultCategory.label;
    final accuracy = resultCategory.score;

    _setAnalyzing(false);

    setState(() {
      _resultStatus = result;
      Label = plantLabel;
      _accuracy = accuracy;
    });
  }

}