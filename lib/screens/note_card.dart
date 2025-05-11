import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.noteColor,
    required this.onDelete,
  });
  final Map<String, dynamic> note;
  final Function onDelete;
  final Function onTap;
  final List<Color> noteColor;

  @override
  Widget build(BuildContext context) {
    final colorIndex = note['color'] as int;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: noteColor[colorIndex],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note['date'],
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
            const SizedBox(height: 8),
            Text(
              note['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 8),

            Expanded(
              child: Text(
                note['description'],
                style: const TextStyle(color: Colors.black54, height: 1.5),
                overflow: TextOverflow.fade,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => onDelete(),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.black54,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
