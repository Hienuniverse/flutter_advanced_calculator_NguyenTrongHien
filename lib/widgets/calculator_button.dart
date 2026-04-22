import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isFlex; //Dùng cho nút số '0' nếu muốn nó rộng hơn

  const CalculatorButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.isFlex = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Sử dụng InkWell để có hiệu ứng ripple (gợn sóng) khi bấm
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16), //Border radius theo spec
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24, //Medium theo spec cho display, nút có thể chỉnh nhỏ lại một chút
              fontWeight: FontWeight.w500,
              color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
      ),
    );
  }
}