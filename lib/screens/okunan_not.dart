import 'package:flutter/material.dart';
import 'package:ideapp/database/database_helper.dart';
import 'okunan_not_detay.dart';

class OkunanNotPage extends StatefulWidget {
  final String categoryId;

  OkunanNotPage({required this.categoryId});

  @override
  _OkunanNotPageState createState() => _OkunanNotPageState();
}

class _OkunanNotPageState extends State<OkunanNotPage> {
  late Future<List<Map<String, dynamic>>> notesFuture;
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {
    notesFuture = dbHelper.getNotesByCategory(widget.categoryId);
    setState(() {}); // State'i güncelle
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notlar'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: notesFuture,
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
              child: Text('Not bulunamadı'),
            );
          } else {
            final notes = snapshot.data!;
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                final noteId = note['id'];
                final noteTitle = note['title'];
                final noteContent = note['content'];

                return ListTile(
                  title: Text(noteTitle),
                  subtitle: Text(noteContent),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteNoteDialog(context, noteId);
                    },
                  ),
                  onTap: () async {
                    await _navigateToNoteDetail(context, noteTitle, noteContent, noteId);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void _deleteNoteDialog(BuildContext context, int noteId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Notu Sil'),
          content: Text('Bu notu silmek istediğinize emin misiniz?'),
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
                _deleteNoteAndRefreshList(noteId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteNoteAndRefreshList(int noteId) async {
    await dbHelper.deleteNote(noteId);
    loadNotes(); // Notları yeniden yükle
  }

  Future<void> _navigateToNoteDetail(BuildContext context, String noteTitle, String noteContent, int noteId) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DuzenlemeSayfasi(
          noteTitle: noteTitle,
          noteContent: noteContent,
          noteId: noteId,
        ),
      ),
    );
    loadNotes(); // Notları yeniden yükle
  }
}