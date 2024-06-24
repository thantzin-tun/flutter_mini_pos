import 'package:blue_thermal_printer/blue_thermal_printer.dart';

///Test printing
class TestPrint {
  printWithEng(BlueThermalPrinter bluetooth) async {
    //SIZE
    // 0- normal size text
    // 1- only bold text
    // 2- bold with medium text
    // 3- bold with large text
    //ALIGN
    // 0- ESC_ALIGN_LEFT
    // 1- ESC_ALIGN_CENTER
    // 2- ESC_ALIGN_RIGHT
    bluetooth.printCustom("Printed Success", 4, 1);
    bluetooth.printNewLine();

    bluetooth.printNewLine();

    bluetooth.paperCut();
  }
}
