import 'package:flutter/material.dart';
import 'package:ideapp/database/database_helper.dart';
import 'okunan_not.dart';

class NotlarPage extends StatefulWidget {
  @override
  _NotlarPageState createState() => _NotlarPageState();
}

class _NotlarPageState extends State<NotlarPage> {
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> searchedCategories = [];
  late Future<List<Map<String, dynamic>>> categoriesFuture;
  DatabaseHelper dbHelper = DatabaseHelper();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    categoriesFuture = dbHelper.getAllCategories();
    final List<Map<String, dynamic>> loadedCategories = await categoriesFuture;
    setState(() {
      categories = loadedCategories;
      searchedCategories = List.from(categories);
    });
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
    loadCategories();
  }

  Future<void> editCategoryName(int categoryId) async {
    final TextEditingController _nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Kategori Adını Düzenle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                maxLength: 25, // Maksimum 25 karakter sınırlaması
                decoration: InputDecoration(hintText: 'Yeni Kategori Adı'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Kaydet'),
              onPressed: () {
                final newName = _nameController.text.trim();
                if (newName.isNotEmpty) {
                  dbHelper.updateCategoryName(categoryId, newName);
                  loadCategories();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void searchCategories(String searchText) {
    setState(() {
      searchedCategories = categories.where((category) {
        final categoryName = category['name'].toString().toLowerCase();
        return categoryName.contains(searchText.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategoriler'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                searchCategories(value);
              },
              decoration: InputDecoration(
                labelText: 'Kategori Ara',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchedCategories.length,
              itemBuilder: (context, index) {
                final category = searchedCategories[index];
                final categoryId = category['id'];
                final categoryName = category['name'];

                return ListTile(
                  onTap: () {
                    showCategoryNotes(categoryId.toString());
                  },
                  title: Row(
                    children: [
                      if (searchController.text.isEmpty) // Sadece ana listede numaralandırma yap
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      if (searchController.text.isNotEmpty) // Arama sonuçlarında mavi bir küre göster
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                        ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Container(
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
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          editCategoryName(categoryId);
                        },
                        iconSize: 18,
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDeleteCategoryDialog(categoryId);
                        },
                        iconSize: 18,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}