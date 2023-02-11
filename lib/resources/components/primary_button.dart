import 'package:flutter/material.dart';
import 'package:flutter_mvvm/resources/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final VoidCallback onPress;
  const PrimaryButton({
    super.key,
    required this.title,
    this.isLoading = false,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.buttonColor,
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator.adaptive()
              : Text(
                  title,
                  style: const TextStyle(
                    color: AppColor.whiteColor,
                  ),
                ),
        ),
      ),
    );
  }
}
