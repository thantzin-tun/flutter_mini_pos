import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/constants/dimensions.dart';
import 'package:flutter_bloc_demo/constants/strings.dart';
import 'package:flutter_bloc_demo/features/customer/presentation/bloc/customer/customer_cubit.dart';

import 'package:flutter_bloc_demo/resources/colors.dart';
import 'package:flutter_bloc_demo/widgets/custom_text_widget.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColor.PRIMARY_COLOR,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const CustomTextWidget(
          text: customer,
          fontSize: tinaryFontSize,
          fontColor: KColor.NORMAL_COLOR,
        ),
      ),
      body: BlocListener<CustomerCubit, CustomerState>(
        listener: (context, state) {
          if (state is CustomerFetchingProcessSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Customer fetched successfully'),
            ));
          }
        },
        child: BlocBuilder<CustomerCubit, CustomerState>(
            builder: (context, state) {
          if (state is CustomerFetchingProcessLoading) {
            print("Loading");
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CustomerFetchingProcessSuccess) {
            final products = state.products;
            return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(products[index].title.toString()),
                  );
                });
          }
          return const Text("Something Wrong");
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
