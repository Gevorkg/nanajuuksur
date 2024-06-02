import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Haircut {
  final int id;
  final Image cutImage;
  final String cutName;
  final String price;
  final String description;

  Haircut({
    required this.id,
    required this.cutImage,
    required this.cutName,
    required this.price,
    required this.description,
  });
}

class HaircutMWidget extends StatefulWidget {
  HaircutMWidget({super.key});

  @override
  State<HaircutMWidget> createState() => _HaircutMWidget();
}

class _HaircutMWidget extends State<HaircutMWidget> {
  final _haircuts = [
    Haircut(
      id: 1,
      cutImage: Image.asset('images/man1.png'),
      cutName: 'Juukselõikus',
      price: '18 EUR',
      description:
          'Standardne täiskasvanute juukselõikus, kus kasutatakse kvaliteetseid töövahendeid ja tehnikaid.',
    ),
    Haircut(
      id: 2,
      cutImage: Image.asset('images/man2.png'),
      cutName: 'Pensionäridele juukselõikus',
      price: '13 EUR',
      description:
          'Eriti soodushinnaga juukselõikus pensionäridele, pakkudes taskukohast teenust kõrge kvaliteediga. Sobib neile, kes hindavad lihtsat ja hooldatud soengut.',
    ),
    Haircut(
      id: 3,
      cutImage: Image.asset('images/man3.png'),
      cutName: 'Juukselõikus pesuga',
      price: '20 EUR',
      description:
          'Kompleksne teenus, kus lisaks juukselõikusele pakutakse ka juuste pesu. Ideaalne neile, kes soovivad lõõgastavat ja täielikku iluprotseduuri.',
    ),
    Haircut(
      id: 4,
      cutImage: Image.asset('images/man4.png'),
      cutName: 'Väheste juukselõikus',
      price: '15 EUR',
      description:
          'Stiilne ja moodsa puudutusega juukselõikus, sobib neile, kes soovivad midagi uut proovida. Ideaalne valik neile, kes hindavad individuaalsust ja trendikust.',
    ),
    Haircut(
      id: 5,
      cutImage: Image.asset('images/man5.png'),
      cutName: '"FADE" juukselõikus',
      price: '25 EUR',
      description:
          'Kaasaegne ja julge "FADE" juukselõikus, mis rõhutab teravaid jooni ja kontraste. Sobib neile, kes soovivad moekat ja silmapaistvat soengut.',
    ),
    Haircut(
      id: 6,
      cutImage: Image.asset('images/man6.png'),
      cutName: 'Stiilimuutus',
      price: '25 EUR',
      description:
          'Täielik muutus juuste kujundamisel, mis hõlmab nii lõikust kui ka stiilimist. Sobib julgetele inimestele, kes soovivad midagi täiesti uut proovida.',
    ),
    Haircut(
      id: 7,
      cutImage: Image.asset('images/man7.png'),
      cutName: 'Juukse TATTOO al.',
      price: '18 EUR',
      description:
          'Unikaalne teenus, mis hõlmab kunstilist juuksetätoveeringut. Sobib neile, kes soovivad oma soengule lisada loomingulist ja kunstilist elementi.',
    ),
    Haircut(
      id: 8,
      cutImage: Image.asset('images/man8.png'),
      cutName: 'Laste juukselõikus /kuni 10a.',
      price: '15 EUR',
      description:
          'Lastespetsiifiline juukselõikus, mis on kohandatud laste vajadustele ja mugavusele. Ideaalne valik noorematele klientidele.',
    ),
    Haircut(
      id: 9,
      cutImage: Image.asset('images/man9.png'),
      cutName: 'Masinalõikus 3-6mm',
      price: '10-12 EUR',
      description:
          'Masinaga teostatud juukselõikus vahemikus 3-6 mm. Sobib neile, kes eelistavad lühemat soengut.',
    ),
    Haircut(
      id: 10,
      cutImage: Image.asset('images/man9.png'),
      cutName: 'Masinalõikus 9-12mm',
      price: '12-15 EUR',
      description:
          'Masinaga teostatud juukselõikus vahemikus 9-12 mm. Sobib neile, kes soovivad veidi pikemat soeng',
    ),
    Haircut(
      id: 11,
      cutImage: Image.asset('images/man9.png'),
      cutName: 'Masinalõikus 18-25mm',
      price: '15-20 EUR',
      description:
          'Masinaga teostatud juukselõikus vahemikus 18-25 mm. Ideaalne neile, kes soovivad veelgi pikemat soengut.',
    ),
    Haircut(
      id: 12,
      cutImage: Image.asset('images/man12.png'),
      cutName: 'Pea paljaks ajamine',
      price: '20 EUR',
      description:
          'Radikaalne valik, kus juuksed ajatakse täielikult maha. Sobib neile, kes soovivad julget ja kergesti hooldatavat stiili.',
    ),
    Haircut(
      id: 13,
      cutImage: Image.asset('images/man13.png'),
      cutName: 'Pea paljaks ajamine pardliga',
      price: '25 EUR',
      description:
          'Ekstreemne soeng, kus juuksed ajatakse täielikult maha pardliga. Sobib neile, kes soovivad äärmuslikku ja moodsat välimust.',
    ),
    Haircut(
      id: 14,
      cutImage: Image.asset('images/man14.png'),
      cutName: 'Juuste pesemine',
      price: '5 EUR',
      description:
          'Eraldi teenus, kus pakutakse juuste pesu kas enne või pärast juukselõikust. Sobib neile, kes soovivad värsket ja puhtat tunnet.',
    ),
    Haircut(
      id: 15,
      cutImage: Image.asset('images/man15.png'),
      cutName: 'Juuste pesemine + soeng fööniga kuivatamine',
      price: '10 EUR',
      description:
          'Täielik teenus, mis sisaldab juuste pesu koos soengu või fööniga kuivatamisega. Sobib neile, kes soovivad professionaalset viimistlust.',
    ),
    Haircut(
      id: 16,
      cutImage: Image.asset('images/man16.png'),
      cutName: 'Vuntside piiramine',
      price: '5 EUR',
      description:
          'Eraldi teenus, mis hõlmab vuntside korrigeerimist ja kujundamist. Sobib neile, kes soovivad täpseid näojooni.',
    ),
    Haircut(
      id: 17,
      cutImage: Image.asset('images/man17.png'),
      cutName: 'Habeme ajamine/piiramine',
      price: '7 EUR',
      description:
          'Teenuse osa, kus teostatakse habeme ajamine või piiramine. Sobib neile, kes soovivad hooldatud ja korrektset habet.',
    ),
    Haircut(
      id: 18,
      cutImage: Image.asset('images/man18.png'),
      cutName: 'Habeme kujundamine',
      price: '15 EUR',
      description:
          'Spetsiifiline teenus, kus tehakse habeme kujundamine vastavalt klienti soovidele. Sobib neile, kes soovivad unikaalset ja isikupärast habemet.',
    ),
    Haircut(
      id: 19,
      cutImage: Image.asset('images/man19.png'),
      cutName: 'Habeme piiramine + vuntsid',
      price: '10 EUR',
      description:
          'Teenuse kombinatsioon, kus tehakse habeme piiramine koos vuntside kujundamisega. Sobib neile, kes soovivad täpset ja hooldatud näojoont.',
    ),
    Haircut(
      id: 20,
      cutImage: Image.asset('images/man20.png'),
      cutName: 'Kuljed, kukal',
      price: '13 EUR',
      description:
          'Stiilne teenus, kus keskendutakse kulmudele ja kuklale, tagades korrektse ja täpse lõikuse. Sobib neile, kes soovivad täpset ja detailirohket soengut.',
    ),
    Haircut(
      id: 21,
      cutImage: Image.asset('images/man21.png'),
      cutName: 'Kuljed, kukal "Fade" stiilis',
      price: '18 EUR',
      description:
          '"Fade" stiilis teenus, kus kulmud ja kukal kujundatakse moekalt ja teravate joontega. Sobib neile, kes soovivad kaasaegset ja silmapaistvat soengut.',
    ),
  ];

  var _filteredHaircuts = <Haircut>[];

  final _searchController = TextEditingController();

  void _searchHaircuts() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredHaircuts = _haircuts.where((Haircut haircut) {
        return haircut.cutName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredHaircuts = _haircuts;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _filteredHaircuts = _haircuts;

    _searchController.addListener(_searchHaircuts);
  }

  void _onHaircutTab(int index) {
  final selectedHaircut = _filteredHaircuts[index];
  Navigator.of(context).pushNamed('/main_screen/haircut_details', arguments: selectedHaircut);
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
          itemCount: _filteredHaircuts.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final haircuts = _filteredHaircuts[index];
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
                                maxLines: 1,
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
