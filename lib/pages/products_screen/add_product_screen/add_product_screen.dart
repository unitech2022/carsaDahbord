import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/bloc/products_cubit/product_cubit.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/models/car_model.dart';
import 'package:flutter_web_dashboard/models/category_model.dart';
import 'package:flutter_web_dashboard/models/producte_model.dart';

import '../../../bloc/category_cubit/category_cubit.dart';
import '../../../constants/constans.dart';
import '../../../helpers/functions.dart';
import '../../../widgets/CustomDropDownWidget.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/fields.dart';
import '../../../widgets/texts.dart';

class AddProductScreen extends StatefulWidget {
  final ProducteModel producteModel;
  final int status;

  AddProductScreen(this.producteModel, this.status);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDetails = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  final TextEditingController _controllerTimeDelivery = TextEditingController();
  final TextEditingController _controllerNumberProduct =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CategoryCubit.get(context).getBrands();
    CategoryCubit.get(context).category = null;
    ProductCubit.get(context).carModel = null;
    CategoryCubit.get(context).brand = null;
    if (widget.status == 1) {
      getData();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerName.dispose();
    _controllerDetails.dispose();
    _controllerPrice.dispose();
    _controllerNumberProduct.dispose();
    _controllerTimeDelivery.dispose();
  }

  String? image = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  width: 450,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Colors.black),
                            color: Colors.white),
                        padding: EdgeInsets.all(20),
                        // height: 200,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Texts(
                                    fSize: 20,
                                    color: Colors.black,
                                    title: "اضافة منتج جديد",
                                    weight: FontWeight.bold),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      size: 25,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<CategoryCubit, CategoryState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Texts(
                                              fSize: 20,
                                              color: Colors.black,
                                              title: "القسم",
                                              weight: FontWeight.bold),
                                          CustomDropDownWidget(
                                              currentValue:
                                                  CategoryCubit.get(context)
                                                      .category,
                                              selectCar: false,
                                              colorBackRound:
                                                  const Color(0xffF6F6F6),
                                              textColor: Colors.black,
                                              isTwoIcons: false,
                                              iconColor:
                                                  const Color(0xff515151),
                                              icon2: Icons.add_box_outlined,
                                              icon1: Icons.search,
                                              list: CategoryCubit.get(context)
                                                  .listCategories
                                                  .map((item) =>
                                                      DropdownMenuItem<dynamic>(
                                                          value: item,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                item.name!,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              // if(widget.actionBtn!=null) IconButton(onPressed:(){
                                                              //   widget.actionBtn(item.id);
                                                              // } , icon: Icon(Icons.close,color: Colors.red,size: 20,))
                                                            ],
                                                          )))
                                                  .toList(),
                                              onSelect: (value) {
                                                CategoryCubit.get(context)
                                                    .changeValue(value);
                                              },
                                              hint: "اختار قسم"),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Texts(
                                              fSize: 20,
                                              color: Colors.black,
                                              title: "Brand",
                                              weight: FontWeight.bold),
                                          CustomDropDownWidget(
                                              currentValue:
                                                  CategoryCubit.get(context)
                                                      .brand,
                                              selectCar: false,
                                              colorBackRound:
                                                  const Color(0xffF6F6F6),
                                              textColor: Colors.black,
                                              isTwoIcons: false,
                                              iconColor:
                                                  const Color(0xff515151),
                                              icon2: Icons.add_box_outlined,
                                              icon1: Icons.search,
                                              list: CategoryCubit.get(context)
                                                  .listBrands
                                                  .map((item) =>
                                                      DropdownMenuItem<dynamic>(
                                                          value: item,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                item.name!,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              // if(widget.actionBtn!=null) IconButton(onPressed:(){
                                                              //   widget.actionBtn(item.id);
                                                              // } , icon: Icon(Icons.close,color: Colors.red,size: 20,))
                                                            ],
                                                          )))
                                                  .toList(),
                                              onSelect: (value) {
                                                CategoryCubit.get(context)
                                                    .changeValueBrand(value);
                                                print(value.id.toString());
                                                ProductCubit.get(context)
                                                    .getCarModelsById(
                                                        carId: value.id);
                                                     
                                              },
                                              hint: "اختار brand"),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Texts(
                                    fSize: 20,
                                    color: Colors.black,
                                    title: "موديل السيارة",
                                    weight: FontWeight.bold),
                              ],
                            ),
                         ProductCubit.get(context).loadCarModels? SizedBox(child: Center(
                          child: CircularProgressIndicator(color: homeColor),
                         ),):  CustomDropDownWidget(
                                currentValue:
                                    ProductCubit.get(context).carModel,
                                selectCar: false,
                                colorBackRound: const Color(0xffF6F6F6),
                                textColor: Colors.black,
                                isTwoIcons: false,
                                iconColor: const Color(0xff515151),
                                icon2: Icons.add_box_outlined,
                                icon1: Icons.search,
                                list: ProductCubit.get(context)
                                    .carModels
                                    .map((item) => DropdownMenuItem<dynamic>(
                                        value: item,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item.name!,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            // if(widget.actionBtn!=null) IconButton(onPressed:(){
                                            //   widget.actionBtn(item.id);
                                            // } , icon: Icon(Icons.close,color: Colors.red,size: 20,))
                                          ],
                                        )))
                                    .toList(),
                                onSelect: (value) {
                                  ProductCubit.get(context)
                                      .changeValueCarModel(value);
                                },
                                hint: "اختار موديل السيارة"),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: homeColor,
                                  ),
                                  child: Checkbox(
                                    tristate: false,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: const BorderSide(
                                            color: homeColor, width: 2)),
                                    checkColor: Colors.white,
                                    activeColor: homeColor,
                                    value: ProductCubit.get(context).isChecked,
                                    onChanged: (value) {
                                      ProductCubit.get(context)
                                          .changeCheckBox(value!);
                                    },
                                  ),
                                ),
                                const Text(
                                  "اضافة المنتج في السليدر",
                                  style: TextStyle(
                                      color: homeColor, fontFamily: "pnuB"),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField2(
                              controller: _controllerName,
                              hint: "اسم المنتج",
                              inputType: TextInputType.text,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField2(
                              controller: _controllerDetails,
                              hint: "تفاصيل المنتج",
                              inputType: TextInputType.text,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 55,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: const Color(0xffF6F6F6),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                controller: _controllerNumberProduct,
                                textDirection: TextDirection.rtl,

                                maxLines: null,
                                // inputFormatters: [
                                //   new  FilteringTextInputFormatter(RegExp("[a-zA-Z0-9,-]"), allow: true)
                                // ],
                                onChanged: (value) {},
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: "pnuM",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  hintText: "رقم القطعة",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField2(
                                    controller: _controllerPrice,
                                    hint: "السـعر",
                                    inputType: TextInputType.number,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: homeColor,
                                      ),
                                      child: Checkbox(
                                        tristate: false,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            side: const BorderSide(
                                                color: homeColor, width: 2)),
                                        checkColor: Colors.white,
                                        activeColor: homeColor,
                                        value: ProductCubit.get(context)
                                            .isCheckedTax,
                                        onChanged: (value) {
                                          ProductCubit.get(context)
                                              .changeCheckBoxTax(value!);
                                        },
                                      ),
                                    ),
                                    const Text(
                                      "شامل الضريبة",
                                      style: TextStyle(
                                          color: homeColor, fontFamily: "pnuB"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField2(
                              controller: _controllerTimeDelivery,
                              hint: "مدة التوصيل",
                              inputType: TextInputType.number,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<CategoryCubit, CategoryState>(
                              listener: (context, state) {
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                if (state is UpdateCategoriesLoadedImageStat) {
                                  image = state.image;
                                  print("iiiiiiiiiiiiiiiiiiii$image");
                                }
                                return CategoryCubit.get(context).loadImage
                                    ? SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              chooseFileUsingFilePicker()
                                                  .then((value) {
                                                CategoryCubit.get(context)
                                                    .uploadSelectedFile(
                                                        objFile: objFile)
                                                    .then((value) {});
                                              });
                                            },
                                            child: image == ""
                                                ? Icon(
                                                    Icons.camera_alt,
                                                    size: 100,
                                                  )
                                                : Container(
                                                    height: 100,
                                                    width: 100,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: Image.network(
                                                        baseUrlImages + image!,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      );
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            (ProductCubit.get(context).loadAddProduct ||
                                    ProductCubit.get(context).loadUpdate)
                                ? CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.black,
                                  )
                                : CustomButton(
                                    color: homeColor,
                                    width: double.infinity,
                                    height: 45,
                                    onPress: () {
                                      // print("dh");

                                      // print(CategoryCubit.get(context).category.id);
                                      if (isValidate()) {
                                        if (widget.status == 0) {
                                          if (ProductCubit.get(context)
                                              .isChecked) {
                                            ProducteModel product = ProducteModel(
                                              carModelId: ProductCubit.get(context).carModel!.id,
                                                detailsPrice:
                                                    ProductCubit.get(context)
                                                        .isCheckedTax,
                                                timeDelivery:
                                                    _controllerTimeDelivery
                                                        .text,
                                                status: 2,
                                                name:
                                                    _controllerName.text.trim(),
                                                image: image,
                                                offerId: 1,
                                                categoryId:
                                                    CategoryCubit.get(context)
                                                        .category!
                                                        .id,
                                                brandId: CategoryCubit.get(
                                                                context)
                                                            .brand ==
                                                        null
                                                    ? 0
                                                    : CategoryCubit.get(context)
                                                        .brand!
                                                        .id,
                                                price: _controllerPrice.text
                                                    .trim(),
                                                detail: _controllerDetails.text
                                                    .trim(),
                                                isCart: false,
                                                isFav: false,
                                                sellerId:
                                                    _controllerNumberProduct
                                                        .text);

                                            ProductCubit.get(context)
                                                .addProduct(product: product)
                                                .then((value) {
                                              Navigator.pop(context);
                                            });
                                          } else {
                                            ProducteModel product = ProducteModel(
                                               carModelId: ProductCubit.get(context).carModel!.id,
                                                detailsPrice:
                                                    ProductCubit.get(context)
                                                        .isCheckedTax,
                                                timeDelivery:
                                                    _controllerTimeDelivery
                                                        .text,
                                                status: 2,
                                                name:
                                                    _controllerName.text.trim(),
                                                image: image,
                                                offerId: 0,
                                                categoryId:
                                                    CategoryCubit.get(context)
                                                        .category!
                                                        .id,
                                                brandId: CategoryCubit.get(
                                                                context)
                                                            .brand ==
                                                        null
                                                    ? 0
                                                    : CategoryCubit.get(context)
                                                        .brand!
                                                        .id,
                                                price: _controllerPrice.text
                                                    .trim(),
                                                detail: _controllerDetails.text
                                                    .trim(),
                                                isCart: false,
                                                isFav: false,
                                                sellerId:
                                                    _controllerNumberProduct
                                                        .text);

                                            ProductCubit.get(context)
                                                .addProduct(product: product)
                                                .then((value) {
                                              Navigator.pop(context);
                                            });
                                          }
                                        } else {
                                          if (ProductCubit.get(context)
                                              .isChecked) {
                                            ProducteModel product = ProducteModel(
                                              
                                                carModelId:
                                                    ProductCubit.get(context)
                                                        .carModel!
                                                        .id,
                                                detailsPrice:
                                                    ProductCubit.get(context)
                                                        .isCheckedTax,
                                                timeDelivery:
                                                    _controllerTimeDelivery
                                                        .text,
                                                status:
                                                    widget.producteModel.status,
                                                id: widget.producteModel.id,
                                                name:
                                                    _controllerName.text.trim(),
                                                image: image,
                                                offerId: 1,
                                                categoryId:
                                                    CategoryCubit.get(context)
                                                        .category!
                                                        .id,
                                                brandId: CategoryCubit.get(context)
                                                            .brand ==
                                                        null
                                                    ? 0
                                                    : CategoryCubit.get(context)
                                                        .brand!
                                                        .id,
                                                price: _controllerPrice.text
                                                    .trim(),
                                                detail: _controllerDetails.text
                                                    .trim(),
                                                isCart: false,
                                                isFav: false,
                                                sellerId: _controllerNumberProduct
                                                    .text);

                                            ProductCubit.get(context)
                                                .updateProduct(product: product)
                                                .then((value) {
                                              Navigator.pop(context);
                                            });
                                          } else {
                                            ProducteModel product = ProducteModel(
                                                carModelId:
                                                    ProductCubit.get(context)
                                                        .carModel!
                                                        .id,
                                                detailsPrice:
                                                    ProductCubit.get(context)
                                                        .isCheckedTax,
                                                timeDelivery:
                                                    _controllerTimeDelivery
                                                        .text,
                                                status:
                                                    widget.producteModel.status,
                                                id: widget.producteModel.id,
                                                name:
                                                    _controllerName.text.trim(),
                                                image: image,
                                                offerId: 0,
                                                categoryId:
                                                    CategoryCubit.get(context)
                                                        .category!
                                                        .id,
                                                brandId: CategoryCubit.get(context)
                                                            .brand ==
                                                        null
                                                    ? 0
                                                    : CategoryCubit.get(context)
                                                        .brand!
                                                        .id,
                                                price: _controllerPrice.text
                                                    .trim(),
                                                detail: _controllerDetails.text
                                                    .trim(),
                                                isCart: false,
                                                isFav: false,
                                                sellerId: _controllerNumberProduct
                                                    .text);

                                            ProductCubit.get(context)
                                                .updateProduct(product: product)
                                                .then((value) {
                                              Navigator.pop(context);
                                            });
                                          }
                                        }
                                      }
                                    },
                                    fontFamily: "",
                                    text:
                                        widget.status == 1 ? "تعديل" : "اضافة",
                                    isCustomColor: true,
                                    redius: 10,
                                    fontSize: 20,
                                    textColor: Colors.white,
                                    isBorder: true,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  late PlatformFile objFile;
  Uint8List? uploadedImage;

  Future chooseFileUsingFilePicker() async {
    //-----pick file by file picker,

    dynamic result = await FilePicker.platform
        .pickFiles(
      withReadStream:
          true, // this will return PlatformFile object with read stream
    )
        .then((value) {
      if (value != null) {
        setState(() {
          objFile = value.files.single;

          print(objFile.name);
        });
      }
    });
    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
    }
  }

  bool isValidate() {
    if (CategoryCubit.get(context).category == null) {
      HelperFunctions.slt.notifyUser(
          message: "اختار القسم", color: Colors.blue, context: context);
      return false;
    } else if (ProductCubit.get(context).carModel == null) {
      HelperFunctions.slt.notifyUser(
          message: "اختار موديل السيارة", color: Colors.blue, context: context);
      return false;
    } else if (_controllerName.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب اسم المنتج", color: Colors.blue, context: context);
      return false;
    } else if (_controllerDetails.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب تفاصيل المنتج", color: Colors.blue, context: context);
      return false;
    } else if (_controllerPrice.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب سعر المنتج", color: Colors.blue, context: context);
      return false;
    } else if (_controllerTimeDelivery.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب مدة التوصيل", color: Colors.blue, context: context);
      return false;
    } else if (image == "") {
      HelperFunctions.slt.notifyUser(
          message: "اختار الصورة", color: Colors.blue, context: context);
      return false;
    } else {
      return true;
    }
  }

  void getData() {
    CategoryCubit.get(context).category = CategoryCubit.get(context)
        .listCategories
        .firstWhere((element) => element.id == widget.producteModel.categoryId,
            orElse: () => CategoryModel());

    widget.producteModel.offerId == 1
        ? ProductCubit.get(context).isChecked = true
        : ProductCubit.get(context).isChecked = false;
    // print(CategoryCubit.get(context).listCategories.length.toString() +"dddddddd");

    if (widget.producteModel.brandId != 0) {
      CategoryCubit.get(context).brand = CategoryCubit.get(context)
          .listBrands
          .firstWhere((element) => element.id == widget.producteModel.brandId,
              orElse: () => CategoryModel());

    } else {
      CategoryCubit.get(context).brand = null;
    }
    // if (widget.producteModel.carModelId != 0) {
    //   ProductCubit.get(context).carModel = ProductCubit.get(context)
    //       .carModels
    //       .firstWhere((element) => element.id == widget.producteModel.brandId,
    //           orElse: () => CarModel());
    // } else {
    //   ProductCubit.get(context).carModel = null;
    // }

    _controllerDetails.text = widget.producteModel.detail!;
    _controllerPrice.text = widget.producteModel.price.toString();
    _controllerName.text = widget.producteModel.name!;
    _controllerTimeDelivery.text = widget.producteModel.timeDelivery ?? "";
    _controllerNumberProduct.text = widget.producteModel.sellerId ?? "";
    ProductCubit.get(context).isCheckedTax = widget.producteModel.detailsPrice!;

    image = widget.producteModel.image;
  }
}
