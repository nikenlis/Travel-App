import 'package:d_method/d_method.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travel/api/urls.dart';
import 'package:travel/features/destination/domain/entities/destination_entity.dart';
import 'package:travel/features/destination/presentation/widgets/parallax_horizontal_delegate.dart';

import 'circle_loading.dart';

class ItemTopDestination extends StatelessWidget {
  const ItemTopDestination({super.key, required this.destination});
  final DestinationEntity destination;

  @override
  Widget build(BuildContext context) {
    final imageKey = GlobalKey();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Expanded(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Builder(builder: (context) {
              return Flow(
                delegate: ParallaxHorizontalDelegate(
                    scrollable: Scrollable.of(context),
                    listItemContext: context,
                    backgroundImageKey: imageKey),
                children: [
                  ExtendedImage.network(
                    URLs.image(destination.cover),
                    key: imageKey,
                    fit: BoxFit.cover,
                    width: double.infinity,
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
                      if (state.extendedImageLoadState == LoadState.loading) {
                        return AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Material(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey[300],
                            child: const CircleLoading(),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ],
              );
            }),
          )),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination.name,
                      style: const TextStyle(
                          height: 1, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Container(
                            width: 15,
                            height: 15,
                            alignment: Alignment.centerLeft,
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.grey,
                              size: 15,
                            )),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          destination.location,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            width: 15,
                            height: 15,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.fiber_manual_record,
                              color: Colors.grey,
                              size: 10,
                            )),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          destination.category,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: destination.rate,
                        allowHalfRating: true,
                        unratedColor: Colors.grey,
                        itemSize: 15,
                        ignoreGestures: true,
                        itemBuilder: (context, index) {
                          return const Icon(
                            Icons.star,
                            color: Colors.amber,
                          );
                        },
                        onRatingUpdate: (value) {},
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        '(${DMethod.numberAutoDigit(destination.rate)})',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.favorite_border))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
