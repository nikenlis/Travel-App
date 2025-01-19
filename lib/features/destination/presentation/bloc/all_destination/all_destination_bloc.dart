import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel/features/destination/domain/entities/destination_entity.dart';
import 'package:travel/features/destination/domain/usecases/get_all_destination_usecase.dart';

part 'all_destination_event.dart';
part 'all_destination_state.dart';

class AllDestinationBloc extends Bloc<AllDestinationEvent, AllDestinationState> {
  final GetAllDestinationUsecase _useCase;

  AllDestinationBloc(this._useCase) : super(AllDestinationInitial()) {
    on<GetAllDestinationEvent>((event, emit) async {
      emit(AllDestinationLoading());
      final result = await _useCase.execute(); //karna callable boleh kayak gini
      result.fold(
        (failure) => emit(AllDestinationFailure(message: failure.message)),
        (data) => emit(AllDestinationLoaded(data: data))
      );

    });
  }
}
