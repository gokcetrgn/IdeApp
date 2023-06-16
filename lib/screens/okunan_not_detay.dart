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
        title: Text(widget.noteTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Başlık',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'İçerik',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _updateNote();
              },
              child: Text('Kaydet'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteNote();
              },
              child: Text('Sil'),
            ),
          ],
        ),
      ),
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