import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ark_test/Theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ark_test/main/hairdresser_screen.dart';
import 'package:lottie/lottie.dart';

class BookingScreen extends StatefulWidget {
  final HairDresser hairdresser;

  const BookingScreen({Key? key, required this.hairdresser}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String _selectedDateText = 'Valige kuupäev';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;
  late Stream<List<String>> _timesStream;

  @override
  void initState() {
    super.initState();
    _fetchAvailableTimes(_selectedDate);
  }

  void _fetchAvailableTimes(DateTime selectedDate) {
    String formattedDate = _formattedDate(selectedDate);
    _timesStream = FirebaseFirestore.instance
        .collection('hairdressers')
        .doc(widget.hairdresser.DresserName)
        .collection('dates')
        .doc(formattedDate)
        .snapshots()
        .map((doc) => List<String>.from(doc['times'] ?? []));
  }

  String _formattedDate(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date);
  }

  Future<void> _registerAppointment(String date, String time) async {
  final user = _auth.currentUser;
  if (user != null) {
    final userUid = user.uid;

    
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(userUid).get();
    if (userDoc.exists) {
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Viga'),
          content: Text('Te olete juba registreeritud vastuvõtule.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    
    final userData = {
      'date': date,
      'time': time,
      'dresser': widget.hairdresser.DresserName,
    };
    try {
      await FirebaseFirestore.instance.collection('users').doc(userUid).set(userData);

      await FirebaseFirestore.instance.collection('hairdressers').doc(widget.hairdresser.DresserName).collection('dates').doc(date).update({
        'times': FieldValue.arrayRemove([time]),
      });

      await FirebaseFirestore.instance.collection('bookings').doc(widget.hairdresser.DresserName).update({
        'date_time': FieldValue.arrayUnion([date + ' ' + time]),
      });

      setState(() {
        _selectedTime = null;
      });
      Navigator.pushReplacementNamed(context, '/success');
    } catch (error) {
      print("Error registering appointment: $error");
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tekst,
      appBar: AppBar(
        title: Text('Broneerimine', style: GoogleFonts.roboto(color: AppColors.tekst, fontSize: 20),),
      ),
      body: Stack(
        children: [Positioned.fill(
            child: Lottie.asset(
              'assets/background7.json',
              fit: BoxFit.cover, 
            ),
          ),  Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 2, 
            ),
            ),
          child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
                    child: Image.asset(
                      widget.hairdresser.image,
                      height: 160, 
                      width: 140, 
                      fit: BoxFit.cover, 
                    ),
                  ),
        
                  SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.hairdresser.DresserName,
              style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Staaž: ${widget.hairdresser.DresserExp}',
              style: GoogleFonts.roboto(fontSize: 20),
            ),
            SizedBox(height: 10),
            Row(
              children: widget.hairdresser.DresserWorkAge.map((icon) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: icon,
              )).toList(),
            ),
          ],
        ),
            ],
          ),
        ),
              SizedBox(height: 20),
               TextButton(
                style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), 
                      ),
                    ),
                      overlayColor: MaterialStateProperty.all(AppColors.serij),
                      backgroundColor: MaterialStateProperty.all(AppColors.knopka),
                      foregroundColor: MaterialStateProperty.all(AppColors.tekst),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                      ),
                    ),
          onPressed: () {
            _showDateTimePicker(context);
          },
          child: Text(_selectedDateText, ),
        ),
              SizedBox(height: 20),
              StreamBuilder<List<String>>(
                stream: _timesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('Vabandust, kuid praegu pole saadaval aega', style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),);
                  } else {
                    if (_selectedTime == null && snapshot.data!.isNotEmpty) {
                      _selectedTime = snapshot.data!.first;
                    }
                    return Column(
                      children: [
                        Text(
                          'Valige aeg',
                          style: GoogleFonts.roboto(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final time = snapshot.data![index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedTime = time;
                                });
                              },
                              child: Card(
                                elevation: 2,
                                color: _selectedTime == time ? AppColors.knopka : AppColors.tekst,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text(time, style: TextStyle(color: Colors.black, ),)),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                         TextButton(
                style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), 
                      ),
                    ),
                      overlayColor: MaterialStateProperty.all(AppColors.tekst),
                      backgroundColor: MaterialStateProperty.all(AppColors.knopka),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      textStyle: MaterialStateProperty.all(
                        GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                          onPressed: () {
                            if (_selectedTime != null) {
                              _registerAppointment(
                                _formattedDate(_selectedDate),
                                _selectedTime!,
                              );
                            } else {
                              
                            }
                          },
                          child: Text('Kinnitage broneering', style: GoogleFonts.roboto(fontSize: 20),),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
        ],
      ),
    );
  }

  void _showDateTimePicker(BuildContext context) {
  showDatePicker(
    context: context,
    initialDate: _selectedDate,
    firstDate: DateTime.now().subtract(Duration(days: 1)),
    lastDate: DateTime.now().add(Duration(days: 14)),
  ).then((selectedDate) {
    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
        _selectedDateText = DateFormat('dd.MM.yyyy, EEEE').format(selectedDate);
      });
      _fetchAvailableTimes(selectedDate);
      _selectedTime = null;
    }
  });
}
}