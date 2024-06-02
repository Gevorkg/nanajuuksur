import 'package:flutter/material.dart';
import 'package:flutter_ark_test/Theme/app_colors.dart';
import 'package:flutter_ark_test/auth/auth_widget.dart';
import 'package:flutter_ark_test/auth/sign_up.dart';
import 'package:flutter_ark_test/widgets/main_screen_widget.dart';
import 'package:flutter_ark_test/main/haircut_details_man.dart';
import 'package:flutter_ark_test/main/booking_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_ark_test/main/haircut_details_woman.dart';
import 'package:flutter_ark_test/main/haircut_woman.dart';
import 'package:flutter_ark_test/main/hairdresser_screen.dart';
import 'package:flutter_ark_test/main/haircut_man.dart';
import 'package:flutter_ark_test/main/success_booked.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nanajuuksur',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.mainDartBlue,
          foregroundColor: Colors.black,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.mainDartBlue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      routes: {
        "/auth": (context) => AuthWidget(),
        '/sign_up':(context) => SignUpPage(),
        "/main_screen": (context) => MainScreenWidget(),
        '/main_screen/haircut_details': (context) {
          final haircut = ModalRoute.of(context)!.settings.arguments as Haircut;
          return HaircutDetails(haircut: haircut);
        },
        '/main_screen/haircut_details_woman': (context) {
          final haircutWoman = ModalRoute.of(context)!.settings.arguments as HaircutWoman;
          return HaircutDetailsW(haircutWoman: haircutWoman,);
        },
         '/booking_screen': (context) {
  final hairdresser = ModalRoute.of(context)!.settings.arguments as HairDresser;
  return BookingScreen(hairdresser: hairdresser);
},
         '/hairdresser_screen': (context) => HairDresserScreen(),
         '/success':(context) => AppointmentBooked(),
      },
      initialRoute: '/main_screen',
    );
  }
}
