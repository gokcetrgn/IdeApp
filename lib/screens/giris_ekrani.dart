import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ideapp/screens/anasayfa.dart';
import 'package:ideapp/screens/auth_kismi.dart';
import 'package:ideapp/screens/google_ile_giris.dart';
import 'package:ideapp/screens/uye_ol_ekrani.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void login() {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    authProvider.setLoggedIn(true);
  }

  User? user = FirebaseAuth.instance.currentUser;

  var _textsifre = TextEditingController();
  var _textemail = TextEditingController();
  final formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    if (FirebaseAuth.instance.currentUser != null) {
      print("Giriş yapılmış");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.shade200,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("IdeApp",
                      style: GoogleFonts.dancingScript(
                        color: Colors.black87,
                        fontSize: 85,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      )),
                  Container(
                    height: 350,
                    child: Image.asset("images/Mobilelogin-bro.png"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                    child: TextFormField(
                      controller: _textemail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: ("Email"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          )),
                      validator: (value) {
                        if (value != null && !value.contains('@') ||
                            value != null && !value.contains('.com'))
                          return "Geçerli bir eposta adresi giriniz";
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
                      controller: _textsifre,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.key),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: ("Şifre"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          )),
                      validator: (value) {
                        if (value != null && value.length < 8)
                          return "Şifre en az 8 karakter olmalıdır";
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {
                          bool kontrolSonucu = formKey.currentState!.validate();
                          if (kontrolSonucu) {
                            String email = _textemail.text;
                            String sifre = _textsifre.text;

                            signInWithEmailAndPassword(email, sifre);
                          }
                        },
                        child: Text(
                          "Giriş Yap",
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ), //label text
                      )),
                  Container(
                    width: 200,
                    child: Row(
                      children: [
                        Text(
                          "Hesabın yok mu?",
                          style: TextStyle(color: Colors.black38),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInScreen()));
                            },
                            child: Text(
                              "Kaydol",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            )),
                      ],
                    ),
                  ),
                  new Container(
                    child: Divider(
                      color: Colors.white30,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await signInWithGoogle();
                      String uid = FirebaseAuth.instance.currentUser!.uid;
                      await FirebaseFirestore.instance
                          .collection("kullanıcılar")
                          .doc(uid)
                          .set(
                        {
                          "girilyaptiMi": true,
                          "songiristarihi": FieldValue.serverTimestamp(),
                        },
                        SetOptions(merge: true),
                      );
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Anasayfa()));
                    },
                    child: Text("Google ile giriş yap",
                        style: TextStyle(
                            fontSize: 25.0,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: <Color>[
                                  Colors.blue,
                                  Colors.red,
                                  Colors.yellow,
                                  Colors.green,
                                  //add more color here.
                                ],
                              ).createShader(
                                  Rect.fromLTWH(0.0, 0.0, 200.0, 100.0)))),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white.withOpacity(0.1),
          shape: CircleBorder(),
          mini: true,
          child: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        login();
        // Kullanıcı oturumu açtı, giriş işlemlerini gerçekleştir
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Anasayfa()),
        );
        _textemail.clear();
        _textsifre.clear();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // E-posta kaydı bulunamadı
        print('Bu eposta adresine ait bir kullanıcı bulunamadı.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bu eposta adresine ait bir kullanıcı bulunamadı.'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        // Yanlış şifre
        print('Şifre yanlış.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Şifre yanlış!'),
          ),
        );
      }
    } catch (e) {
      // Diğer hatalar
      print('Giriş yaparken bir hata oluştu: $e');
    }
  }
}
