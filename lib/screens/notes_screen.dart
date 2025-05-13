import 'dart:developer';

// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:notes_app/screens/note_card.dart';
import 'package:notes_app/screens/notes_dialog.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Map<String, dynamic>> notes = [];
  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  int index = 0;
  final items = <Widget>[
    Icon(Icons.notes, size: 30),
    Icon(Icons.add_box, size: 30),
  ];

  Future<void> fetchNotes() async {
    try {
      debugPrint('🔍 Fetching notes...');
      final fetchedNotes = await NotesDatabase.instance.getNotes();
      debugPrint('Fetched ${fetchedNotes.length} notes.');
      setState(() {
        notes = fetchedNotes;
      });
    } catch (e, stack) {
      debugPrint('❌ Error fetching notes: $e');
      debugPrint('📌 Stack: $stack');
    }
  }

  final List<Color> noteColors = [
    Color(0xFFFFCDD2), // Light Red
    Color(0xFFF8BBD0), // Pink
    Color(0xFFE1BEE7), // Lavender Purple
    Color(0xFFD1C4E9), // Soft Purple
    Color(0xFFC5CAE9), // Light Indigo
    Color(0xFFBBDEFB), // Light Blue
    Color(0xFFB3E5FC), // Sky Blue
    Color(0xFFB2EBF2), // Cyan
    Color(0xFFB2DFDB), // Teal
    Color(0xFFC8E6C9), // Light Green
    Color(0xFFDCEDC8), // Greenish Yellow
    Color(0xFFFFF9C4), // Light Yellow
    Color(0xFFFFECB3), // Light Amber
    Color(0xFFFFCCBC), // Soft Orange
    Color(0xFFD7CCC8), // Warm Grey
    Color(0xFFCFD8DC), // Cool Grey
  ];

  void showNoteDialog({
    int? id,
    String? title,
    String? content,
    int colorIndex = 0,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return NotesDialog(
          colorIndex: colorIndex,
          noteColors: noteColors,
          noteId: id,
          title: title,
          content: content,
          onNoteSaved: (
            newTitle,
            newDescription,
            currentDate,
            newColorIndex,
          ) async {
            if (id == null) {
              log('DEBUG: title = $newTitle');
              log('DEBUG: description = $newDescription');
              log('DEBUG: date = $currentDate', level: 2);
              log('DEBUG: color = $newColorIndex');

              await NotesDatabase.instance.addNote(
                newTitle,
                newDescription,
                currentDate,
                newColorIndex,
              );
            } else {
              log('DEBUG: title = $newTitle');
              log('DEBUG: description = $newDescription');
              log('DEBUG: date = $currentDate');
              log('DEBUG: color = $newColorIndex');

              await NotesDatabase.instance.updateNote(
                newTitle,
                newDescription,
                currentDate,
                newColorIndex,
                id,
              );
            }
            fetchNotes();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        title: const Text(
          'Notes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/todolist_screen'),
            backgroundColor: Colors.deepPurple[100],
            child: const Icon(Icons.notes, color: Colors.black87),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              showNoteDialog();
            },
            backgroundColor: Colors.white,
            child: const Icon(Icons.add, color: Colors.black87),
          ),
        ],
      ),

      body:
          notes.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notes_outlined,
                      size: 80,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(height: 20),

                    Text(
                      'No Notes Found',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return NoteCard(
                      note: note,
                      onTap: () {
                        showNoteDialog(
                          id: note['id'],
                          title: note['title'],
                          content: note['description'],
                          colorIndex: note['color'],
                        );
                      },
                      noteColor: noteColors,
                      onDelete: () async {
                        await NotesDatabase.instance.deleteNote(note['id']);
                        fetchNotes();
                      },
                    );
                  },
                ),
              ),
    );
  }
}
