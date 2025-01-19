part of 'all_destination_bloc.dart';

sealed class AllDestinationEvent extends Equatable {
  const AllDestinationEvent();

  @override
  List<Object> get props => [];
}

class GetAllDestinationEvent extends AllDestinationEvent {}

