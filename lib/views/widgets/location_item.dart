import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/location_item_model.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LocationItemWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final Color borderColor;
  final LocationItemModel location;
  const LocationItemWidget({
    super.key,
    this.onTap,
    this.borderColor = AppColors.grey,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.city,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "${location.city}, ${location.country}",
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: AppColors.grey),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(radius: 43, backgroundColor: borderColor),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: CachedNetworkImageProvider(
                      location.imgUrl,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
