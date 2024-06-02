import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ark_test/Theme/app_colors.dart';
import 'package:flutter_ark_test/auth/auth_widget.dart';
import 'package:google_fonts/google_fonts.dart'; 

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String _passwordErrorText = '';
  String _emailErrorText = '';

  Future<void> _signUpWithEmailAndPassword() async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();
      final String confirmPassword = _confirmPasswordController.text.trim();

      if (password != confirmPassword) {
        setState(() {
          _passwordErrorText = 'Paroolid ei kattu.';
          _emailErrorText = '';
        });
        return;
      } else if (!email.contains('@')) {
        setState(() {
          _emailErrorText = 'Sisestage kehtiv e-posti aadress.';
          _passwordErrorText = '';
        });
        return;
      }

      if (password.length < 6) {
        setState(() {
          _passwordErrorText = 'Parool peab olema vähemalt 6 tähemärki pikk.';
          _emailErrorText = '';
        });
        return;
      } else {
        setState(() {
          _passwordErrorText = '';
          _emailErrorText = '';
        });
      }

      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      
      await userCredential.user?.sendEmailVerification();

      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthWidget()),
      );
    } catch (e) {
      
      print('Error signing up: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle =  GoogleFonts.roboto(fontSize: 18, color: Colors.black);
    final textFileDecorator = const InputDecoration(
      
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.knopka2, width: 1), 
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.knopka2, width: 2.0), 
  ),
  contentPadding: EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 10,
  ),
  isCollapsed: true,
);

    return Scaffold(
      backgroundColor: AppColors.tekst,
  appBar: AppBar(
    title: Text('Registreeru', style: GoogleFonts.roboto(color: AppColors.tekst, fontSize: 20),),
  ),
  resizeToAvoidBottomInset: true, 
  body: SingleChildScrollView( 
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Text('Email', style: textStyle),
          SizedBox(height: 5),
          TextField(controller: _emailController, decoration: textFileDecorator),
          SizedBox(height: 5),
          if (_emailErrorText.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(_emailErrorText, style: TextStyle(color: Colors.red)),
            ),
          SizedBox(height: 10),
          Text('Parool', style: textStyle),
          SizedBox(height: 5),
          TextField(controller: _passwordController, decoration: textFileDecorator, obscureText: true),
          SizedBox(height: 5),
          if (_passwordErrorText.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(_passwordErrorText, style: TextStyle(color: Colors.red)),
            ),
          SizedBox(height: 10),
          Text('Kinnita parool', style: textStyle),
          SizedBox(height: 5),
          TextField(controller: _confirmPasswordController, decoration: textFileDecorator, obscureText: true),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25,),
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
                        GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                       padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric( vertical: 10),
                      ),
                    ),
                    onPressed: _signUpWithEmailAndPassword,
                    child: Text('Registreeru'),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 300, 
              height: 300, 
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.01), width: 2), 
                borderRadius: BorderRadius.circular(10), 
                color: Colors.transparent, 
              ),
              child: Image.asset(
                'images/signup2.png',
                fit: BoxFit.cover, 
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);
  }
}
