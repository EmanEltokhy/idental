import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:iconly/iconly.dart';
import 'package:fluentui_icons/fluentui_icons.dart';

class HomeScreen extends StatefulWidget {
  //const HomeScreen({key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions:<Widget> [
          IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.black38,

              ),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(
              IconlyLight.chat,
              color: Colors.black,
            ),
          ),
        ],
      ),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10,
              ),
              tabs: const [
                GButton(
                  icon: Icons.history,
                  iconColor: Colors.black,
                  text: 'History',
                    ),
                GButton(
                  icon: Icons.calendar_today,
                  iconColor: Colors.black,
                  text: 'Appointment',
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
