// ignore: file_names
import 'package:ablog/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:ablog/HomePage.dart';

class UploadPhotoPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _UploadPhotoPageState();
  }
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  late File sampleImage;
  String url = "";
  // ignore: unused_field
  late String _myValue = "";

  final formKey = new GlobalKey<FormState>();

  Future<void> getImage() async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        var tempImage = File(pickedFile.path!);
        setState(() {
          sampleImage = tempImage;
        });
      } else {
        print('No image selected.');
        // Handle the case where the user canceled image selection
      }
    } catch (e) {
      setState(() {
        print('Error picking image: $e');
      });
    }
  }

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void uploadStatusImage() async
  {
    if(validateAndSave())
    {
      //final StorageReference postImageRef = FirebaseStorage.instance.ref().child("Post Images");
      final Reference postImageRef = FirebaseStorage.instance.ref().child("Post Images");
      var timeKey = new DateTime.now();
      final UploadTask uploadTask = postImageRef.child(timeKey.toString() + ".jpg").putFile(sampleImage);

      //var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      var imageUrl = await uploadTask.whenComplete(() {}).then((_) => postImageRef.getDownloadURL());

      url = imageUrl.toString();

      print("Image Url = " + url);

      goToHomePage();
      
      saveToDatabase(url);
    }
  }

  void saveToDatabase(url)
  {
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = 
    {
      "image": url,
      "description": _myValue,
      "date": date,
      "time": time,
    };

    ref.child("Posts").push().set(data);
  }

  void goToHomePage()
  {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage(auth: Auth(), onSignedOut: (){}),),
      );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Upload Image"),
        centerTitle: true,
      ),
      body: new Center(
        child: sampleImage == null ? Text("Select an Image") : enableUpload(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Add Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Image.file(sampleImage, height: 330.0, width: 660.0),
            SizedBox(height: 15.0,),
            TextFormField(
              decoration: new InputDecoration(labelText: 'Description'),
              validator: (value) {
                return value!.isEmpty ? 'Blog Description is required' : null;
              },
              onSaved: (value) {
                _myValue = value!;
              },
            ),
            SizedBox(height: 15.0,),
            ElevatedButton(
              child: Text("Add a new post", style: TextStyle(color: Colors.white)),
              onPressed: uploadStatusImage,
            )
          ],
        ),
      ),
    );
  }
}
