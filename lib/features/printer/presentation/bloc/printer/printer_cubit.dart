import 'package:bloc/bloc.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'printer_state.dart';

class PrinterCubit extends Cubit<PrinterState> {
  PrinterCubit() : super(PrinterInitial()) {
    searchAvailablePrinterFunc();
  }

  void searchAvailablePrinterFunc() async {
    BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
    emit(PrinterInfoLoading());
    try {
      List<BluetoothDevice> devices = await bluetooth.getBondedDevices();
      emit(PrinterInfoSuccess(devices: devices, bluetooth: bluetooth));
    } on PlatformException {
      emit(PrinterInfoError());
    }
  }

  void updatePrinterIndex(int index) {
    if (state is PrinterInfoSuccess) {
      final successState = state as PrinterInfoSuccess;
      emit(successState.copyWith(printerIndex: index));
    }
  }
}
