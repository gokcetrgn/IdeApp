import 'package:flutter/material.dart';
import 'package:ideapp/database/database_helper.dart';
import 'okunan_not.dart';

class NotlarPage extends StatefulWidget {
  @override
  _NotlarPageState createState() => _NotlarPageState();
}

class _NotlarPageState extends State<NotlarPage> {
  late List<Map<String, dynamic>> categories;
  late Future<List<Map<String, dynamic>>> categoriesFuture;
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    categoriesFuture = dbHelper.getAllCategories();
  }

  Future<void> showCategoryNotes(String categoryId) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OkunanNotPage(categoryId: categoryId),
      ),
    );
  }

  Future<void> showDeleteCategoryDialog(int categoryId) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Kategoriyi Sil'),
          content: Text('Silmek istediğinize emin misiniz? Kategoriye ait bütün notlar silinecek.'),
          actions: [
            TextButton(
              child: Text('Vazgeç'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sil'),
              onPressed: () {
                deleteCategoryAndRefreshList(categoryId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteCategoryAndRefreshList(int categoryId) async {
    await dbHelper.deleteCategory(categoryId);
    setState(() {
      loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategoriler'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Hata: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Kategori bulunamadı'),
            );
          } else {
            categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final categoryId = category['id'];
                final categoryName = category['name'];

                return ListTile(
                  onTap: () {
                    showCategoryNotes(categoryId.toString());
                  },
                  title: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        child: Center(
                          child: Text(
                            '$categoryId',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          categoryName,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDeleteCategoryDialog(categoryId);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}