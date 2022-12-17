import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_delete_update_event.dart';
part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  AddDeleteUpdateBloc() : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
