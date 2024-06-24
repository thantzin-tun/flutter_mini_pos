// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/constants/dimensions.dart';
import 'package:flutter_bloc_demo/constants/routes.dart';
import 'package:flutter_bloc_demo/constants/strings.dart';
import 'package:flutter_bloc_demo/features/product/models/create_product_model.dart';
import 'package:flutter_bloc_demo/features/product/presentation/bloc/product/product_cubit.dart';
import 'package:flutter_bloc_demo/helpers/loggin.dart';
import 'package:flutter_bloc_demo/resources/colors.dart';
import 'package:flutter_bloc_demo/utils/alert_util.dart';
import 'package:flutter_bloc_demo/widgets/custom_button.dart';
import 'package:flutter_bloc_demo/widgets/custom_textField.dart';
import 'package:flutter_bloc_demo/widgets/custom_text_widget.dart';
import 'package:flutter_bloc_demo/widgets/sizeBox.dart';
import 'package:image_picker/image_picker.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  TextEditingController controller = TextEditingController();

  final ImagePicker picker = ImagePicker();
  XFile? image;

  final _formKey = GlobalKey<FormState>();
  String name = "";
  String price_per_unit = "";
  String unit = "";
  String stock = "";
  String? description;

  Future getImageFromGallery() async {
    final pickFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickFile != null) {
      setState(() {
        image = XFile(pickFile.path);
      });
      Navigator.of(context).pop();
    } else {
      image = null;
    }
  }

  Future getImageFromCamera() async {
    final pickFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickFile != null) {
        image = XFile(pickFile.path);
        Navigator.of(context).pop();
      } else {
        image = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: const CustomTextWidget(
            text: addProduct,
            fontSize: 18.0,
            fontColor: KColor.NORMAL_COLOR,
          ),
          centerTitle: false,
          backgroundColor: KColor.PRIMARY_COLOR),
      body: BlocListener<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductCreateSuccess) {
            Navigator.pushNamed(context, AppRoute.product);
          } else if (state is ProductFailed) {
            AlertUtilTop.showSnackBar(context, state.errorMessage);
          } // TODO: implement listener
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: PRODUCT_CARD_SPACING, vertical: 20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  FormTextFieldWithLabel(
                    label: "ပစ္စည်းအမျိုးအမည် *",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ပစ္စည်းအမျိုးအမည်ထည့်သွင်း‌ပေးပါ*';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        name = value.toString();
                      });
                    },
                  ),
                  FormTextFieldWithLabel(
                      label: "စျေးနှုန်း *",
                      isNumber: true,
                      onSaved: (value) {
                        setState(() {
                          price_per_unit = value.toString().trim();
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ပစ္စည်းစျေးနှူန်းထည့်သွင်းပေးပါ*';
                        } else if (value.length > 6) {
                          return 'သတ်မှတ်စျေးနှုန်းထက်ကျော်လွန်နေပါသည်*';
                        } else if (int.tryParse(value) == null) {
                          return 'ကျေးဇူးပြု၍မှန်ကန်သောနံပါတ်ထည့်ပါ*';
                        }
                        {
                          return null;
                        }
                      }),
                  const CustomSizeBox(
                    height: PRIMARY_GAP,
                  ),
                  InkWell(
                    onTap: () {
                      ChooseImagePickerMethodDialog(
                          context, getImageFromCamera, getImageFromGallery);
                    },
                    child: Container(
                      width: size.width,
                      height: size.height * 0.16,
                      decoration: const BoxDecoration(
                          color: KColor.PRIMARY_COLOR,
                          borderRadius: BorderRadius.all(
                              Radius.circular(PRIMARY_RADIUS))),
                      child: Center(
                          child: image != null
                              ? Stack(children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(PRIMARY_RADIUS),
                                    child: Image.file(
                                      File(image!.path),
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      backgroundColor: KColor.TRINARY_COLOR,
                                      radius: 16.0,
                                      child: Center(
                                        child: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              setState(() {
                                                image = null;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: KColor.NORMAL_COLOR,
                                            )),
                                      ),
                                    ),
                                  )
                                ])
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CustomTextWidget(
                                      text: "ပစ္စည်းပုံစံ",
                                      fontColor: KColor.NORMAL_COLOR,
                                    ),
                                    CustomSizeBox(
                                      width: PRIMARY_GAP,
                                    ),
                                    Icon(
                                      Icons.add,
                                      size: primaryFontSize,
                                      color: KColor.NORMAL_COLOR,
                                    )
                                  ],
                                )),
                    ),
                  ),
                  const CustomSizeBox(
                    height: PRIMARY_GAP,
                  ),
                  FormTextFieldWithLabel(
                      label: "ယူနစ် *",
                      onSaved: (value) {
                        setState(() {
                          unit = value.toString();
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ယူနစ်ထည့်သွင်းပေးပါ*';
                        }
                        return null;
                      }),
                  FormTextFieldWithLabel(
                      multipleLine: true,
                      label: "ပစ္စည်းအကြောင်းအရာ *",
                      onSaved: (value) {
                        setState(() {
                          description = value.toString();
                        });
                      },
                      validator: (value) {
                        return null;
                      }),
                  FormTextFieldWithLabel(
                      label: "လက်ကျန် *",
                      isNumber: true,
                      onSaved: (value) {
                        setState(() {
                          stock = value.toString().trim();
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ပစ္စည်းလက်ကျန်ထည့်သွင်းပေးပါ*';
                        }
                        if (int.tryParse(value) == null) {
                          return 'ကျေးဇူးပြု၍မှန်ကန်သောနံပါတ်ထည့်ပါ*';
                        }
                        return null;
                      }),
                  CustomSizeBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: CustomButton(
                          text: "ထည့်မည်",
                          action: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              BlocProvider.of<ProductCubit>(context).addProduct(
                                  CreateProductElement(
                                      name: name,
                                      pricePerUnit: price_per_unit,
                                      unit: unit,
                                      description: description,
                                      stock: stock,
                                      productImage: image?.path));
                            }
                          }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Picker Method Dialog Box
  Future<dynamic> ChooseImagePickerMethodDialog(
    BuildContext context,
    VoidCallback cameraOptionFun,
    VoidCallback galleryOptionFun,
  ) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        PickerContainerWidget(
                          icon: Icons.camera_alt_outlined,
                          optionFunc: cameraOptionFun,
                        ),
                        PickerContainerWidget(
                          icon: Icons.photo,
                          optionFunc: galleryOptionFun,
                        ),
                      ],
                    ),
                  ]),
            )));
  }
}

class PickerContainerWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback optionFunc;
  const PickerContainerWidget({
    super.key,
    required this.optionFunc,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: optionFunc,
        child: Container(
          color: KColor.PRIMARY_COLOR,
          height: 100.0,
          padding: const EdgeInsets.all(PRIMARY_PADDING),
          child: Center(
            child:
                Icon(icon, color: KColor.NORMAL_COLOR, size: PRIMARY_ICON_SIZE),
          ),
        ),
      ),
    );
  }
}

class FormTextFieldWithLabel extends StatelessWidget {
  const FormTextFieldWithLabel(
      {super.key,
      required this.label,
      this.controller,
      required this.onSaved,
      this.isNumber = false,
      this.multipleLine = false,
      required this.validator});
  final String label;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final Function(String?) onSaved;
  final bool isNumber;
  final bool multipleLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomTextWidget(text: label),
        const CustomSizeBox(
          height: SECONDARY_GAP,
        ),
        CustomTextFieldWidget(
          contentPadding: const EdgeInsets.all(PRIMARY_PADDING),
          validator: validator,
          onSaved: onSaved,
          keyboardType: isNumber
              ? TextInputType.number
              : multipleLine
                  ? TextInputType.multiline
                  : TextInputType.text,
          maxLines: multipleLine ? 5 : 1,
          textInputAction: multipleLine ? TextInputAction.newline : null,
        ),
        const CustomSizeBox(
          height: PRIMARY_GAP,
        ),
      ],
    );
  }
}
