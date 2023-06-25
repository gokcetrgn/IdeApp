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
  List<Map<String, dynamic>> notes = [];
  List<Map<String, dynamic>> searchedNotes = [];
  late Future<List<Map<String, dynamic>>> notesFuture;
  DatabaseHelper dbHelper = DatabaseHelper();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {
    notesFuture = dbHelper.getNotesByCategory(widget.categoryId);
    final List<Map<String, dynamic>> loadedNotes = await notesFuture;
    setState(() {
      notes = loadedNotes;
      searchedNotes = List.from(notes);
    });
  }

  void searchNotes(String searchText) {
    setState(() {
      searchedNotes = notes.where((note) {
        final noteTitle = note['title'].toString().toLowerCase();
        final noteContent = note['content'].toString().toLowerCase();
        return noteTitle.contains(searchText.toLowerCase()) ||
            noteContent.contains(searchText.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notlar'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                searchNotes(value);
              },
              decoration: InputDecoration(
                labelText: 'Not Ara',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchedNotes.length,
              itemBuilder: (context, index) {
                final note = searchedNotes[index];
                final noteId = note['id'];
                final noteTitle = note['title'];
                final noteContent = note['content'];
                final previewTitle = noteTitle.split('\n').take(2).join('\n');
                final previewContent = noteContent.split('\n').take(2).join('\n');

                return ListTile(
                  title: Text(
                    previewTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    previewContent,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
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
            ),
          ),
        ],
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
    loadNotes();
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
    loadNotes();
  }
}