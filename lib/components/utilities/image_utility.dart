import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healy_survey/components/constant/common/app_constant.dart';
import 'package:healy_survey/components/widgets/common/common_loader_widget.dart';

class ImageUtility {

  // to get the image through from url
  static Widget getSurveyImage(String? url, BoxFit? boxFit) {
    if (url != null) {
      return CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) => const CommonLoaderWidget(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: boxFit);
    }
    return Image.asset(logoUrl);
  }
}
