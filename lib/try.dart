import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idental/shared/cubits/cubits.dart';
import 'package:idental/shared/cubits/states.dart';


class ScheduleCard extends StatelessWidget {

  const ScheduleCard({required this.date, required this.day, required this.time});
  final String date;
  final String day;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            // color: Config.primaryColor,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '$day, $date',
            style: const TextStyle(
              // color: Config.primaryColor,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.access_alarm,
            // color: Config.primaryColor,
            size: 17,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
              child: Text(
                time,
                style: const TextStyle(
                  // color: Config.primaryColor,
                ),
              ))
        ],
      ),
    );
  }
}

class try2 extends StatelessWidget {
  // const try2({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(create: (BuildContext context) => AppCubit()..getPendingAppointments(),
      child: BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context, state)
          { if(state is GetAppointmentsSuccessState){
            return Scaffold(
              backgroundColor: Colors.white,
              body:
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // SizedBox(height: 20,),
                      // Text('Upcoming Appointments',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      // SizedBox(height: 40,),
                      ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        itemCount: state.Appointments.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(indent: 3),
                        itemBuilder: (BuildContext context, int index) => Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: true ? const EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                      NetworkImage(
                                          'https://th.bing.com/th/id/OIP.i2z-rKyDkWNqHIDo_-PJ8AHaEr?pid=ImgDet&rs=1'
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${state.Appointments[index]['patientemail']}',
                                          style: const TextStyle(
                                            color: Colors.teal,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ScheduleCard(
                                  date: '${state.Appointments[index]['date']}',
                                  day: '${state.Appointments[index]['day']}',
                                  time: '${state.Appointments[index]['time']}',
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                // doctor part
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          AppCubit.get(context).ApprovedAppointment(state.Appointments[index]['docId']);
                                        },
                                        child: const Text(
                                          'Approve',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          // backgroundColor: Config.primaryColor,
                                        ),
                                        onPressed: () {
                                          print("befor cubit");
                                          AppCubit.get(context).declinedAppointment(state.Appointments[index]['docId']);
                                        },
                                        child: const Text(
                                          'Decline',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            );
          }
          else{
            return Center(  child: CircularProgressIndicator(),);
          }

          }
      ),
    );

  }
}

