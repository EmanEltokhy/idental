import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idental/model/DentistModel.dart';
import 'package:idental/modules/signup/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitalState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void DentistRegister({

    required String name,
    required String email,
    required String password,
    // required String phone,
    // required String socialnumber,
    // required String medicalID,

  }) {


    emit(RegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {

          print(value.user?.email);
          print(value.user?.uid);
          emit(RegisterSucessState());
      DentistCreate(
        uId: value.user!.uid,
        // medicalID: value.user!.uid,
        name: name,
        email: email,
        // phone: phone,

        // socialnumber:socialnumber,

      );
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void DentistCreate({
    required String name,
    required String email,
    // required String phone,
     required String uId,

    // required String socialnumber,
    // required String medicalID,
  }) {
    DentistModel model = DentistModel(
      name: name,
      email: email,
      // phone: phone,
      uId :uId,

      // socialnumber:socialnumber,
      // medicalID: medicalID,
        );

    FirebaseFirestore.instance
        .collection('Dentists')
        .doc(uId)
        .set(model.toMap())
        .then((value)
    {
      emit(CreateDentistSucessState());
    })
        .catchError((error) {
      print(error.toString());
    emit(CreateDentistErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined ;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = (isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined) ;

    emit(ChangePasswordVisibilityState());
  }
 //  FocusNode? passwordFocus;
 //  void onFocus(context){
 //  FocusScope.of(context).unfocus();
 //  FocusScope.of(context as BuildContext).requestFocus(passwordFocus);
 //  emit(FocusOnPasswordState());
 //
 //  }
 //  FocusNode? confpasswordFocus;
 // void onFocusConf(context){
 //  FocusScope.of(context).unfocus();
 //  FocusScope.of(context).requestFocus(confpasswordFocus);
 //  }
  bool checkBoxValue = false;
  void ChangeCheckBox(){
  if (checkBoxValue == true) {
  checkBoxValue = false;
  } else {
  checkBoxValue = true;
  }
  emit(ChangeCheckBoxState());
  }


}