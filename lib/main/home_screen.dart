import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ark_test/Theme/app_colors.dart';
import 'package:flutter_ark_test/widgets/gallery_widget.dart';
import 'package:flutter_ark_test/widgets/geo_nana_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HouseScreen extends StatefulWidget {
  @override
  _HouseScreenState createState() => _HouseScreenState();
}

class _HouseScreenState extends State<HouseScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String selectedDate = '';
  late String selectedTime = '';
  bool appointmentExists = false;

  @override
  void initState() {
    super.initState();
    _fetchAppointmentInfo();
  }

  Future<void> _fetchAppointmentInfo() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userUid = user.uid;
      final userDoc = FirebaseFirestore.instance.collection('users').doc(userUid);
      final userData = await userDoc.get();
      if (userData.exists) {
        setState(() {
          selectedDate = userData['date'];
          selectedTime = userData['time'];
          appointmentExists = true;
        });
      }
    }
  }

  Future<void> _cancelAppointment() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userUid = user.uid;
      final userDoc = FirebaseFirestore.instance.collection('users').doc(userUid);
      final userData = await userDoc.get();
      if (userData.exists) {
        var selectedDate = userData['date'];
        var selectedTime = userData['time'];
        final dresser = userData['dresser'];

        await userDoc.delete();

        final dresserDoc = FirebaseFirestore.instance.collection('hairdressers').doc(dresser).collection('dates').doc(selectedDate);
        await dresserDoc.update({'times': FieldValue.arrayUnion([selectedTime])});

        setState(() {
          selectedDate = '';
          selectedTime = '';
          appointmentExists = false;
        });
      }
    }
  }

  Future<void> _logoutUser() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tekst,
      appBar: AppBar(
        title: null,
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Lottie.asset(
              'assets/background7.json',
              fit: BoxFit.cover, 
              
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.photo, size: 20,),
                          SizedBox(width: 2,),
                          Text('Galerii', style: GoogleFonts.roboto(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.only(left: 225),
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size(0, 0), 
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ), 
                              child: Text('Vaata kõik', style: TextStyle(fontSize: 14, color: AppColors.knopka, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: AppColors.knopka)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  ImageSwiper(),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.app_registration, size: 20,),
                          SizedBox(width: 2,),
                          Text('Broneering', style: GoogleFonts.roboto(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.only(left: 185),
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size(0, 0), 
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ), 
                              child: Text('Vaata kõik', style: TextStyle(fontSize: 14, color: AppColors.knopka, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: AppColors.knopka)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                    child: Container(
                      decoration: BoxDecoration(color: AppColors.mainDartBlue.withOpacity(0.92), borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 15,),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.knopka2,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today, color: AppColors.tekst),
                                  SizedBox(width: 10),
                                  Text('Kuupäev: ${appointmentExists ? selectedDate : 'pole broneeritud'}', style: GoogleFonts.roboto(color: AppColors.tekst, fontSize: 15)),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.knopka2,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Icon(Icons.access_time, color: AppColors.tekst),
                                  SizedBox(width: 10),
                                  Text('Aeg: ${appointmentExists ? selectedTime : 'pole broneeritud'}', style: GoogleFonts.roboto(color: AppColors.tekst, fontSize: 15)),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            if (appointmentExists)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Tühistada kohtumine'),
                                            content: Text('Kas soovite oma broneeringu tühistada?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Ei'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  _cancelAppointment();
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Jah'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: AppColors.tekst, backgroundColor: Colors.red.withOpacity(0.92),
                                      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text('Tühista', style: GoogleFonts.roboto(fontSize: 16, color: AppColors.tekst)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      print('Verify appointment');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: AppColors.tekst, backgroundColor: AppColors.knopka2,
                                      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text('Kinnita', style: GoogleFonts.roboto(fontSize: 16)),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 9,
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    decoration: BoxDecoration(
                      color: AppColors.knopka.withOpacity(0.35),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                    ),
                  ),
                  Container(
                    height: 9,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: AppColors.knopka.withOpacity(0.15),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Icon(Icons.place, size: 21,),
                        Text('Asukoht', style: GoogleFonts.roboto(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                        Padding(
                          padding: const EdgeInsets.only(left: 212),
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(0, 0), 
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ), 
                            child: Text('Vaata kõik', style: TextStyle(fontSize: 14, color: AppColors.knopka, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: AppColors.knopka)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: GeoNanWidget(),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                    children: [
                      Row(
                        children: [
                          Icon(Icons.phone, color: AppColors.knopka, size: 20),
                          SizedBox(width: 3), 
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                              elevation: 0,
                            ),
                            child: Text('Helista meile', style: GoogleFonts.roboto(color: AppColors.knopka, fontSize: 15)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 5),
                        child: Container(
                          height: 35,
                          width: 1.5,
                          color: Colors.grey.withOpacity(0.5),
                          margin: EdgeInsets.symmetric(horizontal: 70),
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => _logoutUser(),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                              elevation: 0,
                            ),
                            child: Text('Logi välja', style: GoogleFonts.roboto(color: AppColors.knopka, fontSize: 15)),
                          ),
                          SizedBox(width: 3), 
                          Icon(Icons.exit_to_app_sharp, color: AppColors.knopka, size: 20),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
