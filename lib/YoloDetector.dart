// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// // import 'package:flutter/material.dart';
// // import 'package:tflite_flutter/tflite_flutter.dart';
//
// class YoloDetector extends StatefulWidget {
//   final File imageFile;
//
//   YoloDetector({required this.imageFile});
//
//   @override
//   _YoloDetectorState createState() => _YoloDetectorState();
// }
//
// class _YoloDetectorState extends State<YoloDetector> {
//   late Interpreter _interpreter;
//   late List<List<double>> _output;
//
//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//   }
//
//   Future<void> loadModel() async {
//     _interpreter = await Interpreter.fromAsset('yolo.tflite');
//     // await _interpreter.allocateTensors();
//   }
//
//   Future<void> runModelOnImage(File imageFile) async {
//     final imageData = await imageFile.readAsBytes();
//     final inputShape = _interpreter.getInputTensor(0).shape;
//     final outputShape = _interpreter.getOutputTensor(0).shape;
//     final input = inputShape.isNotEmpty ? imageData.reshape(inputShape) : imageData;
//     final output = List.filled(outputShape[1], List.filled(outputShape[2], <double>[]));
//     await _interpreter.run(input, output);
//     setState(() => _output = output);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: runModelOnImage(widget.imageFile),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           // Display the detected objects using CustomPaint or Image widget
//           // ...
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }
