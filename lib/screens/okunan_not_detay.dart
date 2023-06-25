import 'package:flutter/material.dart';
import 'package:ideapp/database/database_helper.dart';

class DuzenlemeSayfasi extends StatefulWidget {
  final String noteTitle;
  final String noteContent;
  final int noteId; // noteId değeri artık null olmayacak

  DuzenlemeSayfasi({required this.noteTitle, required this.noteContent, required this.noteId});

  @override
  _DuzenlemeSayfasiState createState() => _DuzenlemeSayfasiState();
}

class _DuzenlemeSayfasiState extends State<DuzenlemeSayfasi> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.noteTitle;
    _contentController.text = widget.noteContent;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Düzenleme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Başlık',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              constraints: BoxConstraints(minHeight: 50, maxHeight: double.infinity),
              child: SingleChildScrollView(
                child: TextField(
                  controller: _titleController,
                  maxLength: 100,
                  maxLines: null,
                  decoration: InputDecoration(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'İçerik',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _updateNote();
                    },
                    child: Text('Kaydet'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showDeleteConfirmationDialog();
                    },
                    child: Text('Sil'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Silme Onayı'),
          content: Text('Bu notu silmek istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // İletişim kutusunu kapat
              },
              child: Text('Vazgeç'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // İletişim kutusunu kapat
                _deleteNote(); // Notu sil
              },
              child: Text('Sil'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateNote() async {
    String newTitle = _titleController.text;
    String newContent = _contentController.text;

    await dbHelper.updateNote(widget.noteId, newTitle, newContent); // widget.noteId doğru değeri kullanarak güncelleme yapılıyor

    Navigator.pop(context);
  }

  Future<void> _deleteNote() async {
    await dbHelper.deleteNote(widget.noteId); // widget.noteId doğru değeri kullanarak silme işlemi yapılıyor

    Navigator.pop(context);
  }
}