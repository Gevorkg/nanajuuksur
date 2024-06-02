import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ark_test/Theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tekst,
      appBar: AppBar(
        title: Text(style: GoogleFonts.roboto(color: AppColors.tekst, fontSize: 20),
          'Sisene oma kontole'),
      ),
      body: ListView(
        children: [
          _HeaderWidget(),
          SignInPage(),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       Container(
                width: 300, 
                height: 300, 
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.tekst, width: 2), 
                  borderRadius: BorderRadius.circular(10), 
                  color: Colors.transparent, 
                ),
                child: Image.asset(
                  'images/loginauth1.png',
                  fit: BoxFit.cover, 
                ),
              ),
      ],
    );
  }



}

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/main_screen');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _errorMessage = 'User does not exist';
        });
      } else {
        setState(() {
          _errorMessage = 'Error signing in: Email või parool on vale.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error signing in: $e';
      });
    }
  }

  void _navigateToSignUpPage() {
    Navigator.pushNamed(context, '/sign_up');
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.roboto(fontSize: 18, color: Colors.black);
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Text(
            'Email',
            style: textStyle,
          ),
          SizedBox(height: 5),
          TextField(
            controller: _emailController,
            decoration: textFileDecorator,
            
            
          ),
          SizedBox(height: 10),
          Text(
            'Parool',
            style: textStyle,
          ),
          SizedBox(height: 5),
          TextField(
            controller: _passwordController,
            decoration: textFileDecorator,
            obscureText: true,
          ),
          SizedBox(height: 10),
          if (_errorMessage.isNotEmpty)
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          SizedBox(height: 20),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 63),
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
                      EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                    ),
                  ),
                  onPressed: _signInWithEmailAndPassword,
                  child: Text('Login', ),
                ),
              ),
            ],
          ),
          SizedBox(width: 10), 
          Row(
            children: [
              SizedBox(width: 65,),
              Text(
                'Kas teil pole veel kontot?'),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.tekst),
                  foregroundColor: MaterialStateProperty.all(AppColors.knopka),
                  overlayColor: MaterialStatePropertyAll(AppColors.tekst),
                  textStyle: MaterialStateProperty.all(
                    GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  ),
                ),
                onPressed: _navigateToSignUpPage,
                child: Text('Loo konto'),
              ),
            ],
          ),
           
        ],
      ),
    );
  }
}
