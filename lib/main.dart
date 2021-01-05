import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'addNote.dart';
import 'editNote.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return HomePage();
        }
        return Placeholder();
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final ref = Firestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => addNote()));
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Note App'),
      ),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.hasData
                    ? snapshot.data.documents.length
                    : 0, //yahi n kar h agar dta nhi to size 0
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => editNote(
                                    docToEdit: snapshot.data.documents[index],
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 150,
                      color: Colors.grey[200],
                      child: Column(
                        children: [
                          Text(snapshot.data.documents[index].get('title')),
                          Text(snapshot.data.documents[index].get('content')),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
