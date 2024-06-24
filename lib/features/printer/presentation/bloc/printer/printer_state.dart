part of 'printer_cubit.dart';

sealed class PrinterState extends Equatable {
  const PrinterState();

  @override
  List<Object?> get props => [];
}

final class PrinterInitial extends PrinterState {}

final class PrinterInfoLoading extends PrinterState {}

final class PrinterInfoSuccess extends PrinterState {
  final BlueThermalPrinter bluetooth;
  final List<BluetoothDevice> devices;
  final int? printerIndex;
  const PrinterInfoSuccess(
      {required this.devices, required this.bluetooth, this.printerIndex});
  @override
  List<Object?> get props => [devices, bluetooth, printerIndex];

  PrinterInfoSuccess copyWith({
    List<BluetoothDevice>? devices,
    BlueThermalPrinter? bluetooth,
    int? printerIndex,
  }) {
    return PrinterInfoSuccess(
      devices: devices ?? this.devices,
      bluetooth: bluetooth ?? this.bluetooth,
      printerIndex: printerIndex ?? this.printerIndex,
    );
  }
}

final class PrinterInfoError extends PrinterState {}
