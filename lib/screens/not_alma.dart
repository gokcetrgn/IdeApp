import 'package:flutter/material.dart';

class NotAlmaPage extends StatefulWidget {
  @override
  _NotAlmaPageState createState() => _NotAlmaPageState();
}

class _NotAlmaPageState extends State<NotAlmaPage> {
  late String selectedCategory;
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController newCategoryController = TextEditingController();

  List<String> categories = [
    'Kategori 1',
    'Kategori 2',
    'Kategori 3',
    'Kategori 4',
    'Kategori 5',
  ];

  @override
  void initState() {
    super.initState();
    selectedCategory = categories[0]; // İlk kategori varsayılan olarak seçili olarak başlatılıyor
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Not Al'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: selectedCategory,
                onChanged: (value) {
                  if (value == 'Yeni Kategori Oluştur') {
                    // Yeni kategori oluşturma işlemi
                    _showCreateCategoryDialog();
                  } else {
                    setState(() {
                      selectedCategory = value!;
                    });
                  }
                },
                items: [
                  ...categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }),
                  DropdownMenuItem<String>(
                    value: 'Yeni Kategori Oluştur',
                    child: Row(
                      children: [
                        Icon(Icons.add, color: Colors.green),
                        SizedBox(width: 8.0),
                        Text(
                          'Yeni Kategori Oluştur',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ],
                decoration: InputDecoration(
                  labelText: 'Kategori Seçin veya Oluşturun',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Başlık',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: noteController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Notunuz',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Notu kaydetmek için gerekli işlemleri yapın
                  String category = selectedCategory;
                  String title = titleController.text;
                  String note = noteController.text;

                  // Örnek olarak notu yazdıralım
                  print('Kategori: $category');
                  print('Başlık: $title');
                  print('Not: $note');

                  // Notu kaydettikten sonra istediğiniz işlemleri yapabilirsiniz
                },
                child: const Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Yeni Kategori Oluştur'),
          content: TextField(
            controller: newCategoryController,
            decoration: InputDecoration(
              labelText: 'Kategori Adı',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dialogu kapat
              },
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                String newCategory = newCategoryController.text;
                if (newCategory.isNotEmpty) {
                  setState(() {
                    categories.add(newCategory);
                    selectedCategory = newCategory;
                  });
                  Navigator.pop(context); // Dialogu kapat
                }
              },
              child: const Text('Oluştur'),
            ),
          ],
        );
      },
    );
  }
}