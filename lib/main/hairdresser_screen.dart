import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ark_test/Theme/app_colors.dart';
import 'package:flutter_ark_test/main/booking_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HairDresser {
  final int DresserId;
  final String DresserName;
  final String DresserExp;
  final List<Icon> DresserWorkAge;
  final String image; 

  HairDresser({
    required this.DresserId,
    required this.DresserName,
    required this.DresserExp,
    required this.DresserWorkAge,
    required this.image, 
  });
}

class HairDresserScreen extends StatelessWidget {
  final List<HairDresser> _hairdressers = [
    HairDresser(
      DresserId: 1,
      DresserName: 'Erik',
      DresserExp: '7 aastat',
      DresserWorkAge: [
        Icon(Icons.cut, color: AppColors.knopka, size: 27.5), 
        Icon(Icons.man, color: AppColors.knopka, size: 28)
      ],
      image: 'images/Erik.png', 
    ),
    HairDresser(
      DresserId: 2,
      DresserName: 'Natalja',
      DresserExp: '10 aastat',
      DresserWorkAge: [
        Icon(Icons.cut, color: AppColors.knopka, size: 27.5), 
        Icon(Icons.man, color: AppColors.knopka, size: 28)
      ],
      image: 'images/Natalja.png', 
    ),
    HairDresser(
      DresserId: 3,
      DresserName: 'Anti',
      DresserExp: '4 aastat',
      DresserWorkAge: [
        Icon(Icons.cut, color: AppColors.knopka, size: 27.5), 
        Icon(Icons.man, color: AppColors.knopka, size: 28)
      ],
      image: 'images/Ahti.png', 
    ),
     HairDresser(
      DresserId: 4,
      DresserName: 'Merelin',
      DresserExp: '4 aastat',
      DresserWorkAge: [
        Icon(Icons.cut, color: Colors.pink, size: 27.5), 
        Icon(Icons.woman, color: Colors.pink, size: 28)
      ],
      image: 'images/Merelin.png', 
    ),
     HairDresser(
      DresserId: 5,
      DresserName: 'Katriin',
      DresserExp: '7 aastat',
      DresserWorkAge: [
        Icon(Icons.cut, color: Colors.pink, size: 27.5), 
        Icon(Icons.woman, color: Colors.pink, size: 28)
      ],
      image: 'images/Katriin.png', 
    ),
     HairDresser(
      DresserId: 6,
      DresserName: 'Maria',
      DresserExp: '7 aastat',
      DresserWorkAge: [
        Icon(Icons.cut, color: Colors.pink, size: 27.5), 
        Icon(Icons.woman, color: Colors.pink, size: 28)
      ],
      image: 'images/Maria.png', 
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tekst,
      appBar: AppBar(
        title: Text('Juuksemeister valik', style: GoogleFonts.roboto(color: AppColors.tekst, fontSize: 20),),
      ),
      body: Stack(
        children: [Positioned.fill(
            child: Lottie.asset(
              'assets/background7.json',
              fit: BoxFit.cover, 
            ),
          ),  ListView.builder(
          itemCount: _hairdressers.length,
          itemBuilder: (context, index) {
            final hairdresser = _hairdressers[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingScreen(hairdresser: hairdresser),
                  ),
                );
              },
              child: Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                        hairdresser.image,
                        height: 140, 
                        width: 130, 
                        fit: BoxFit.cover, 
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hairdresser.DresserName,
                          style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Staaž: ${hairdresser.DresserExp}',
                          style: GoogleFonts.roboto(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                         Row(
                            children: hairdresser.DresserWorkAge.map((icon) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: icon,
                            )).toList(),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        ],
      ),
    );
  }
}
