import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/models/car_model.dart';


import '../../../bloc/category_cubit/category_cubit.dart';
import '../../../bloc/products_cubit/product_cubit.dart';
import '../../../constants/constans.dart';
import '../../../helpers/functions.dart';
import '../../../widgets/CustomDropDownWidget.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/fields.dart';
import '../../../widgets/texts.dart';

class AddCarModelScreen extends StatefulWidget {
  CarModel carModel;
  int status;

  AddCarModelScreen(this.carModel, this.status);

  @override
  State<AddCarModelScreen> createState() => _AddCarModelScreenState();
}

class _AddCarModelScreenState extends State<AddCarModelScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CategoryCubit
        .get(context)
        .brand = null;
    CategoryCubit.get(context).getBrands();
    if (widget.status == 1) {
      _controller.text = widget.carModel.name!;
      image = widget.carModel.image!;
      // if (widget.carModel.carId != 0) {
      //   CategoryCubit.get(context).brand = CategoryCubit.get(context)
      //       .listBrands
      //       .firstWhere((element) => element.id == widget.carModel.carId,
      //           orElse: () => CategoryModel());
      // }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  String? image = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        return BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is UpdateCategoriesLoadedImageStat) {
              image = state.image;
              print("iiiiiiiiiiiiiiiiiiii$image");
            }
            return Scaffold(
              body: Center(
                child: SizedBox(
                  width: 400,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                            Texts(
                                fSize: 20,
                                color: Colors.black,
                                title: widget.status == 1
                                    ? "تعديل موديل السيارة"
                                    : "اضافة موديل جديد",
                                weight: FontWeight.bold),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Texts(
                                    fSize: 20,
                                    color: Colors.black,
                                    title: "الاسم",
                                    weight: FontWeight.bold),
                              ],
                            ),
                            CustomTextField2(
                              controller: _controller,
                              hint: "اسم الموديل  ",
                              inputType: TextInputType.text,
                            ),
                            Row(
                              children: [
                                Texts(
                                    fSize: 20,
                                    color: Colors.black,
                                    title: "Brand",
                                    weight: FontWeight.bold),
                              ],
                            ),
                            CustomDropDownWidget(
                                currentValue:
                                CategoryCubit
                                    .get(context)
                                    .brand,
                                selectCar: false,
                                colorBackRound:
                                const Color(0xffF6F6F6),
                                textColor: Colors.black,
                                isTwoIcons: false,
                                iconColor: const Color(0xff515151),
                                icon2: Icons.add_box_outlined,
                                icon1: Icons.search,
                                list: CategoryCubit
                                    .get(context)
                                    .listBrands
                                    .map((item) =>
                                    DropdownMenuItem<
                                        dynamic>(
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
                                                FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow
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
                                },
                                hint: "اختار brand"),

                            SizedBox(
                              height: 20,
                            ),

                            CategoryCubit
                                .get(context)
                                .loadImage
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
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            (ProductCubit
                                .get(context)
                                .loadAddCarModel ||
                                ProductCubit
                                    .get(context)
                                    .loadUpdateCarModel)
                                ? CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.black,
                            )
                                : CustomButton(
                              color: Colors.blue,
                              width: double.infinity,
                              height: 50,
                              onPress: () {
                                // print("dh");
                                if (isValidate()) {
                                  if (widget.status == 1) {
                                    CarModel cat = CarModel(
                                        image: image,
                                        name: _controller.text,
                                        carId: CategoryCubit
                                            .get(context)
                                            .brand!
                                            .id,
                                        id: widget.carModel.id);

                                    ProductCubit.get(context)
                                        .updateCaraModel(
                                      category: cat,
                                    )
                                        .then((value) {
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    CarModel cat = CarModel(
                                      image: image,
                                      carId: CategoryCubit
                                          .get(context)
                                          .brand!
                                          .id,
                                      name: _controller.text,
                                    );

                                    ProductCubit.get(context)
                                        .addCaModel(
                                      carModel: cat,
                                    )
                                        .then((value) {
                                      Navigator.pop(context);
                                    });
                                  }
                                }
                              },
                              fontFamily: "",
                              text: widget.status == 1 ? "تعديل" : "اضافة",
                              isCustomColor: true,
                              redius: 0,
                              fontSize: 20,
                              textColor: Colors.white,
                              isBorder: true,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  late PlatformFile objFile;
  Uint8List? uploadedImage;
  Image? _imageWidget;

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
      _imageWidget = Image.memory(file.bytes!);
    }
  }

  bool isValidate() {
    if (_controller.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب الاسم", color: Colors.blue, context: context);
      return false;
    } else if (CategoryCubit
        .get(context)
        .brand == null) {
      HelperFunctions.slt.notifyUser(
          message: "اختار السيارة", color: Colors.blue, context: context);
      return false;
    } else if (image == "") {
      HelperFunctions.slt.notifyUser(
          message: "اختار الصورة", color: Colors.blue, context: context);
      return false;
    } else {
      return true;
    }
  }
}
