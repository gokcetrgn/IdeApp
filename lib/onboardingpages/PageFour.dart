import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ideapp/screens/kayitmi_girismi.dart';

class PageFour extends StatefulWidget {
  const PageFour({Key? key}) : super(key: key);

  @override
  State<PageFour> createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 450,
              child: Image.asset("images/Creativity-rafiki.png"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Peki sen de notlarını ve fikirlerini ölümsüzleştirmek istemez misin?",
                style: TextStyle(fontSize: 22,color: Colors.green.shade600,fontWeight: FontWeight.bold),textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => KayitmiGirismi()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Gezinmeye başla", style: TextStyle(fontSize: 26,color: Colors.green.shade600,fontWeight: FontWeight.bold),),
                  Icon(Icons.arrow_downward_outlined,color: Colors.green.shade600),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
