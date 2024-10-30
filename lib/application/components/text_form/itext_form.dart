import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_boilerplate/application/helper/size_config.dart';

class ITextForm extends StatelessWidget {
  final String? label;
  final String? helperText, initialValue, hintText, errorText;
  final VoidCallback? onTap;
  final bool enabled, readOnly, obscureText, textarea, isTextAlignCenter, disableColor;
  final TextEditingController? ctrl;
  final Widget? suffixIcon, suffixLabel, prefixIcon, prefix, trailingTitleWidget;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? errorStyle, hintTextStyle;
  final Color? enabledBorderColor, focusedBorderColor;
  final BoxConstraints? suffixIconConstraints, prefixIconConstraints;
  final Color? disabledBorderColor;
  final bool? enableInteractiveSelection;
  final Color? fontColorDisabled;
  final EdgeInsets? contentPadding;
  final FocusNode? focusNode;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  const ITextForm(
      {super.key,
      this.label,
      this.helperText,
      this.initialValue,
      this.onTap,
      this.enabled = true,
      this.readOnly = false,
      this.hintText,
      this.errorText,
      this.ctrl,
      this.suffixIcon,
      this.suffixLabel,
      this.prefixIcon,
      this.prefix,
      this.keyboardType,
      this.validator,
      this.obscureText = false,
      this.maxLength,
      this.onChanged,
      this.inputFormatters,
      this.errorStyle,
      this.hintTextStyle,
      this.enabledBorderColor,
      this.focusedBorderColor,
      this.textarea = false,
      this.isTextAlignCenter = false,
      this.trailingTitleWidget,
      this.suffixIconConstraints,
      this.prefixIconConstraints,
      this.disableColor = false,
      this.disabledBorderColor,
      this.enableInteractiveSelection,
      this.fontColorDisabled,
      this.contentPadding,
      this.focusNode,
      this.borderRadius,
      this.padding});

  @override
  Widget build(BuildContext context) {
    final borderRadiusCircular = BorderRadius.all(Radius.circular(borderRadius ?? SizeConfig.kDefaultBorderRadius));
    return Padding(
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: SizeConfig.kDefaultPadding,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (label != null)
              ? Padding(
                  padding: EdgeInsets.only(bottom: SizeConfig.kDefaultPadding * 1),
                  child: Text(
                    label ?? '',
                    style: TextStyle(
                      fontSize: SizeConfig.baseFontSize * 6,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                )
              : const SizedBox(),
          TextFormField(
            focusNode: focusNode,
            minLines: textarea ? 8 : 1,
            maxLines: textarea ? null : 1,
            maxLength: maxLength,
            initialValue: initialValue,
            enabled: enabled,
            controller: ctrl,
            keyboardType: keyboardType,
            onTap: onTap,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: SizeConfig.baseFontSize * 5.5,
              color: fontColorDisabled ?? Colors.black,
            ),
            readOnly: readOnly,
            validator: validator,
            obscureText: obscureText,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            enableInteractiveSelection: enableInteractiveSelection,
            textAlign: isTextAlignCenter ? TextAlign.center : TextAlign.left,
            decoration: InputDecoration(
                helperText: helperText,
                errorStyle: errorStyle,
                errorText: errorText,
                errorMaxLines: 2,
                counterText: '',
                hintStyle: hintTextStyle ??
                    TextStyle(
                      fontSize: SizeConfig.baseFontSize * 5.5,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                isDense: true,
                hintText: hintText,
                filled: true,
                fillColor: enabled && disableColor == false ? Colors.white : Colors.white70,
                disabledBorder: OutlineInputBorder(
                  borderRadius: borderRadiusCircular,
                  borderSide: BorderSide(
                    color: disabledBorderColor ?? Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: borderRadiusCircular,
                  borderSide: BorderSide(
                    color: enabledBorderColor ?? Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: borderRadiusCircular,
                  borderSide: BorderSide(
                    color: focusedBorderColor ?? Colors.grey,
                  ),
                ),
                border: OutlineInputBorder(borderRadius: borderRadiusCircular),
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                suffixIconConstraints: suffixIconConstraints,
                prefixIconConstraints: prefixIconConstraints,
                prefix: prefix,
                contentPadding: contentPadding ??
                    EdgeInsets.symmetric(
                      horizontal: SizeConfig.kDefaultPadding * 2,
                      vertical: SizeConfig.kDefaultPadding * 2,
                    )),
          )
        ],
      ),
    );
  }
}
