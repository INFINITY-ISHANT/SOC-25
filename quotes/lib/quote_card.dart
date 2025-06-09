import 'package:flutter/material.dart';
import 'quote.dart';

class NewCard extends StatelessWidget {

  final Quote quote;
  final VoidCallback? delete;
  NewCard({required this.quote, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text(
                quote.text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            Center(
              child: Text(
                quote.author,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: delete,
              icon: Icon(Icons.delete),
              label: Text('Delete the quote'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(           // Rounded corners
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
