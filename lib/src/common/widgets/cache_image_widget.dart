import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:shimmer/shimmer.dart';

import '../../../generated/colors.gen.dart';
import '../utils/image_utils.dart';

class CacheImageWidget extends StatelessWidget {
  const CacheImageWidget(
      {super.key, required this.url, this.fit = BoxFit.cover});
  final String url;
  final BoxFit fit;

 

  @override
  Widget build(BuildContext context) {
    if (isAvifFormat(url)) {
      return AvifImage.network(
        url,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        ),
        placeholder: (context, url) => Shimmer.fromColors(
            baseColor: ColorName.grey8E8E8E,
            highlightColor: ColorName.grey626262,
            child: const SizedBox(
              width: double.infinity,
              height: double.infinity,
            )),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }
  }
}
