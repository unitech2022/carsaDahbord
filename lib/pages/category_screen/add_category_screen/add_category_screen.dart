import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/models/category_model.dart';

import '../../../bloc/category_cubit/category_cubit.dart';
import '../../../constants/constans.dart';
import '../../../helpers/functions.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/fields.dart';
import '../../../widgets/texts.dart';


// type 1 =category
//type = 2- brands

class AddCategoryScreen extends StatefulWidget {

  CategoryModel categoryModel;
  int status;
  int type;

  AddCategoryScreen(this.categoryModel, this.status, this.type);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.status == 1) {
      _controller.text = widget.categoryModel.name!;
      image = widget.categoryModel.image;
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
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
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
                                ? "تعديل القسم"
                                : "اضافة قسم جديد",
                            weight: FontWeight.bold),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField2(
                          controller: _controller,
                          hint: "اسم القسم ",
                          inputType: TextInputType.text,
                        ),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                chooseFileUsingFilePicker().then((value) {
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
                                  BorderRadius.circular(5),
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
                        (CategoryCubit
                            .get(context)
                            .loadAdd || CategoryCubit
                            .get(context)
                            .loadUpdate)
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
                                if (widget.type == 0) {
                                  CategoryModel cat = CategoryModel(
                                      image: image,
                                      name: _controller.text,
                                      id: widget.categoryModel.id
                                  );

                                  CategoryCubit.get(context)
                                      .updateCategory(
                                    endPoint: "category/update-Category",
                                    status: 0,
                                    category: cat,
                                  )
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                } else if (widget.type==3) {
                                  CategoryModel cat = CategoryModel(
                                      image: image,
                                      name: _controller.text,
                                      id: widget.categoryModel.id
                                  );

                                  CategoryCubit.get(context)
                                      .updateCategory(
                                    status: 2,
                                    endPoint: "slider/update-slider",
                                    category: cat,
                                  )
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                }

                                else {
                                  CategoryModel cat = CategoryModel(
                                      image: image,
                                      name: _controller.text,
                                      id: widget.categoryModel.id
                                  );

                                  CategoryCubit.get(context)
                                      .updateCategory(
                                    status: 1,
                                    endPoint: "brand/update-brand",
                                    category: cat,
                                  )
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                }
                              } else {
                                if (widget.type == 0) {
                                  CategoryModel cat = CategoryModel(
                                    image: image,
                                    name: _controller.text,
                                  );

                                  CategoryCubit.get(context)
                                      .addCategory(
                                    endPoint: "brand/add-barnd",
                                    status: 1,
                                    category: cat,
                                  )
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                } else if (widget.type==3) {
                                  CategoryModel cat = CategoryModel(
                                      image: image,
                                      name: _controller.text,

                                  );

                                  CategoryCubit.get(context)
                                      .addCategory(
                                    status: 2,
                                    endPoint: "slider/add-slider",
                                    category: cat,
                                  )
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                } else {
                                  CategoryModel cat = CategoryModel(
                                    image: image,
                                    name: _controller.text,
                                  );

                                  CategoryCubit.get(context)
                                      .addCategory(
                                    status: 0,
                                    endPoint: "category/add-category",
                                    category: cat,
                                  )
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                }
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
          message: "اكتب الاسم",
          color: Colors.blue,
          context: context);
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
