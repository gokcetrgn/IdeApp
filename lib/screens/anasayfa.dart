import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ideapp/screens/not_alma.dart';

void main() {
  runApp(Anasayfa());
}

class StoicQuote {
  final String text;
  final String author;

  StoicQuote(this.text, this.author);
}

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  List<StoicQuote> quotes = [];

  @override
  void initState() {
    super.initState();
    fetchStoicQuotes();
  }

  Future<void> fetchStoicQuotes() async {
    final response = await http.get(Uri.parse('https://stoic-quotes.com/api/quotes?num=10'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      setState(() {
        quotes = jsonData.map((json) {
          final text = json['text'] as String;
          final author = json['author'] as String;
          return StoicQuote(text, author);
        }).toList();
      });
    } else {
      throw Exception('Alıntı verisi getirilemedi.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IdeApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'IdeApp',
            style: TextStyle(
              fontFamily: 'MajorMonoDisplay',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 5.0,
              fontSize: 28.0,
            ),
          ),
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
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.green,
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CategoryItem('İlham', () {
                        // İlham kategorisine tıklandığında yapılacak işlemler
                        print('İlham kategorisine tıklandı');
                      }),
                      CategoryItem('Motivasyon', () {
                        // Motivasyon kategorisine tıklandığında yapılacak işlemler
                        print('Motivasyon kategorisine tıklandı');
                      }),
                      CategoryItem('Kişisel gelişim', () {
                        // Kişisel gelişim kategorisine tıklandığında yapılacak işlemler
                        print('Kişisel gelişim kategorisine tıklandı');
                      }),
                      CategoryItem('Yazılım', () {
                        // Yazılım kategorisine tıklandığında yapılacak işlemler
                        print('Yazılım kategorisine tıklandı');
                      }),
                      CategoryItem('Sanat', () {
                        // Sanat kategorisine tıklandığında yapılacak işlemler
                        print('Sanat kategorisine tıklandı');
                      }),
                      CategoryItem('Felsefe', () {
                        // Felsefe kategorisine tıklandığında yapılacak işlemler
                        print('Felsefe kategorisine tıklandı');
                      }),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: quotes.map((quote) => CardWidget(quote)).toList(),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 70,
              right: 16,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotAlmaPage()),
                  );
                },
                child: const Icon(Icons.edit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String categoryName;
  final VoidCallback onPressed;

  CategoryItem(this.categoryName, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          categoryName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final StoicQuote quote;

  CardWidget(this.quote);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.translate(
            offset: const Offset(0, 3), // 3 birim aşağı kaydırma
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                quote.text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '- ${quote.author}',
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
