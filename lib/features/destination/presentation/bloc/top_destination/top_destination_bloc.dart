import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel/features/destination/domain/entities/destination_entity.dart';

import '../../../domain/usecases/get_top_destination_usecase.dart';

part 'top_destination_event.dart';
part 'top_destination_state.dart';

class TopDestinationBloc extends Bloc<TopDestinationEvent, TopDestinationState> {
  final GetTopDestinationUsecase _useCase;

  TopDestinationBloc(this._useCase) : super(TopDestinationInitial()) {
    on<GetTopDestinationEvent>((event, emit) async {
      emit(TopDestinationLoading());
      final result = await _useCase.execute(); //karna callable boleh kayak gini
      result.fold(
        (failure) => emit(TopDestinationFailure(message: failure.message)),
        (data) => emit(TopDestinationLoaded(data: data))
      );
    });
  }
}
