part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}
class GetDataLoadLoad extends SettingState {}
class GetDataLoadSuccess extends SettingState {
}
class GetDataLoadError extends SettingState {}



//Add Category

class AddSettingLoadStat extends SettingState {}

class AddSettingSuccessStat extends SettingState {

}
class AddSettingErrorStat extends SettingState {


}



// //upload image
// class UpdateSettingLoadImageStat extends SettingState {}
// class UpdateSettingLoadedImageStat extends SettingState {
//   final String image;
//
//   UpdateSettingLoadedImageStat(this.image);
// }
// class UpdateSettingLoadErrorImageStat extends SettingState {}
//
class DeleteSettingLoadStat extends SettingState {}
class DeleteSettingSuccessStat extends SettingState {

}
class DeleteSettingErrorStat extends SettingState {}

// update
class UpdateSettingLoadStat extends SettingState {}

class UpdateSettingSuccessStat extends SettingState {

}
class UpdateSettingErrorStat extends SettingState {


}