import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:iconly/iconly.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:idental/history.dart';
import 'package:idental/modules/login/login.dart';
import 'package:idental/modules/report/new_report.dart';
import 'package:idental/upload.dart';

import '../modules/profile/profilePage.dart';
import '../screens/appointment_screen.dart';

class HomeScreen extends StatefulWidget {
  //const HomeScreen({key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": UploadScreen()},
    {"screen": AppointmentScreen()},
    {"screen": NewReport()},
    {"screen": profileScreen()}
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0.0,
      //   actions:<Widget> [
      //     IconButton(
      //         onPressed: (){},
      //         icon: Icon(
      //           Icons.notifications_outlined,
      //           color: Colors.black38,
      //
      //         ),
      //     ),
      //     IconButton(
      //       onPressed: (){},
      //       icon: Icon(
      //         IconlyLight.chat,
      //         color: Colors.black,
      //       ),
      //     ),
      //   ],
      // ),
      body: _screens[_selectedScreenIndex]["screen"],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 9
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
             padding:const EdgeInsets.all(15.0),
            child: GNav(
              backgroundColor: Colors.white,
              color: Colors.teal,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.teal,
              gap: 8,
              selectedIndex: _selectedScreenIndex,
              onTabChange: _onItemTapped,
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10,
              ),
              tabs: [
                GButton(
                  icon: Icons.home,
                  iconColor: Colors.black,
                  text: 'Home',
                    ),
                GButton(
                  icon: Icons.calendar_today,
                  iconColor: Colors.black,
                  text: 'Appointment',
                ),
                GButton(
                  icon: Icons.history,
                  iconColor: Colors.black,
                  text: 'New Report',
                ),
                GButton(
                  icon: Icons.person,
                  iconColor: Colors.black,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: CircleAvatar(
//               radius: 15.0,
//               backgroundColor: Colors.teal,
//               child: Icon(
//                 Icons.notification_add_outlined,
//                 size: 16.0,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: CircleAvatar(
//               radius: 15.0,
//               backgroundColor: Colors.teal,
//               child: Icon(
//                 Icons.chat_rounded,
//                 size: 16.0,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Container(),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.teal,
//         items: [
//           BottomNavigationBarItem(
//               icon: Icon(Icons.history),
//               label: 'History',
//               backgroundColor: Colors.white),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.calendar_month_outlined),
//               label: 'Appointments',
//               backgroundColor: Colors.white),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: 'Profile',
//               backgroundColor: Colors.white),
//         ],
//       ),
//     );
//   }
// }
