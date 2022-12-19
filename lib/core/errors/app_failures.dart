abstract class Failure {
  String get message => '';
}

class OfflineFailure extends Failure {
  @override
  String get message => 'No Internet Connection';
}

class ServerFailure extends Failure {
  @override
  String get message => 'Server Failed Please Try Again Later';
}

class EmptyCacheFailure extends Failure {
  @override
  String get message => 'No Internet Connection and Cached Data';
}

class UnExpectedFailure extends Failure {
  @override
  String get message => 'Something Went Wrong Please Try Again Later';
}
