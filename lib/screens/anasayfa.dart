import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ideapp/screens/profilsayfasi.dart';
import 'not_alma.dart';
import 'notlar.dart';
import 'package:ideapp/database/database_helper.dart';
import 'okunan_not.dart';

void main() {
  runApp(Anasayfa());
}

class StoicQuote {
  final String text;
  final String author;

  StoicQuote(this.text, this.author);
}

class Anasayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IdeApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnasayfaPage(),
    );
  }
}

class AnasayfaPage extends StatefulWidget {
  @override
  _AnasayfaPageState createState() => _AnasayfaPageState();
}

class _AnasayfaPageState extends State<AnasayfaPage> {
  List<StoicQuote> quotes = [];
  List<Map<String, dynamic>> categories = [];
  final ScrollController scrollController = ScrollController();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetchStoicQuotes();
    fetchCategories();

    // Her saniye kategorileri kontrol etmek için Timer kullanımı
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      fetchCategories();
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // Timer'ı iptal et
    super.dispose();
  }

  Future<void> fetchStoicQuotes() async {
    final response =
    await http.get(Uri.parse('https://stoic-quotes.com/api/quotes?num=10'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      setState(() {
        quotes = jsonData
            .map((json) => StoicQuote(json['text'] as String, json['author'] as String))
            .toList();
      });
    } else {
      throw Exception('Alıntı verisi getirilemedi.');
    }
  }

  Future<void> fetchCategories() async {
    final retrievedCategories = await DatabaseHelper().getAllCategories();
    setState(() {
      categories = List<Map<String, dynamic>>.from(retrievedCategories);
    });
  }

  Future<void> fetchCategoryNotes(String categoryId) async {
    // Notları getirdikten sonra OkunanNotPage'e geçiş yapabilirsiniz
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OkunanNotPage(categoryId: categoryId),
      ),
    );
  }

  void refreshQuotes() {
    fetchStoicQuotes();
    scrollToTop();
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text(
          'IdeApp',
            style: GoogleFonts.wixMadeforText(
              color: Colors.white,
                fontSize: 45,
                fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Colors.green.shade300,
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...categories.map((category) => CategoryItem(category['name'] as String, () {
                      fetchCategoryNotes(category['id'].toString());
                    })).toList(),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: scrollController,
                  child: Row(
                    children: [
                      ...quotes.map((quote) => CardWidget(quote)).toList(),
                      RefreshCardWidget(refreshQuotes),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (quotes.isEmpty)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotAlmaPage()),
          );
        },
        child: Icon(Icons.create),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green.shade300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilPage()));
              },
              icon: Icon(Icons.account_circle),
              color: Colors.white,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotlarPage()),
                );
              },
              icon: Icon(Icons.psychology),
              color: Colors.white,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // ayarlar butonuna basıldığında yapılacak işlemler
              },
              icon: Icon(Icons.settings),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatefulWidget {
  final String category;
  final Function onTap;

  const CategoryItem(this.category, this.onTap);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isTapped = false;
        });
        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          isTapped = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isTapped ? Color.fromARGB(255, 28, 199, 142) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          widget.category,
          style: TextStyle(
            color: isTapped ? Colors.black : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final StoicQuote quote;

  const CardWidget(this.quote);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 200,
      height: 400,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                quote.text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                '- ${quote.author}',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RefreshCardWidget extends StatelessWidget {
  final Function refreshQuotes;

  const RefreshCardWidget(this.refreshQuotes);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 200,
      height: 400,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          onTap: () => refreshQuotes(),
          child: Center(
            child: Icon(Icons.refresh),
          ),
        ),
      ),
    );
  }
}