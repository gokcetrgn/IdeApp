import 'package:flutter/material.dart';
import 'package:ideapp/screens/anasayfa.dart';

class GirisEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color.fromARGB(186, 60, 75, 73),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.transparent,
                child: CustomPaint(
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Container(
                      width: 180,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Center(
                        child: Text(
                          'Hoşgeldiniz!',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Kullanıcı Adı',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Şifre',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  print('Kaydolma sayfasına yönlendirme yapıldı');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                                child: const Text('Kaydol'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  print('Kullanıcı girişi yapıldı');
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Anasayfa()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                                child: const Text('Giriş Yap'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              print('Google ile giriş yapıldı');
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Anasayfa()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            child: const Text(
                              'Google ile Giriş Yap',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              print('Giriş yapmadan devam et');
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Anasayfa()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            child: const Text('Giriş Yapmadan Devam Et'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

