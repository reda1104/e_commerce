import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final String? text;
  final String? imgUrl;
  final VoidCallback? onTap;
  final bool isLoading;

  SocialMediaButton({
    super.key,
    this.text,
    this.imgUrl,
    this.onTap,
    this.isLoading = false,
  }) {
    assert((text != null && imgUrl != null) || isLoading == true);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey, width: 1.5),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? const CircularProgressIndicator.adaptive()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: imgUrl!,
                      height: 30,
                      width: 30,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(width: 8),
                    Text(text!),
                  ],
                ),
        ),
      ),
    );
  }
}
