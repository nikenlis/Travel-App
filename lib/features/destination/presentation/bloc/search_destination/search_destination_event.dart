part of 'search_destination_bloc.dart';

sealed class SearchDestinationEvent extends Equatable {
  const SearchDestinationEvent();

  @override
  List<Object> get props => [];
}

class GetSearchDestinationEvent extends SearchDestinationEvent {
  final String query;

  GetSearchDestinationEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class GetResetSearchDestination extends SearchDestinationEvent {

}