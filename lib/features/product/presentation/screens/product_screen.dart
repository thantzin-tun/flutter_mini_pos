import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/constants/config.dart';
import 'package:flutter_bloc_demo/constants/dimensions.dart';
import 'package:flutter_bloc_demo/constants/routes.dart';
import 'package:flutter_bloc_demo/constants/strings.dart';
import 'package:flutter_bloc_demo/features/product/models/product_model.dart';
import 'package:flutter_bloc_demo/features/product/presentation/bloc/product/product_cubit.dart';
import 'package:flutter_bloc_demo/resources/colors.dart';
import 'package:flutter_bloc_demo/widgets/custom_text_widget.dart';
import 'package:flutter_bloc_demo/widgets/sizeBox.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductCubit>(context).fetchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KColor.PRIMARY_COLOR,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.home,
                (Route<dynamic> route) => false,
              );
            },
          ),
          title: const CustomTextWidget(
            text: product,
            fontSize: tinaryFontSize,
            fontColor: KColor.NORMAL_COLOR,
          ),
        ),
        body:
            BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: KColor.PRIMARY_COLOR,
            ));
          } else if (state is ProductSuccess) {
            List<ProductElement> products = state.products.products;
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: PRIMARY_GAP, vertical: 20.0),
              child: products.isNotEmpty
                  ? GridView.builder(
                      itemCount: state.products.products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of columns
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 20.0,
                              mainAxisExtent: 260),
                      itemBuilder: (context, index) {
                        ProductElement pro = state.products.products[index];
                        return ProductCard(
                          product: pro,
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset("assets/images/empty-product.png"),
                          const CustomSizeBox(
                            height: PRIMARY_GAP,
                          ),
                          const CustomTextWidget(text: productErr)
                        ],
                      ),
                    ),
            );
          }
          return const Center(child: CustomTextWidget(text: errorString));
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: KColor.PRIMARY_COLOR,
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoute.product_create,
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductElement product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: KColor.PRIMARY_COLOR,
      onTap: () {
        Navigator.pushNamed(context, AppRoute.product_detail,
            arguments: product);
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.all(Radius.circular(SECONDARY_RADIUS)),
            child: product.productImage != null
                ? CachedNetworkImage(
                    imageUrl: "$baseUrl${product.productImage}",
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
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          const CustomSizeBox(
            height: 5.0,
          ),
          CustomTextWidget(
            text: product.name,
            fontSize: 16.0,
          ),
          CustomTextWidget(
            text: "စျေးနှုန်း  ${product.pricePerUnit} ကျပ်",
            fontSize: 16.0,
          ),
        ],
      ),
    );
  }
}
