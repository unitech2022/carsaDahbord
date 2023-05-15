part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}
class GetProductsSuccessStat extends ProductState {
  final List<ProducteModel> list ;
  GetProductsSuccessStat(this.list);
}

class GetProductsErrorStat extends ProductState {
  final String error;
  GetProductsErrorStat(this.error);
}

class GetProductsLoadPaginationStat extends ProductState {}



class GetProductsSuccessPaginationStat extends ProductState {
  final ResponsePagination responsePagination ;
  GetProductsSuccessPaginationStat(this.responsePagination);
}

class GetProductsErrorPaginationStat extends ProductState {
  final String error;
  GetProductsErrorPaginationStat(this.error);
}

class GetProductsLoadStat extends ProductState {}


//Add Category

class AddProductLoadStat extends ProductState {}

class AddProductSuccessStat extends ProductState {
  final String success;

  AddProductSuccessStat(this.success);
}
class AddProductErrorStat extends ProductState {

  final String error;

  AddProductErrorStat(this.error);
}



//upload ProductState
class UpdateProductLoadImageStat extends ProductState {}
class UpdateProductLoadedImageStat extends ProductState {
  final String image;

  UpdateProductLoadedImageStat(this.image);
}
class UpdateProductLoadErrorImageStat extends ProductState {}
//delete
class DeleteProductLoadStat extends ProductState {}
class DeleteProductSuccessStat extends ProductState {
  final String success;

  DeleteProductSuccessStat(this.success);
}
class DeleteProductErrorStat extends ProductState {

  final String error;

  DeleteProductErrorStat(this.error);
}

// update
class UpdateProductLoadStat extends ProductState {}

class UpdateProductSuccessStat extends ProductState {
  final String success;

  UpdateProductSuccessStat(this.success);
}
class UpdateProductErrorStat extends ProductState {

  final String error;

  UpdateProductErrorStat(this.error);
}


class ChangeCheckBox extends ProductState {}


class GetCarModelsLoad extends ProductState {}
class GetCarModelsSuccess extends ProductState {}
class GetCarModelsError extends ProductState {}



class AddCarModelsLoad extends ProductState {}
class AddCarModelsSuccess extends ProductState {}
class AddCarModelsError extends ProductState {}


class DeleteCarModelsLoad extends ProductState {}
class DeleteCarModelsSuccess extends ProductState {}
class DeleteCarModelsError extends ProductState {}


class UpdateCarModelsLoad extends ProductState {}
class UpdateCarModelsSuccess extends ProductState {}
class UpdateCarModelsError extends ProductState {}

class ChangeValueSubCategory extends ProductState {}
