import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_bloc/features/post/domain/entities/post.dart';
import 'package:todo_bloc/features/post/domain/repository/post_repo.dart';

class FirebasePostRepository implements PostRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference postCollection = FirebaseFirestore.instance
      .collection('posts');

  @override
  Future<void> createPost(Post post) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<void> deletePost(String postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> fetchAllPosts() {
    // TODO: implement fetchAllPosts
    throw UnimplementedError();
  }

  @override
  Future<void> fetchPostByUserId(String userId) {
    // TODO: implement fetchPostByUserId
    throw UnimplementedError();
  }
}
