import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ideapp/onboardingpages/GecisSayfasi.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 5, color: Colors.red.shade100),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 20,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.black38,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Profiliniz", style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Profiline hoş geldin! Senden aldığımız geri dönütlerle güncellemeye devam edeceğiz. Şimdilik bu şekilde bırakıyoruz...",style: TextStyle(
                fontSize: 18,
              ),),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4,
                          ),
                          leading: Icon(Icons.email),
                          title: Text("Email"),
                          subtitle: Text(user?.email ?? "Anonim"),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  backgroundColor: Colors.red
                ),
                  icon: Icon(Icons.arrow_back_outlined,size: 32,),
                label: Text("ÇIKIŞ YAP", style: TextStyle(fontSize: 24),),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await GoogleSignIn().signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => GecisSayfasi()),
                  );
                },
              ),
            ),
          ],
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
        )
    );
  }
}
