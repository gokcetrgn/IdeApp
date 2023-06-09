import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Anasayfa extends StatefulWidget {
  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () { },
          child: Icon(
            Icons.menu,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("IdeApp", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      bottomNavigationBar: CurvedNavigationBar(

        backgroundColor: Colors.greenAccent,
        items: [
          Icon(Icons.home),
          Icon(Icons.person),
          Icon(Icons.messenger),
          Icon(Icons.settings),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("Not eklendi.");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
