import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ideapp/screens/anasayfa.dart';
import 'package:ideapp/screens/giris_ekrani.dart';
import 'package:ideapp/screens/uye_ol_ekrani.dart';

class KayitmiGirismi extends StatefulWidget {
  const KayitmiGirismi({Key? key}) : super(key: key);

  @override
  State<KayitmiGirismi> createState() => _KayitmiGirismiState();
}

class _KayitmiGirismiState extends State<KayitmiGirismi> {
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.green.shade200,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 320,
                  child: Image.asset("images/brain.png"),
                ),
                Text("IdeApp",
                    style: GoogleFonts.dancingScript(
                      color: Colors.black54,
                      fontSize: MediaQuery.of(context).size.shortestSide * 0.2,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    )),
                Text(
                  "Fikirlerinizi kategorileyip kaydedin. ",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text("GİRİŞ YAP",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 22,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade400,
                        side: const BorderSide(
                            width: 2, // the thickness
                            color: Colors.white // the color of the border
                            ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                      },
                      child: Text("KAYDOL",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signInAnonymously();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Anasayfa()));
                    },
                    child: Text(
                      "Üye olmadan devam et ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
