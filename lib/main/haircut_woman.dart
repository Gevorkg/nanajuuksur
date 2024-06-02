import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HaircutWoman{
  final int id;
  final Image cutImage;
  final String cutName;
  final String price;
  final String description;

  HaircutWoman({
    required this.id,
    required this.cutImage,
    required this.cutName,
    required this.price,
    required this.description,
  });
}

class HaircutWList extends StatefulWidget {
  HaircutWList({super.key});

  @override
  State<HaircutWList> createState() => _movieListWidgetState2();
}

class _movieListWidgetState2 extends State<HaircutWList> {
  final _haircutswoman = [
    HaircutWoman(
      id: 1,
      cutImage: Image.asset('images/woman_1.png'),
      cutName: 'Kukla piramine ja korrigeerimine',
      price: '10 EUR',
      description:
          'See teenus hõlmab kukla piirkonna lõikamist ja korrigeerimist, tagades sellega selge ja korrektse lõike. Sobib neile, kes soovivad hoolitsetud ja täpset soengut.',
    ),
    HaircutWoman(
      id: 2,
      cutImage: Image.asset('images/woman_2.png'),
      cutName: 'Tuka lõikus',
      price: '10 EUR',
      description:
          'Tuka lõikamine on stiilne valik, mis keskendub eesmisele juuksekasvule, andes juustele erilise ilme ja raamistades näo. Sobib neile, kes soovivad moodsat ja nooruslikku välimust.',
    ),
    HaircutWoman(
      id: 3,
      cutImage: Image.asset('images/woman_3.png'),
      cutName: 'Juuste otste lõikus',
      price: '22 EUR',
      description:
          'Juuste otste lõikamine on õrn protseduur, mis eemaldab juuste kuivad ja lõhenenud otsad, muutes juuksed tervislikumaks ja hoolitsetumaks.',
    ),
    HaircutWoman(
      id: 4,
      cutImage: Image.asset('images/woman_4.png'),
      cutName: 'Mudellõikus',
      price: '30 EUR',
      description:
          'Mudellõikus on individuaalne ja loominguline lõikus, mis on kohandatud vastavalt klienti soovidele ja juuste tekstuurile. See võimaldab eksperimenteerida erinevate stiilidega ja saavutada unikaalne välimus.',
    ),
    HaircutWoman(
      id: 5,
      cutImage: Image.asset('images/woman_5.png'),
      cutName: 'Mudellõikus pesuga',
      price: '35 EUR',
      description:
          'See kompleksne teenus hõlmab lõikust koos juuste pesuga, tagades puhta ja värskendava tunde. Sobib neile, kes hindavad täielikku ja lõõgastavat ilurituaali.',
    ),
    HaircutWoman(
      id: 6,
      cutImage: Image.asset('images/woman_6.png'),
      cutName: 'Eakate juustelõikus',
      price: '15 EUR',
      description:
          'Eakatele mõeldud juustelõikus pakub õrnust ja täpsust, arvestades vananemisega seotud muutusi juuste tekstuuris ja kasvus. Sobib neile, kes soovivad säilitada elegantset ja hooldatud välimust.',
    ),
    HaircutWoman(
      id: 7,
      cutImage: Image.asset('images/woman_7.png'),
      cutName: 'Juuksetattoo',
      price: '20 EUR',
      description:
          'Juuksetattoo on unikaalne teenus, mis hõlmab kunstilise juuksetätoveeringu loomist, lisades juustele loomingulise ja isikupärase elemendi. Sobib neile, kes soovivad eristuda ja väljendada oma individuaalsust.',
    ),
    HaircutWoman(
      id: 8,
      cutImage: Image.asset('images/woman_8.png'),
      cutName: 'Peapesu massaaziga',
      price: '12 EUR',
      description:
          ' Peapesu massaaž koos juuste pesuga pakub lõõgastavat ja terapeutilist kogemust, parandades vereringet ja vähendades stressi. See aitab luua meeldiva ja rahustava atmosfääri ilusalongis.',
    ),
    HaircutWoman(
      id: 9,
      cutImage: Image.asset('images/woman_9.png'),
      cutName: 'Juukselõikus + Tattoo',
      price: '30 EUR',
      description:
          'See teenus ühendab juuste lõikuse kunstilise juuksetätoveeringuga, luues julge ja väljendusrikka välimuse. Sobib neile, kes soovivad oma soengule lisada kunstilist ja individuaalset elementi.',
    ),

   
  ];

  var _filteredHaircutswoman = <HaircutWoman>[];

  final _searchController = TextEditingController();

  void _searchHaircuts2() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredHaircutswoman = _haircutswoman.where((HaircutWoman haircut2) {
        return haircut2.cutName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredHaircutswoman = _haircutswoman;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _filteredHaircutswoman = _haircutswoman;

    _searchController.addListener(_searchHaircuts2);
  }

  void _onHaircutTab(int index) {
  final selectedHaircutWoman = _filteredHaircutswoman[index];
  Navigator.of(context).pushNamed('/main_screen/haircut_details_woman', arguments: selectedHaircutWoman);
}
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Lottie.asset(
              'assets/background7.json',
              fit: BoxFit.cover, 
            ),
          ),
        ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(top: 64),
          itemCount: _filteredHaircutswoman.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final haircuts = _filteredHaircutswoman[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 13),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 1,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: [
                        haircuts.cutImage,
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                haircuts.cutName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                haircuts.price,
                                style: GoogleFonts.roboto(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                haircuts.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      onTap: () => _onHaircutTab(index),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
              labelText: 'Otsi...',
              border:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            ),
          ),
        ),
      ],
    );
  }
}
