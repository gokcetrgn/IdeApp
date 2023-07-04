import 'package:flutter/material.dart';
import 'package:ideapp/database/database_helper.dart';
import 'anasayfa.dart';

class NotAlmaPage extends StatefulWidget {
  @override
  _NotAlmaPageState createState() => _NotAlmaPageState();
}

class _NotAlmaPageState extends State<NotAlmaPage> {
  late String selectedCategory;
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController newCategoryController = TextEditingController();

  DatabaseHelper dbHelper = DatabaseHelper();

  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    selectedCategory = '';
    loadCategories();
  }

  void loadCategories() async {
    List<String> loadedCategories = await dbHelper.getCategories();
    setState(() {
      categories = loadedCategories;
      selectedCategory = categories.isNotEmpty ? categories[0] : '';
    });
  }

  void addNote() async {
    int category = categories.indexOf(selectedCategory) + 1;
    String title = titleController.text;
    String note = noteController.text;

    await dbHelper.notEkle(category, title, note);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Başarılı'),
          content: const Text('Notunuz kaydedildi.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Anasayfa(),
                  ),
                );
              },
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
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
                value: selectedCategory.isNotEmpty ? selectedCategory : null,
                onChanged: (value) {
                  if (value == 'Yeni Kategori Oluştur') {
                    _showCreateCategoryDialog();
                  } else {
                    setState(() {
                      selectedCategory = value!;
                    });
                  }
                },
                items: [
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
                  ...categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }),
                ],
                decoration: InputDecoration(
                  labelText: 'Kategori Seçin veya Oluşturun',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: titleController,
                maxLength: 100,
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
                onPressed: addNote,
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
            maxLength: 25,
            decoration: InputDecoration(
              labelText: 'Kategori Adı',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () async {
                String newCategory = newCategoryController.text;
                if (newCategory.isNotEmpty) {
                  if (!categories.contains(newCategory)) {
                    await dbHelper.kategoriEkle(newCategory);
                    setState(() {
                      selectedCategory = newCategory;
                      categories.add(newCategory);
                    });
                  } else {
                    setState(() {
                      selectedCategory = newCategory;
                    });
                  }
                }
                Navigator.pop(context);
              },
              child: const Text('Oluştur'),
            ),
          ],
        );
      },
    );
  }
}
