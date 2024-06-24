import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/constants/config.dart';
import 'package:flutter_bloc_demo/constants/dimensions.dart';
import 'package:flutter_bloc_demo/constants/routes.dart';
import 'package:flutter_bloc_demo/constants/styles.dart';
import 'package:flutter_bloc_demo/features/product/models/product_model.dart';
import 'package:flutter_bloc_demo/features/product/presentation/bloc/product/product_cubit.dart';
import 'package:flutter_bloc_demo/resources/colors.dart';
import 'package:flutter_bloc_demo/widgets/custom_button.dart';
import 'package:flutter_bloc_demo/widgets/custom_delete_dialogBox.dart';
import 'package:flutter_bloc_demo/widgets/custom_text_widget.dart';
import 'package:flutter_bloc_demo/widgets/sizeBox.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProductElement productDetail =
        ModalRoute.of(context)!.settings.arguments as ProductElement;
    return Scaffold(
      appBar: AppBar(
          title: CustomTextWidget(
            text: productDetail.name,
            fontSize: 18.0,
            fontColor: KColor.NORMAL_COLOR,
          ),
          centerTitle: false,
          backgroundColor: KColor.PRIMARY_COLOR),
      body: BlocListener<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductDeleteSuccess) {
            isLoading = true;
            Navigator.pushNamed(context, AppRoute.product);
          } else if (state is ProductLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state is ProductFailed) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: KColor.PRIMARY_COLOR,
              margin: EdgeInsets.only(top: 20),
              showCloseIcon: true,
              elevation: 2,
              closeIconColor: KColor.NORMAL_COLOR,
              content: CustomTextWidget(
                text: "ပြန်လည်ကြိုးစားကြည့်ပါ",
                fontColor: KColor.NORMAL_COLOR,
                fontSize: descriptionFontSize,
              ),
            ));
          }
        },
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            width: double.infinity,
            height: size.height * 0.2,
            color: KColor.SECONDARY_COLOR,
            child: productDetail.productImage != null
                ? CachedNetworkImage(
                    imageUrl: "$baseUrl${productDetail.productImage}",
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: KColor.PRIMARY_COLOR,
                      ),
                    ),
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/images/one.jpg",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            top: size.height * 0.05,
            left: size.width * 0.1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(PRIMARY_RADIUS),
                color: KColor.PRIMARY_COLOR,
              ),
              width: size.width * 0.8,
              height: size.height * 0.25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(PRIMARY_RADIUS),
                child: productDetail.productImage != null
                    ? CachedNetworkImage(
                        imageUrl: "$baseUrl${productDetail.productImage}",
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            color: KColor.PRIMARY_COLOR,
                          ),
                        ),
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/one.jpg",
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28.0),
              child: SizedBox(
                width: size.width * 0.9,
                height: size.height * 0.6,
                child: Card(
                  shadowColor: KColor.PRIMARY_COLOR,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CustomSizeBox(
                          height: Custom_GAP,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomTextWidget(
                              text: "ပစ္စည်းအမျိုးအမည်",
                              fontSize: customFontSize,
                            ),
                            CustomTextWidget(
                              text: productDetail.name,
                              fontSize: customFontSize,
                            )
                          ],
                        ),
                        const CustomSizeBox(
                          height: Custom_GAP,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomTextWidget(
                              text: "စျေးနှုန်း",
                              fontSize: customFontSize,
                            ),
                            CustomTextWidget(
                              text:
                                  "${productDetail.pricePerUnit} ကျပ် ( ၁ ${productDetail.unit} )",
                              fontSize: customFontSize,
                            )
                          ],
                        ),
                        const CustomSizeBox(
                          height: Custom_GAP,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomTextWidget(
                              text: "ယူနစ်",
                              fontSize: customFontSize,
                            ),
                            CustomTextWidget(
                              text: productDetail.unit,
                              fontSize: customFontSize,
                            )
                          ],
                        ),
                        const CustomSizeBox(
                          height: Custom_GAP,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTextWidget(
                              text: "ပစ္စည်းအကြောင်း",
                              fontSize: customFontSize,
                            ),
                            const CustomSizeBox(
                              height: PRIMARY_GAP,
                            ),
                            CustomTextWidget(
                              text: productDetail.description == null
                                  ? "မရှိ"
                                  : productDetail.description.toString(),
                              fontSize: descriptionFontSize,
                            )
                          ],
                        ),
                        const CustomSizeBox(
                          height: Custom_GAP,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomTextWidget(
                              text: "ပစ္စည်းလက်ကျန်",
                              fontSize: customFontSize,
                            ),
                            CustomTextWidget(
                              text:
                                  "${productDetail.stock}  ${productDetail.unit}",
                              fontSize: customFontSize,
                            )
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                            width: double.infinity,
                            height: 40.0,
                            child: CustomButton(
                                backgroundColor: KColor.TRINARY_COLOR,
                                text: "ပစ္စည်းစာရင်းမှ ပယ်ဖျက်ရန်",
                                action: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => CustomDeleteDialog(
                                            onDelete: () {
                                              BlocProvider.of<ProductCubit>(
                                                      context)
                                                  .deleteProduct(
                                                      productDetail.id);
                                              Navigator.pop(context);
                                            },
                                            deleteText:
                                                "${productDetail.name}အား သင်ဧ။်အ‌ရောင်းပစ္စည်းစာရင်းမှ ပယ်ဖျက်မှာသေချာပါသလား။",
                                          ));
                                })),
                        const CustomSizeBox(
                          height: PRIMARY_GAP,
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 40.0,
                            child: CustomButton(
                                text: "ပစ္စည်းအချက်အလက်ပြင်ဆင်ရန်",
                                action: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                            child: SizedBox(
                                              width: 600,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(24),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                            Icons.info_outline),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          "ပစ္စည်းအချက်အလက်ပြင်ဆင်ရန်",
                                                          style: KTextStyle
                                                              .deleteTextStyle,
                                                        ),
                                                        const Spacer(),
                                                        InkWell(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: SvgPicture.asset(
                                                                'assets/icons/close.svg')),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Text(
                                                      "ပြင်ဆင်မည်",
                                                      style: KTextStyle
                                                          .confirmTextStyle
                                                          .copyWith(
                                                              color: KColor
                                                                  .SECONDARY_COLOR),
                                                    ),
                                                    const SizedBox(height: 32),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        CustomButton(
                                                          text: "မလုပ်တော့ပါ",
                                                          textColor: KColor
                                                              .NORMAL_COLOR,
                                                          backgroundColor: KColor
                                                              .PRIMARY_COLOR,
                                                          action: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            width: PRIMARY_GAP),
                                                        CustomButton(
                                                          text: "ဖျက်မည်",
                                                          textColor: KColor
                                                              .NORMAL_COLOR,
                                                          backgroundColor: KColor
                                                              .TRINARY_COLOR,
                                                          action: () {},
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ));
                                })),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          isLoading
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: const Color.fromARGB(100, 255, 255, 255),
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: KColor.PRIMARY_COLOR,
                  )),
                )
              : Container()
        ]),
      ),
    );
  }
}

// ignore: must_be_immutable
class ProductEditDialogBox extends StatelessWidget {
  ProductEditDialogBox({
    super.key,
  });
  TextEditingController nameController = TextEditingController(text: "ပဲကြော်");
  TextEditingController pricePerUnitController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController productImageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: Text("Good"),
    );
  }
}
