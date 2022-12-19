part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdateEvent extends Equatable {
  const AddDeleteUpdateEvent();

  @override
  List<Object> get props => [];
}

class AddEvent extends AddDeleteUpdateEvent {
  final PostEntity post;

  const AddEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class UpdateEvent extends AddDeleteUpdateEvent {
  final PostEntity post;

  const UpdateEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class DeleteEvent extends AddDeleteUpdateEvent {
  final int id;

  const DeleteEvent({required this.id});
  @override
  List<Object> get props => [id];
}
