import 'package:flutter/material.dart';

class NoteDetailsWidget extends StatefulWidget{
  final int noteId;

  const NoteDetailsWidget({super.key, required this.noteId});

  @override
  State<NoteDetailsWidget> createState() => _NoteDetailsWidgetState();
}

class _NoteDetailsWidgetState extends State<NoteDetailsWidget>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteId.toString()),
      )
    );
  }
}