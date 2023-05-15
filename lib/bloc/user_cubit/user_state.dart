part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class GetUsersLoadStat extends UserState {}

class GetUsersSuccessStat extends UserState {
  final List<UserModel> list ;
  GetUsersSuccessStat(this.list);
}

class GetUsersErrorStat extends UserState {
  final String error;
  GetUsersErrorStat(this.error);
}



//notification
class SendNotificationLoadStat extends UserState {}

class SendNotificationSuccessStat extends UserState {

}

class SendNotificationErrorStat extends UserState {

}