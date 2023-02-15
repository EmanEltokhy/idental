import 'package:cloud_firestore/cloud_firestore.dart';

class DentistModel {
  // late String medicalID;
  final String? name;
  final String? email;
  // late String phone;

  final String? uId;
  final String? docid;
  // late String socialnumber;

  DentistModel({

    this.name,
    this.email,

    this.uId,
    this.docid,


  });

  factory DentistModel.fromdoc(QueryDocumentSnapshot<Map<String, dynamic>> doc){

    final dentist =DentistModel(
        name :doc.data()!['name'],
        email :doc.data()!['email'],
        uId :doc.data()!['uId'],
        docid :doc.id);
    return dentist;
  }

  Map<String, dynamic> toMap() {
    return {

      'name': name,
      'email': email,
      'uId': uId,
      'docid':docid,


    };
  }
}