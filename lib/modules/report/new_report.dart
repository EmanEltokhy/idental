import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idental/history.dart';
import 'package:idental/shared/components/components.dart';

import '../../shared/cubits/cubits.dart';
import '../../shared/cubits/states.dart';

class NewReport extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var observationController = TextEditingController();
    var patientnameController = TextEditingController();
  return BlocProvider(create:(BuildContext context) => AppCubit()..getUserData(),
    child: BlocConsumer<AppCubit,AppStates>(

      listener: (context,state){},
      builder: (context,state){

        return Scaffold(

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
                            "New Report",
                            style: GoogleFonts.montserrat(
                                fontSize: 22),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                            child: Text("Create",
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  color: Colors.teal,)),
                            onPressed: () {

                              AppCubit.get(context).CreateReport(

                                  // dentistname:AppCubit().model.name,
                                  // profileimage:AppCubit().model.profileimage,
                                  // uId: AppCubit().model.uId,
                                  patientname: patientnameController.text,
                                  observation: observationController.text);
                              if(state is CreateReportSuccessState){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HistoryScreen(),
                                  ),
                                );
                              }
                            }
                        ),
                      )
                    ]
                ),
                SizedBox(
                  height: 30,
                ),

                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage:
                    NetworkImage('${AppCubit.get(context).model.profileimage}'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                       '${AppCubit.get(context).model.name}',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),

                defaultFormField(
                  controller: patientnameController,
                  type: TextInputType.text,
                  label: "Patient Name",
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(child:
                TextFormField(
                  controller: observationController,
                  decoration: InputDecoration(
                    labelStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                    hintText: 'Please Write Your Observations.',
                    border: InputBorder.none,
                  ),
                ),),
              ],
            ),

          ),

        );
      },
    ),

  );

  }
}