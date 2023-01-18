class PostsApi {
  static const baseUrl = 'https://jsonplaceholder.typicode.com';

  static String addOrUpdatePostUri = '$baseUrl/posts/';

  static String deletePostUri(String id) {
    return '$baseUrl/posts/$id';
  }

  static String paginatedPostsUri([int start = 0, int limit = 10]) {
    return '$baseUrl/posts?_start=$start&_limit=$limit';
  }

  static String commentsUri = '$baseUrl/comments/';
}
