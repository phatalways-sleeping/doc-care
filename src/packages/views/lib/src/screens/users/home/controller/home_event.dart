// ignore_for_file: public_member_api_docs

part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class DataLoadingEvent extends HomeEvent {
  const DataLoadingEvent();
}