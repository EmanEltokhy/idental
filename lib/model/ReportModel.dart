import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String? dentistname;
  final String? uId;
  final String? docid;
  final String? profileimage;
  final String? patientemail;
  final String? observation;
  // final String? datatime;


 ReportModel({
   this.dentistname,
   this.uId,
   this.docid,
   this.profileimage,
   this.patientemail,
   this.observation,
   // this.datatime
  });

  factory ReportModel.fromdoc(QueryDocumentSnapshot<Map<String, dynamic>> doc){

    final report =ReportModel(
      dentistname :doc.data()!['dentistname'],
      uId :doc.data()!['uId'],
      docid :doc.id,
      profileimage: doc.data()!['profileimage'],
      patientemail: doc.data()!['patientemail'],
      observation: doc.data()!['observation'],
      // datatime: doc.data()!['datatime'],
    );
    return report;
  }

  Map<String, dynamic> toMap() {
    return {

      'dentistname': dentistname??'',
      'uId': uId??'',
      'docid':docid,
      'profileimage': profileimage??'',
      'patientemail' : patientemail??'',
      'observation' : observation??'',
      // 'datatime' : datatime,


    };
  }
}