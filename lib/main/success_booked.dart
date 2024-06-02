import 'package:flutter/material.dart';
import 'package:flutter_ark_test/Theme/app_colors.dart';
import 'package:lottie/lottie.dart';

class AppointmentBooked extends StatelessWidget {
  const AppointmentBooked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Lottie.asset('assets/success1.json'),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Broneering õnnestus',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: TextButton(
              style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), 
                    ),
                  ),
                    overlayColor: MaterialStateProperty.all(AppColors.tekst),
                    backgroundColor: MaterialStateProperty.all(AppColors.knopka),
                    foregroundColor: MaterialStateProperty.all(AppColors.tekst),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
              child: Text('Tagasi koju', style: TextStyle(color: AppColors.tekst, fontSize: 21.5),),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/main_screen', (route) => false),

              ),
            )
          ],
        ),
      ),
    );
  }
}