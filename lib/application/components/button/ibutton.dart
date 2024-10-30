import 'package:flutter/material.dart';
import 'package:mobile_boilerplate/application/constant/color_palette.dart';
import 'package:mobile_boilerplate/application/helper/size_config.dart';

class IButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final Widget? prefixIcon, suffixIcon;
  final double? height, width, marginVertical;
  final EdgeInsetsGeometry? contentPadding;
  final bool isSecondaryColor, isOutlined, heightWrapContent, disabled;
  final Color? backgroundColor, textColor, borderColor, disabledBgColor;
  final MainAxisAlignment? mainAxisAlignmentContent;
  final _widthBtn = SizeConfig.screenWidth * .9;
  final _heightBtn = SizeConfig.screenHeight * .08;
  final FontWeight? fontWeight;
  final TextAlign textAlign;
  final double? fontSize, sizeBorderRadius;
  final int? maxLines;
  final EdgeInsetsGeometry? paddingContent;

  IButton({
    super.key,
    required this.name,
    required this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.height,
    this.width,
    this.marginVertical,
    this.contentPadding,
    this.isSecondaryColor = false,
    this.isOutlined = false,
    this.heightWrapContent = false,
    this.disabled = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.disabledBgColor,
    this.mainAxisAlignmentContent,
    this.fontWeight,
    this.textAlign = TextAlign.center,
    this.fontSize,
    this.sizeBorderRadius,
    this.maxLines,
    this.paddingContent,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: marginVertical ?? SizeConfig.kDefaultMargin),
        width: width ?? _widthBtn,
        height: heightWrapContent ? null : height ?? _heightBtn,
        child: ElevatedButton(
            onPressed: disabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: paddingContent ?? EdgeInsets.all(SizeConfig.kDefaultPadding),
              backgroundColor: backgroundColor ?? (isOutlined ? Colors.white : ColorPalette.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(sizeBorderRadius ?? SizeConfig.kDefaultBorderRadius),
                side: isOutlined ? BorderSide(color: borderColor ?? ColorPalette.primary) : BorderSide.none,
              ),
            ),
            child: Row(
              mainAxisAlignment: mainAxisAlignmentContent ??
                  (prefixIcon != null
                      ? MainAxisAlignment.start
                      : suffixIcon != null
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.center),
              children: [
                if (prefixIcon != null) ...[
                  Container(
                    child: prefixIcon!,
                  ),
                ] else
                  const SizedBox(),
                (name.isNotEmpty)
                    ? Center(
                        child: Text(
                          name,
                          textAlign: textAlign,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: fontSize ?? SizeConfig.baseFontSize * 6,
                            fontWeight: fontWeight ?? FontWeight.w500,
                            color: textColor ?? (disabled ? Colors.white : Colors.white),
                          ),
                        ),
                      )
                    : const SizedBox(),
                if (suffixIcon != null) ...[
                  Flexible(child: suffixIcon!),
                ] else
                  const SizedBox(),
              ],
            )),
      ),
    );
  }
}
