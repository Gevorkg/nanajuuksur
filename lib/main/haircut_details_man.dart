import 'package:flutter/material.dart';
import 'package:flutter_ark_test/Theme/app_colors.dart';
import 'package:flutter_ark_test/main/hairdresser_screen.dart';
import 'package:flutter_ark_test/main/haircut_man.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HaircutDetails extends StatelessWidget {
  final Haircut haircut;

  const HaircutDetails({Key? key, required this.haircut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juuste lõikuse kirjeldus', style: GoogleFonts.roboto(color: AppColors.tekst, fontSize: 20),),
      ),
      body: Stack(
        children: [Positioned.fill(
            child: Lottie.asset(
              'assets/background7.json',
              fit: BoxFit.cover, 
            ),
          ), Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      width: 450,
                      height: 300,
                      margin: EdgeInsets.only(left: 0), 
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: haircut.cutImage.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      haircut.cutName,
                      style: GoogleFonts.roboto(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Hind: ${haircut.price}',
                      style: GoogleFonts.roboto(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      haircut.description,
                      style: GoogleFonts.roboto(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20), 
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
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
                  child: Text('Broneeri aeg', style: GoogleFonts.roboto(color: AppColors.tekst, fontSize: 21.5),),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HairDresserScreen()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        ],
      ),
    );
  }
}
