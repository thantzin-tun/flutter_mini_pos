import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/constants/dimensions.dart';
import 'package:flutter_bloc_demo/constants/styles.dart';
import 'package:flutter_bloc_demo/resources/colors.dart';
import 'package:flutter_bloc_demo/widgets/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDeleteDialog extends StatelessWidget {
  final VoidCallback onDelete;
  final String deleteText;

  const CustomDeleteDialog({
    super.key,
    required this.onDelete,
    required this.deleteText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 600,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.info_outline),
                  const SizedBox(width: 10),
                  Text(
                    "စာရင်းမှဖျက်ရန်",
                    style: KTextStyle.deleteTextStyle,
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset('assets/icons/close.svg')),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                deleteText,
                style: KTextStyle.confirmTextStyle
                    .copyWith(color: KColor.SECONDARY_COLOR),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    text: "မလုပ်တော့ပါ",
                    textColor: KColor.NORMAL_COLOR,
                    backgroundColor: KColor.PRIMARY_COLOR,
                    action: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: PRIMARY_GAP),
                  CustomButton(
                    text: "ဖျက်မည်",
                    textColor: KColor.NORMAL_COLOR,
                    backgroundColor: KColor.TRINARY_COLOR,
                    action: onDelete,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
