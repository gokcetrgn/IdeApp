import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ideapp/onboardingpages/PageFour.dart';
import 'package:ideapp/onboardingpages/PageOne.dart';
import 'package:ideapp/onboardingpages/PageThree.dart';
import 'package:ideapp/onboardingpages/PageTwo.dart';
import 'package:ideapp/screens/kayitmi_girismi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GecisSayfasi extends StatefulWidget {
  const GecisSayfasi({Key? key}) : super(key: key);

  @override
  State<GecisSayfasi> createState() => _GecisSayfasiState();
}

class _GecisSayfasiState extends State<GecisSayfasi> {
  bool islastpage = false;
  final controller = PageController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageView(
          onPageChanged: (indeks) {
            setState(() => islastpage = indeks == 3);
          },
          controller: controller,
          children: [
            PageOne(),
            PageTwo(),
            PageThree(),
            PageFour(),
          ],
        ),
      ),
      bottomSheet: islastpage
          ? TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white70,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                minimumSize: Size.fromHeight(80),
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('digerSayfayaGecisi', true);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KayitmiGirismi()));
              },
              child: Text(
                "KEŞFET",
                style: TextStyle(fontSize: 24, color: Colors.green.shade400),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(color: Colors.green.shade100),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () => controller.jumpToPage(3),
                      child: Text(
                        "GEÇ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                  Center(
                    child: SmoothPageIndicator(
                        controller: controller,
                        count: 4,
                        effect: WormEffect(
                            spacing: 16,
                            dotColor: Colors.green.shade300,
                            activeDotColor: Colors.black87),
                        onDotClicked: (index) => controller.animateToPage(index,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn)),
                  ),
                  TextButton(
                      onPressed: () => controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      child: Text(
                        "DEVAM ET",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
    );
  }
}
