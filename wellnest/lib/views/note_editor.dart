import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wellnest/style/app_style.dart';
import 'package:wellnest/widgets/error_dialogue.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final user = FirebaseAuth.instance.currentUser;
  int colourID = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colourID],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colourID],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Add a New Note', style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                      hintText: 'Note Title'
                ),
                style: AppStyle.mainTitle,
              ),
            const SizedBox(height: 8.0,),
            Text(date, style: AppStyle.dateTitle,),
            const SizedBox(height: 28.0,),

            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Content',
              ),
              style: AppStyle.mainContent,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(226, 220, 222, 1),
        onPressed: () {
          FirebaseFirestore.instance.collection("Notes").add({
            "note_title": _titleController.text,
            "creation_date":date,
            "note_content":_mainController.text,
            "color_id":colourID,
            "UID": user?.uid,
          }).then<void> ((value) {
            Navigator.pop(context);
          }).catchError((error) =>  showErrorDialogue(context, error));
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}