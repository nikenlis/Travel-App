import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel/features/destination/domain/usecases/get_search_destination_usecase.dart';

import '../../../domain/entities/destination_entity.dart';

part 'search_destination_event.dart';
part 'search_destination_state.dart';

class SearchDestinationBloc extends Bloc<SearchDestinationEvent, SearchDestinationState> {
  final GetSearchDestinationUsecase _useCase;

  SearchDestinationBloc(this._useCase) : super(SearchDestinationInitial()) {
    on<GetSearchDestinationEvent>((event, emit) async {
       emit(SearchDestinationLoading());
      final result = await _useCase.execute(query: event.query); //karna callable boleh kayak gini
      result.fold(
        (failure) => emit(SearchDestinationFailure(message: failure.message)),
        (data) => emit(SearchDestinationLoaded(data: data))
      );
    });

     on<GetResetSearchDestination>((event, emit) async {
       emit(SearchDestinationInitial());
    });
  }
}
