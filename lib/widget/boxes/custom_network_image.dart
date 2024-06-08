import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({super.key, required this.url, this.fit = BoxFit.cover, this.errorBuilder, this.height, this.width, this.alignment, this.margin, this.decoration});
  final String url;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final AlignmentGeometry? alignment;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      alignment: alignment,
      clipBehavior: Clip.antiAlias,
      decoration: decoration,
      child: Image.network(
        url,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return LinearProgressIndicator(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          if (errorBuilder != null) return errorBuilder!(context, error, stackTrace);
          return Container(
            color: Colors.white,
            child: Container(
              alignment: Alignment.center,
              color: Theme.of(context).primaryColor.withOpacity(0.8),
              child: const Icon(Icons.no_photography),
            ),
          );
        },
      ),
    );
  }
}
