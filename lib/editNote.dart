import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class editNote extends StatefulWidget {
  DocumentSnapshot docToEdit;
  editNote({this.docToEdit});
  @override
  _editNoteState createState() => _editNoteState();
}

class _editNoteState extends State<editNote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

//  CollectionReference ref = Firestore.instance.collection('notes');

  @override
  void initstate() {
    title = TextEditingController(
        text: widget.docToEdit.get('title')); // aysie hona chahiye
    content = TextEditingController(text: widget.docToEdit.get('content'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () {
              widget.docToEdit.reference.updateData({
                'title': title.text,
                'content': content.text
              }).whenComplete(() => Navigator.pop(context));
//              ref.add({'title': title.text, 'content': content.text});
            },
            child: Text('Save'),
          ),
          FlatButton(
            onPressed: () {
              widget.docToEdit.reference
                  .delete()
                  .whenComplete(() => Navigator.pop(context));
//              ref.add({'title': title.text, 'content': content.text});
            },
            child: Text('Delete'),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: title,
                decoration: InputDecoration(hintText: 'Title'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: content,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(hintText: 'Content'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
