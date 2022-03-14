import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:final_app/first_screen.dart';

class ThirdScreen extends StatelessWidget {
  final _TextController = TextEditingController();
  void _addTask() async {
    final task = _TextController.text;
    FirebaseFirestore.instance.collection('Todos').add({'Activity': task});
    _TextController.clear();
  }

  Widget _toDoList(QuerySnapshot snapshot) {
    return ListView.builder(
        itemCount: snapshot.docs.length,
        itemBuilder: (context, index) {
          final document = snapshot.docs[index];
          return Dismissible(
              key: Key(document.id),
              child: ListTile(
                title: Text(document['Activity']),
              ),
              onDismissed: (direction) {
                FirebaseFirestore.instance
                    .collection('Todos')
                    .doc(document.id)
                    .delete();
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text('Third screen')),
      body: Container(
          child: Column(
        children: [
          ElevatedButton(
            child: Text('Return to Home'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirstScreen()),
              );
            },
          ),
          Row(
            children: [
              Expanded(
                  child: TextField(
                controller: _TextController,
                decoration: InputDecoration(
                    labelText: 'Enter a task (Slide task to delete it!)'),
              )),
              ElevatedButton(
                child: Text('Add'),
                onPressed: () {
                  _addTask();
                },
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Todos').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return Expanded(
                child: _toDoList(snapshot.data),
              );
            },
          )
        ],
      )),
    ));
  }
}
