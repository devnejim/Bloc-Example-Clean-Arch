part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdateState extends Equatable {
  const AddDeleteUpdateState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdateInitial extends AddDeleteUpdateState {}

class LoadingState extends AddDeleteUpdateState {}

class SuccessState extends AddDeleteUpdateState {
  final String successMessage;

  const SuccessState({required this.successMessage});
}

class ErrorState extends AddDeleteUpdateState {
  final String errorMessage;

  const ErrorState({required this.errorMessage});
}
