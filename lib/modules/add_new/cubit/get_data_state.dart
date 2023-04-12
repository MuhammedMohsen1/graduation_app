part of 'get_data_cubit.dart';

@immutable
abstract class GetDataState {}

class GetDataInitial extends GetDataState {}

class GetDataNavigateToGoal extends GetDataState {}

class GetDataCollectingData extends GetDataState {}

class GetDataNavigateBack extends GetDataState {}

class GetDataDone extends GetDataState {}

class GetDataError extends GetDataState {}

class GetDataUpdateLocation extends GetDataState {}
