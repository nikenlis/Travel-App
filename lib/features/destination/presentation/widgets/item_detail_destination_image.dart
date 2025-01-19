import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:travel/features/destination/domain/entities/destination_entity.dart';
import '../../../../api/urls.dart';

class ItemDetailDestinationImage extends StatelessWidget {
  const ItemDetailDestinationImage({super.key, required this.destination, required this.index});
  final DestinationEntity destination;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ExtendedImage.network(
                URLs.image(destination.images[index]),
                fit: BoxFit.cover,
                handleLoadingProgress: true,
                cache: true,
                loadStateChanged: (state) {
                  if (state.extendedImageLoadState == LoadState.failed) {
                    return AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            );
  }
}