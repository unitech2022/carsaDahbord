

import '../../models/rate_response.dart';
import '../../models/workshop_model.dart';

abstract class WorkshopState {}

class WorkshopStateInitial extends WorkshopState {}

class GetCategoriesLoad extends WorkshopState {}

class GetCategoriesSuccess extends WorkshopState {}

class GetCategoriesError extends WorkshopState {}

class GetWorkshopByIdLoad extends WorkshopState {}

class GetWorkshopByIdSuccess extends WorkshopState {
  final List<Workshops> workshops;
  GetWorkshopByIdSuccess(this.workshops);
}

class GetWorkshopByIdError extends WorkshopState {
  final String message;
  GetWorkshopByIdError(this.message);
}


//UpdateWorkShop

class UpdateWorkShopLoad extends WorkshopState {}

class UpdateWorkShopSuccess extends WorkshopState {

}

class UpdateWorkShopError extends WorkshopState {

}

// add  post
class AddWorkshopDataLoad extends WorkshopState {}

class AddWorkshopDataSuccess extends WorkshopState {}

class AddWorkshopDataError extends WorkshopState {}

class ChangeIndexState extends WorkshopState {}

// get Rating
class RatingWorkshopLoad extends WorkshopState {}

class RatingWorkshopSuccess extends WorkshopState {
  final List<RateResponse> rats;
  RatingWorkshopSuccess(this.rats);
}

class RatingWorkshopError extends WorkshopState {}

// add rate
class AddRateWorkshopLoad extends WorkshopState {}

class AddRateWorkshopSuccess extends WorkshopState {
  final String message;
  AddRateWorkshopSuccess(this.message);
}

class AddRateWorkshopError extends WorkshopState {}

// update rate
class UpdateRateWorkshopLoad extends WorkshopState {}

class UpdateRateWorkshopSuccess extends WorkshopState {
  final String message;
  UpdateRateWorkshopSuccess(this.message);
}

class UpdateRateWorkshopError extends WorkshopState {}
