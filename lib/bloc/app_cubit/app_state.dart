part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class HomeGetDataLoad extends AppState {}
class HomeLoadDataSuccess extends AppState {
}
class HomeLoadDataError extends AppState {}