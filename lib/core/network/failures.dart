import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {}

class OfflineFailure extends Failures {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failures {
  @override
  List<Object?> get props => [];
}

class AddFailure extends Failures {
  @override
  List<Object?> get props => [];
}
class RemoveFailure extends Failures {
  @override
  List<Object?> get props => [];
}

class WrongPassword extends Failures {
  @override
  List<Object?> get props => [];
}


