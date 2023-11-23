import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);
  @override
  State<BlogPage> createState() => _BlogPageState();
}

class BlogPost {
  final String title;
  final String content;
  int likes;
  List<String> comments;

  BlogPost({required this.title, required this.content, this.likes = 0, this.comments = const []});
}

class _BlogPageState extends State<BlogPage>{
  final List<BlogPost> blogPosts = [
    BlogPost(
      title: 'My struggles with insomnia',
      content: "Struggling with insomnia has been a constant battle, disrupting my nights and impacting my daily life. The relentless cycle of restlessness and fatigue creates a profound sense of frustration. Countless nights are spent tossing and turning, unable to find solace in sleep. The consequences extend beyond the bedroom, infiltrating my concentration and overall well-being. Despite trying various remedies, from calming teas to meditation, insomnia persists as a formidable adversary. The elusive nature of a good night's sleep has become a defining challenge, requiring resilience and adaptability. I've learned to appreciate the importance of establishing healthy sleep habits and seeking support to navigate the complexities of insomnia.",
      comments: ['More power to you', 'totally relate to you'],
    ),
    BlogPost(
      title: 'Conquering Procrastination',
      content: "Conquering procrastination is a transformative journey towards reclaiming productivity and achieving personal goals. Acknowledging the habit's grip, I embarked on a mission to break free. Establishing a structured routine and setting realistic deadlines became my compass. Breaking tasks into smaller, manageable steps alleviated the overwhelming burden. Embracing the power of prioritization and focus, I learned to navigate distractions. Cultivating a positive mindset and celebrating small victories reinforced my commitment. With discipline as my ally, I witnessed procrastination's grip loosen, paving the way for efficiency and accomplishment. The journey isn't linear, but each conquered procrastination is a step closer to success.",
      comments: ['Thanks for sharing your journey.. I thought that I was the only one going through this', 'Thanks for the tips.'],
    ),
    // Add more posts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Home'),
      ),
      body: ListView.builder(
        itemCount: blogPosts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(blogPosts[index].title),
              trailing: LikeButton(blogPost: blogPosts[index]),
              onTap: () {
                // Navigate to the detailed post page and pass the entire BlogPost object
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailPage(post: blogPosts[index]),
                  ),
                );
              },
            ),
          );
        },
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
        child: Icon(Icons.add),
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  final BlogPost blogPost;

  LikeButton({required this.blogPost});

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.thumb_up),
      onPressed: () {
        // Increment the like count when the button is pressed
        setState(() {
          widget.blogPost.likes++;
        });
      },
    );
  }
}

class PostDetailPage extends StatefulWidget {
  final BlogPost post;

  PostDetailPage({required this.post});

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  List<String> _newComments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              widget.post.content,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                LikeButton(blogPost: widget.post),
                SizedBox(width: 8.0),
                Text('Likes: ${widget.post.likes}'),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Comments:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: CommentSection(comments: widget.post.comments),
            ),
            SizedBox(height: 8.0),
            CommentForm(
              onCommentAdded: (comment) {
                setState(() {
                  widget.post.comments.add(comment);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CreatePostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How are you feeling today?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add logic to save the new post
                Navigator.pop(context); // Return to the previous page
              },
              child: Text('Create Post'),
            ),
          ],
        ),
      ),
      )
    );
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
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(comments[index]),
          ),
        );
      },
    );
  }
}

class CommentForm extends StatefulWidget {
  final Function(String) onCommentAdded;

  CommentForm({required this.onCommentAdded});

  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add a Comment:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        TextFormField(
          controller: _commentController,
          decoration: InputDecoration(labelText: 'Write your comment here'),
        ),
        SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {
            String comment = _commentController.text;
            if (comment.isNotEmpty) {
              widget.onCommentAdded(comment);
              _commentController.clear();
            }
          },
          child: Text('Add Comment'),
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
