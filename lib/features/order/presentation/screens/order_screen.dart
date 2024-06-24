import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/constants/dimensions.dart';
import 'package:flutter_bloc_demo/constants/strings.dart';
import 'package:flutter_bloc_demo/features/order/presentation/bloc/counter/counter_bloc.dart';
import 'package:flutter_bloc_demo/resources/colors.dart';
import 'package:flutter_bloc_demo/widgets/custom_text_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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
          text: order,
          fontSize: tinaryFontSize,
          fontColor: KColor.NORMAL_COLOR,
        ),
      ),
      body: BlocConsumer<CounterBloc, CounterState>(
        listenWhen: (previous, current) => true,
        listener: (context, state) {},
        builder: (context, state) {
          final counterFunc = BlocProvider.of<CounterBloc>(context);
          if (state is CounterOperationsSuccess) {
            return Column(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      counterFunc.add(const CounterIncreaseEvent(100));
                    },
                    child: const CustomTextWidget(text: "Increase")),
                CustomTextWidget(text: state.counter.toString()),
                ElevatedButton(
                    onPressed: () {
                      counterFunc.add(const CounterDecreaseEvent(3));
                    },
                    child: const CustomTextWidget(text: "Decrease")),
              ],
            );
          }
          return Container();
        },
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}
