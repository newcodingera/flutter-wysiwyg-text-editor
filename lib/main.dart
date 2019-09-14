import 'package:flutter/material.dart';
import 'editor_page.dart';
import 'models/note_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Note> _notesList = List();

  void _add(Note note) {
    setState(() {
      // Insert new notes at the start
      _notesList.insert(0, note);
    });
  }

  void _update(int index, Note updatedNote) {
    setState(() {
      _notesList.removeAt(index);
      _notesList.insert(index, updatedNote);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyNotes',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: _notesList.length == 0
            ? Center(
                child: Text("Tap on + button to add new notes"),
              )
            : _getNotesList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => EditorPage(add: _add)),
          );
        },
        tooltip: 'Add New Notes',
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _getNotesList() {
    return ListView.builder(
      itemCount: _notesList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(Icons.note),
          title: Text(
            _notesList[index].title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            _notesList[index].document.toPlainText(),
            maxLines: 1,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => EditorPage(
                  update: _update,
                  noteIndex: index,
                  note: _notesList[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
