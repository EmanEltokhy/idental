import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idental/model/DentistModel.dart';
import 'package:idental/model/ReportModel.dart';
import 'package:idental/shared/cubits/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../history.dart';
import '../../modules/profile/profilePage.dart';
import '../../screens/appointment_screen.dart';
import '../../upload.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() :super(AppInitalState());

  static AppCubit get(context) => BlocProvider.of(context);

  // int _selectedScreenIndex = 0;
  //
  // List<Widget> _screens =
  // [
  //   UploadScreen(),
  //   AppointmentScreen(),
  //   HistoryScreen(),
  //   profileScreen(),
  // ];
  // List<String> titles =
  // [
  //   'Upload',
  //   'Appointment',
  //   'History',
  //   'Profile',
  // ];
  // void changeIndex(int index)
  // {
  //   _selectedScreenIndex = index;
  //   emit(AppChangeBottomNavBar());
  // }

  DentistModel model = DentistModel();

  // uId: value.user!.uid;
  void getUserData() {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    List<QueryDocumentSnapshot<Map<String, dynamic>>> data = [];
    emit(GetDentistDataLoadingState());

    FirebaseFirestore.instance.collection('Dentists')
        .where('uId', isEqualTo: userid).
    get()
        .then((value) {
      print(value.docs.first.data());
      data = value.docs;
      if (data.isEmpty ) {
        emit(GetDentistDataErrorState('User Not Found'));
      }
      else {
        model = DentistModel.fromdoc(data.first);
        if(model !=null){
          emit(GetDentistDataSuccessState(dentist: model));
        }else{
          emit(GetDentistDataErrorState('User Not Found'));
        }


      }
    })
    //  model = DentistModel.fromjson(value.data());
    //  emit(GetDentistDataSuccessState());
    //  })
        .catchError((error) {
      emit(GetDentistDataErrorState(error.toString()));
    }
    );
  }

  late File profileimage;
  var picker = ImagePicker();
  Future<void> getProfileImage()async{
    emit(GetDentistDataLoadingState());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      profileimage = File(pickedFile.path);

      print(profileimage.path);
      model=model.copyWith(profileimage: profileimage.path);
      print(model.profileimage);
      emit(GetDentistDataSuccessState(dentist: model));

    }
    else{

      emit(GetDentistDataSuccessState(dentist: model));

    }

  }

  Future<void> uploadProfileImage({
    required String name,
    required String phone,
    required String clinic_name,
    required String clinic_address,


}) async {
  if(profileimage!=null){
    // upload image only if there is file
    emit(UpdateDentistDataLoadingState());

    // FirebaseStorage.instance
    //     .ref().child('Dentists/${Uri.file(profileimage.path).pathSegments.last}')
    //     .putFile(profileimage!).then((value){
    //       print('upload result ${value.ref.fullPath}');
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('profileimages');
    Reference referenceImageToUpload =referenceDirImages.child(uniqueFileName);
    try{
    await referenceImageToUpload.putFile(File(profileimage.path));
     String url = await referenceImageToUpload.getDownloadURL();
    editData(name: name,
            phone: phone,
            clinic_name: clinic_name,
            clinic_address: clinic_address,
            profile_image: url,);

        }
    catch (error){

    }
      // value.ref.getDownloadURL().then((value) {
      //   print(value);
      //   editData(name: name,
      //     phone: phone,
      //     clinic_name: clinic_name,
      //     clinic_address: clinic_address,
      //     profile_image: value,);
      // }
      // ).catchError((error){
      //   emit(UpdateDentistDataErrorState(error.toString()));
      // });

    // // ).catchError((error){
    // //   emit(UpdateDentistDataErrorState(error.toString()));
    // });
  }else{
    emit(UpdateDentistDataLoadingState());
    editData(name: name,
      phone: phone,
      clinic_name: clinic_name,
      clinic_address: clinic_address,
      );
  }

}


  void editData({
    required String name,
    required String phone,
    required String clinic_name,
    required String clinic_address,
    String? profile_image,

  }){

    DentistModel dentist = DentistModel(
      name: name,
      phone: phone,
      clinicname: clinic_name,
      clinicaddress: clinic_address,
      profileimage: profile_image,
      email: model.email,
      medicalID: model.medicalID,
      socialnumber: model.socialnumber,
      uId: model.uId,
      docid: model.docid,
    );
    FirebaseFirestore.instance.collection('Dentists')
        .doc(model.docid).update(dentist.toMap()).then((value) {
      getUserData();
    }).catchError((error){
      emit(UpdateDentistDataErrorState(error.toString()));
    });
  }
ReportModel rr =ReportModel();

  void CreateReport({
     String? dentistname,
   String? profileimage,
    String? uId,
    required String patientname,
    // required String  datetime,
    required String observation,

  }){

    emit(CreateReportLoadingState());
    
    ReportModel report_model = ReportModel(
      dentistname:dentistname??model.name,
      profileimage: profileimage??model.profileimage,
      uId:uId?? model.uId,
      patientname: patientname,
      docid: rr.docid,
      // datatime: datetime,
      observation: observation,
    );

    FirebaseFirestore.instance
    .collection('Reports')
        .add(report_model.toMap())
    .then((value) {
      print(value);
      emit(CreateReportSuccessState(report: report_model,
     ));
    }).catchError((error){
      emit(CreateReportErrorState(error.toString()));
    });


  }



//   void getReports() {

//     FirebaseFirestore.instance.collection('Reports').where('uId', isEqualTo: userid)
//         .get().then((value) {
// value.docs.forEach((element) {
//   reports.add(ReportModel.fromdoc(element.data()));
//   print(reports);
// });
//    emit(GetReportSuccessState()); }).catchError((error){
//      emit(GetReportErrorState(error.toString()));
//     });
//   }



//   CollectionReference _collectionRef =
//   FirebaseFirestore.instance.collection('Reports');
//
//   Future<void> getReports() async {
//     List<ReportModel> reports =[];
//     // Get docs from collection reference
//     final userid = FirebaseAuth.instance.currentUser!.uid;
//     QuerySnapshot querySnapshot = await _collectionRef.where('uId', isEqualTo: userid).get();
//
//     // Get data from docs and convert map to List
//     final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
//     //
//     // final allData = querySnapshot.docs.
//   print(allData.length);
//
//
//   }
//--------------------------------------------------------------

  void getReports(){
    List<Map<String, dynamic>> Allreports= [];
        final userid = FirebaseAuth.instance.currentUser!.uid;
    var collection = FirebaseFirestore.instance.collection('Reports');
    collection.where('uId', isEqualTo:userid ).snapshots().listen((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Allreports.add(doc.data());

      }

        emit(GetReportSuccessState(Allreports));

    });
  }

}