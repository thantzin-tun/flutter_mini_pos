import 'package:flutter/material.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/features/printer/presentation/bloc/printer/printer_cubit.dart';
import 'package:flutter_bloc_demo/features/printer/presentation/screens/test_print.dart';
import 'package:flutter_bloc_demo/helpers/loggin.dart';
import 'package:flutter_bloc_demo/resources/colors.dart';
import 'package:flutter_bloc_demo/widgets/custom_button.dart';

class PrintScreen extends StatefulWidget {
  const PrintScreen({
    super.key,
  });
  @override
  State<PrintScreen> createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  BluetoothDevice? selectedDevice;
  TestPrint testPrint = TestPrint();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.NORMAL_COLOR,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: KColor.PRIMARY_COLOR,
        title: const Text(
          "Print",
        ),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<PrinterCubit, PrinterState>(
            builder: (context, state) {
              if (state is PrinterInfoLoading) {
                return const Center(
                    child:
                        CircularProgressIndicator(color: KColor.PRIMARY_COLOR));
              } else if (state is PrinterInfoSuccess) {
                final bluetooth = state.bluetooth;
                final devices = state.devices;
                final printerIndex = state.printerIndex;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(); // Separator widget, e.g., Divider
                        },
                        itemCount: devices.length,
                        itemBuilder: (context, index) {
                          final device = devices[index];
                          return ListTile(
                            tileColor: Colors.transparent,
                            trailing: printerIndex == index
                                ? const Icon(
                                    Icons.done,
                                    color: KColor.PRIMARY_COLOR,
                                    size: 30.0,
                                  )
                                : null,
                            leading: const Icon(
                              Icons.print,
                              color: KColor.PRIMARY_COLOR,
                              size: 28.0,
                            ),
                            title: Text(
                              device.name.toString(),
                              // "Epson SE119",
                              maxLines: 1,

                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              device.address.toString(),
                              // "45:11:ER:88",
                              maxLines: 1,

                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            onTap: () async {
                              BlocProvider.of<PrinterCubit>(context)
                                  .updatePrinterIndex(index);
                              if (!(await bluetooth.isConnected)!) {
                                bluetooth.connect(device);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Device is already connected"),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 0, 14, 34),
                      child: CustomButton(
                        action: () async {
                          if ((await bluetooth.isConnected)!) {
                            logger("Printer Status", "Connected");
                          }
                        },
                        text: 'Print',
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                  child: Text(
                "No Printer Connected",
              ));
            },
          )),
    );
  }
}
