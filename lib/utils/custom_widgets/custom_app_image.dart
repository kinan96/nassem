import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/colors.dart';
import '../shimmers/custom_shimmer_builder.dart';

class CustomImage extends StatelessWidget {
  final String? urlImage;
  final String? assetImage;
  final String? svgAsset;
  final File? fileImage;
  final BorderRadius? borderRadius;
  final BoxFit? fit;
  final Color? color;
  final Color? borderColor;
  final bool isHero;
  final Widget? placeHolder;
  final bool shimmerUntil;
  final double? width, height;
  final EdgeInsets? padding;
  const CustomImage({
    Key? key,
    this.color,
    this.svgAsset,
    this.placeHolder,
    this.shimmerUntil = false,
    this.width,
    this.borderColor,
    this.isHero = false,
    this.height,
    this.padding,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.urlImage,
    this.assetImage,
    this.fileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return Container(
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: borderColor == null
              ? null
              : Border.all(color: borderColor ?? AppColors.white),
          borderRadius: borderRadius ?? BorderRadius.zero,
        ),
        child: (shimmerUntil && urlImage == null)
            ? placeHolder ??
                Center(
                    child: CustomShimmerBuilder(
                        child: SvgPicture.asset("assets/images/logo.svg")))
            : fileImage != null
                ? ClipRRect(
                    borderRadius: borderRadius ?? BorderRadius.zero,
                    child: isHero
                        ? Hero(tag: fileImage?.path ?? "", child: _file())
                        : _file(),
                  )
                : urlImage != null
                    ? (ClipRRect(
                        borderRadius: borderRadius ?? BorderRadius.zero,
                        child: isHero
                            ? Hero(
                                tag: urlImage?.replaceAll("http:", "https:") ??
                                    "",
                                child: _url())
                            : _url()))
                    : (svgAsset != null
                        ? (ClipRRect(
                            borderRadius: borderRadius ?? BorderRadius.zero,
                            child: isHero
                                ? Hero(tag: svgAsset ?? "", child: _svg())
                                : _svg()))
                        : placeHolder ??
                            ClipRRect(
                              borderRadius: borderRadius ?? BorderRadius.zero,
                              child: Image.asset(
                                assetImage!,
                                width: width,
                                color: color,
                                height: height,
                                fit: fit,
                                errorBuilder: (context, e, s) =>
                                    CustomShimmerBuilder(
                                        child: SvgPicture.asset(
                                            "assets/images/logo.svg")),
                              ),
                            )),
      );
    } catch (e) {
      return CustomShimmerBuilder(
          child: SvgPicture.asset("assets/images/logo.svg"));
    }
  }

  _file() {
    return Image.file(
      fileImage ?? File(""),
      width: width,
      color: color,
      height: height,
      fit: fit,
      errorBuilder: (context, e, s) => CustomShimmerBuilder(
          child: SvgPicture.asset("assets/images/logo.svg")),
    );
  }

  _url() {
    return CachedNetworkImage(
        imageUrl: urlImage?.replaceAll("http:", "https:") ?? "",
        width: width,
        height: height,
        color: color,
        errorWidget: (context, e, s) => CustomShimmerBuilder(
            child: SvgPicture.asset("assets/images/logo.svg")),
        placeholder: (context, url) {
          return ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.zero,
            child: placeHolder ??
                CustomShimmerBuilder(
                    child: SvgPicture.asset("assets/images/logo.svg")),
          );
        },
        imageBuilder: (context, imageP) => SizedBox(
              width: width,
              height: height,
              child: ClipRRect(
                borderRadius: borderRadius ?? BorderRadius.zero,
                child: Image(
                  image: imageP,
                  color: color,
                  fit: fit,
                  width: width,
                  height: height,
                  errorBuilder: (context, e, s) => CustomShimmerBuilder(
                      child: SvgPicture.asset("assets/images/logo.svg")),
                ),
              ),
            ));
  }

  _svg() {
    if (svgAsset == null) {
      return null;
    }
    return SvgPicture.asset(
      svgAsset!,
      width: width,
      color: color,
      height: height,
      fit: fit ?? BoxFit.fitWidth,
    );
  }
}
