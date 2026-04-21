import 'package:flutter/material.dart';

class CustomButtonWithImage extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final String text;

  final Widget? leftIcon;
  final Widget? rightIcon;

  final bool disabled;
  final String? error;

  final EdgeInsetsGeometry? padding;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final TextStyle? textStyle;

  const CustomButtonWithImage({
    super.key,
    required this.onPressed,
    required this.text,
    this.onLongPress,
    this.leftIcon,
    this.rightIcon,
    this.disabled = false,
    this.error,
    this.padding,
    this.height = 48,
    this.borderRadius = 10,
    this.backgroundColor = const Color(0xFF007BFF), // replace with GlobalColor.Primary
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: disabled ? null : onPressed,
          onLongPress: onLongPress,
          child: Opacity(
            opacity: disabled ? 0.6 : 1,
            child: Container(
              height: height,
              width: MediaQuery.of(context).size.width * 0.9,
              padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leftIcon != null) ...[
                    leftIcon!,
                    const SizedBox(width: 10),
                  ],

                  Flexible(
                    child: Text(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle ??
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),

                  if (rightIcon != null) ...[
                    const SizedBox(width: 10),
                    rightIcon!,
                  ],
                ],
              ),
            ),
          ),
        ),

        // ✅ Error UI
        if (error != null && error!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 14,
                  color: Colors.red,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    error!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}