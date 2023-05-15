part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}
class GetCategoriesSuccessStat extends CategoryState {
  final List<CategoryModel> list ;
  GetCategoriesSuccessStat(this.list);
}

class GetCategoriesErrorStat extends CategoryState {
  final String error;
  GetCategoriesErrorStat(this.error);
}

class GetCategoriesLoadStat extends CategoryState {}



//Add Category

class AddCategoriesLoadStat extends CategoryState {}

class AddCategoriesSuccessStat extends CategoryState {
  final String success;

  AddCategoriesSuccessStat(this.success);
}
class AddCategoriesErrorStat extends CategoryState {

  final String error;

  AddCategoriesErrorStat(this.error);
}



//upload image
class UpdateCategoriesLoadImageStat extends CategoryState {}
class UpdateCategoriesLoadedImageStat extends CategoryState {
  final String image;

  UpdateCategoriesLoadedImageStat(this.image);
}
class UpdateCategoriesLoadErrorImageStat extends CategoryState {}
//delete
class DeleteCategoriesLoadStat extends CategoryState {}
class DeleteCategoriesSuccessStat extends CategoryState {
  final String success;

  DeleteCategoriesSuccessStat(this.success);
}
class DeleteCategoriesErrorStat extends CategoryState {

  final String error;

  DeleteCategoriesErrorStat(this.error);
}

// update
class UpdateCategoriesLoadStat extends CategoryState {}

class UpdateCategoriesSuccessStat extends CategoryState {
  final String success;

  UpdateCategoriesSuccessStat(this.success);
}
class UpdateCategoriesErrorStat extends CategoryState {

  final String error;

  UpdateCategoriesErrorStat(this.error);
}

//app
class ChangeValueSubCategory extends CategoryState {}

// brands
class GetBrandsSuccessStat extends CategoryState {
  final List<CategoryModel> list ;
  GetBrandsSuccessStat(this.list);
}

class GetBrandsErrorStat extends CategoryState {
  final String error;
  GetBrandsErrorStat(this.error);
}

class GetBrandsLoadStat extends CategoryState {}