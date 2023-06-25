import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ideapp/screens/giris_ekrani.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var _textsifre = TextEditingController();
  var _textemail = TextEditingController();
  var _textad = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.shade200,
        body:SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 350,
                    child: Column(
                      children: [
                        Image.asset("images/Mentalhealth-bro.png",),
                        Text("Kaydol",style: GoogleFonts.dancingScript(
                          color: Colors.black87,
                          fontSize: 55,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                        )),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text("Hesabınızı oluşturun", style: TextStyle(fontSize: 20,color: Colors.black87),),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0,left: 16.0),
                    child: TextFormField(
                      controller: _textad,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: ("İsim"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),)),
                      validator: (value) {
                        if (value != null && value.length < 3)
                          return " İsim en az 3 karakter olmalıdır";
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                    child: TextFormField(
                      controller: _textemail,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: ("Email"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),)),
                      validator: (value) {
                        if (value != null && !value.contains('@') || value != null && !value.contains('.com'))
                          return "Geçerli bir eposta adresi giriniz";
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0,left: 16.0),
                    child: TextFormField(
                      controller: _textsifre,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: ("Şifre"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),)),
                      validator: (value) {
                        if (value != null && value.length < 8)
                          return " Şifre en az 8 karakter olmalıdır";
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SizedBox(
                    width: 250,
                    child:
                    ElevatedButton
                      (onPressed: (){
                      bool kontrolSonucu = formKey.currentState!.validate();
                      if(kontrolSonucu){
                        String email = _textemail.text;
                        String sifre = _textsifre.text;
                        String ad = _textad.text;
                      }
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));

                      FirebaseAuth.instance.createUserWithEmailAndPassword(email: _textemail.text, password: _textsifre.text).then((value) {
                        print("Kullanici kaydedildi");

                      }).onError((error, stackTrace) {
                        print("Error ${error.toString}");
                      }
                      );
                      _textsifre.clear();
                      _textemail.clear();
                      _textad.clear();

                    },
                        child:
                        Text("ÜYE OL",style: TextStyle(color: Colors.green,fontSize: 20),)
                    ),
                  ),
                  Container(
                    width: 200,
                    child: Row(
                      children: [
                        Text("Hesabın var mı?", style: TextStyle(color: Colors.black38),),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        }, child: Text("Giriş Yap", style: TextStyle(fontSize: 16, color: Colors.black87),)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green.withOpacity(0.1),
          shape: CircleBorder(),
          mini: true,
          child: Icon(Icons.arrow_back_outlined),
          onPressed: (){
            Navigator.pop(context);
          },
        )
    );
  }
}