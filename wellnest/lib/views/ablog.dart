import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);
  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Blog").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    return Column(
                      children: snapshot.data!.docs
                          .map((blog) => Card(
                                margin: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(blog["title"]),
                                  trailing: LikeButton(doc: blog),
                                  onTap: () {
                                    // Navigate to the detailed post page and pass the entire BlogPost object
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PostDetailPage(post: blog),
                                      ),
                                    );
                                  },
                                ),
                              ))
                          .toList(),
                    );
                  }
                  return Text(
                    "No blogs yet!",
                    style: GoogleFonts.nunito(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the create post page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePostPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  final QueryDocumentSnapshot doc;

  LikeButton({required this.doc});

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    final QueryDocumentSnapshot d = widget.doc;
    return IconButton(
      icon: const Icon(Icons.thumb_up),
      onPressed: () {
        // Increment the like count when the button is pressed
        setState(() {
          FirebaseFirestore.instance
              .collection("Blog")
              .doc(d.id)
              .update({'likes': FieldValue.increment(1)});
        });
      },
    );
  }
}

class PostDetailPage extends StatefulWidget {
  final QueryDocumentSnapshot post;

  PostDetailPage({required this.post});

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post["title"],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.post["content"],
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 14.0),
            Row(
              children: [
                LikeButton(doc: widget.post),
                const SizedBox(width: 8.0),
                Text('Likes: ${widget.post["likes"]}'),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Comments:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child:
                  CommentSection(comments: List.from(widget.post["comments"])),
            ),
            const SizedBox(height: 8.0),
            CommentForm(
              doc: widget.post,
            ),
          ],
        ),
      ),
    );
  }
}

class CreatePostPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create a blog",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Content'),
                  controller: _mainController,
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Add logic to save the new post
                    FirebaseFirestore.instance.collection("Blog").add({
                      "content": _mainController.text,
                      "title": _titleController.text,
                      "comments": List.from({}),
                      "likes": 0,
                    });
                    Navigator.pop(context); // Return to the previous page
                  },
                  child: const Text('Create Post'),
                ),
              ],
            ),
          ),
        ));
  }
}

class CommentSection extends StatelessWidget {
  final List<String> comments;

  CommentSection({required this.comments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(comments[index]),
          ),
        );
      },
    );
  }
}

class CommentForm extends StatefulWidget {
  final QueryDocumentSnapshot doc;
  CommentForm({required this.doc});

  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final QueryDocumentSnapshot d = widget.doc;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add a Comment:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: _commentController,
          decoration: const InputDecoration(labelText: 'Write your comment here'),
        ),
        const SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {
            String comment = _commentController.text;
            if (comment.isNotEmpty) {
              FirebaseFirestore.instance.collection("Blog").doc(d.id).update({
                'comments': FieldValue.arrayUnion(List.from({comment}))
              });
              _commentController.clear();
            }
          },
          child: const Text('Add Comment'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
