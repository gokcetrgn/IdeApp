import 'package:flutter/material.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
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
              child: Image.asset("images/Creativity-amico.png"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "IdeApp olarak fikirlerinin değerinin farkındayız. Onları kategorileştirip senin için tutuyoruz! Ayrıca uygulama içinde ilham da alabilirsin :)",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.green.shade500, fontWeight: FontWeight.bold,fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
