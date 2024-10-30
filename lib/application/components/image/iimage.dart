import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_boilerplate/application/constant/color_palette.dart';
import 'package:mobile_boilerplate/application/helper/size_config.dart';

class IImage extends StatelessWidget {
  final dynamic image;
  final double? height, width, borderRadius;
  final BoxFit? fit;
  final Color? loadingColor;
  final Widget? loadingWidget, errorWidget;

  const IImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.borderRadius,
    this.fit,
    this.loadingColor,
    this.loadingWidget,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final errWidget = errorWidget ??
        Icon(
          Icons.image_not_supported_outlined,
          size: SizeConfig.screenWidth * .1,
          color: Colors.grey,
        );
    if (image is String) {
      var image = this.image as String;
      if (image.isNotEmpty) {
        if (image.startsWith("https") || image.startsWith("http")) {
          if (image.contains('null')) {
            return errWidget;
          }
          return ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius ?? SizeConfig.kDefaultBorderRadius / 2),
            child: CachedNetworkImage(
              imageUrl: image,
              width: width,
              height: height,
              fit: fit,
              placeholder: (context, url) {
                return loadingWidget ??
                    const Center(
                      child: CircularProgressIndicator(
                        color: ColorPalette.primary,
                        backgroundColor: Colors.transparent,
                      ),
                    );
              },
              errorWidget: (context, _, x) {
                return errWidget;
              },
            ),
          );
        } else if (image.startsWith("assets")) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius ?? SizeConfig.kDefaultBorderRadius / 2),
            child: Image.asset(
              image,
              height: height,
              width: width,
              fit: fit,
            ),
          );
        } else {
          Uint8List imgBytes = Uint8List.fromList(base64.decode(image));
          return Image.memory(
            imgBytes,
            height: height,
            width: width,
            fit: fit,
          );
        }
      }
    }
    if (image is File) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? SizeConfig.kDefaultBorderRadius / 2),
        child: Image.file(
          image,
          height: height,
          width: width,
          fit: fit,
        ),
      );
    }
    return errWidget;
  }
}
