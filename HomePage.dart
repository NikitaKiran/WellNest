import 'package:ablog/Authentication.dart';
import 'package:ablog/Mapping.dart';
import 'package:ablog/PhotoUpload.dart';
import 'package:flutter/material.dart';
import 'package:ablog/Posts.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'PhotoUpload.dart';

class HomePage extends StatefulWidget
{
  HomePage
  ({
    required this.auth,
    required this.onSignedOut,
  });

  final AuthImplementation auth;
  final VoidCallback onSignedOut;
  @override
    State<StatefulWidget> createState()
    {
      return _HomePageState();
    }
}

class _HomePageState extends State<HomePage> {
  List<Posts> postsList = [];

  @override
  void initState() {
    super.initState();

    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Posts");
    postsRef.once().then((DatabaseEvent event) 
    {
      DataSnapshot snap = event.snapshot;
      var KEYS = (snap.value as Map?)?.keys ?? [];
      var DATA = snap.value;

       //for (var individualKey in KEYS) {
      //   // ignore: unnecessary_new
        //  Posts posts = new Posts(
        //    DATA[individualKey]['image'],
        //    //DATA[individualKey] != null ? DATA[individualKey]['image'] : null,
        //    DATA[individualKey]['description'],
      //     DATA[individualKey]['date'],
      //     DATA[individualKey]['time'],
      //   );

      //   postsList.add(posts);
      // }

//       for (var individualKey in KEYS) {
//         var postData = DATA[individualKey];
//         if (postData is Map<String, dynamic> && postData.isNotEmpty) {
//           // Posts posts = new Posts(
//           //   postData['image'] ?? '',
//           //   postData['description'] ?? '',
//           //   postData['date'] != null ? DateTime.parse(postData['date']) : null,
//           //   postData['time'] != null ? DateTime.parse(postData['time']) : null,
//           // );
//           Posts posts = new Posts(
//           postData['image'] ?? '',
//           postData['description'] ?? '',
//           postData['date'] != null ? DateTime.parse(postData['date']) : DateTime.now(),
//           postData['time'] != null ? DateTime.parse(postData['time']) : DateTime.now(),
//         );

//     postsList.add(posts);
//   }
// }
     for (var individualKey in KEYS) {
       var postData = DATA[individualKey] as Map<String, dynamic>?;

       if (postData != null) {
         Posts posts = new Posts(
           postData['image'] as String? ?? '',
           postData['description'] as String? ?? '',
           postData['date'] as String? ?? '',
           postData['time'] as String? ?? '',
         );

         postsList.add(posts);

   }
 }

// for (var individualKey in KEYS) {
//   var data = DATA[individualKey];

//   if (data is Map<String, dynamic>) {
//     var postData = data as Map<String, dynamic>?;

//     Posts posts = new Posts(
//       postData?['image'] as String? ?? '',
//       postData?['description'] as String? ?? '',
//       (postData?['date'] != null ? DateTime.parse(postData?['date'] as String) : null) as String,
//       (postData?['time'] != null ? DateTime.parse(postData?['time'] as String) : null) as String,
//     );

//     postsList.add(posts);
//   }
// }




  setState(() {
        print("Length: $postsList.length");
      });
    });
  }

  void _logoutUser() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Container(
        child: postsList.length == 0
            ? Text("No Blog Post available")
            : ListView.builder(
                itemCount: postsList.length,
                itemBuilder: (_, index) {
                  return PostsUI(
                    postsList[index].image,
                    postsList[index].description,
                    postsList[index].date,
                    postsList[index].time,
                  );
                },
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Container(
          margin: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.local_car_wash),
                iconSize: 50,
                color: Colors.white,
                onPressed: _logoutUser,
              ),
              IconButton(
                icon: Icon(Icons.add_a_photo),
                iconSize: 40,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return UploadPhotoPage();
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget PostsUI(String image, String description, String date, String time) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child: Container(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  date,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
                Text(
                  time,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
                
              ],
            ),
            SizedBox(height: 10.0,),
            Image.network(image, fit: BoxFit.cover),
            SizedBox(height: 10.0,),
            Text(
                  description,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
          ],
        ),
      ),
    );
  }
}