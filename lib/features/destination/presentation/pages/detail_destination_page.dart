import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:travel/features/destination/domain/entities/destination_entity.dart';
import 'package:travel/features/destination/presentation/widgets/gallery_photos.dart';
import 'package:travel/features/destination/presentation/widgets/item_detail_destination_image.dart';

class DetailDestinationPage extends StatefulWidget {
  const DetailDestinationPage({super.key, required this.destination});
  final DestinationEntity destination;

  @override
  State<DetailDestinationPage> createState() => _DetailDestinationPageState();
}

class _DetailDestinationPageState extends State<DetailDestinationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          const SizedBox(
            height: 10,
          ),
          gallery(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    location(),
                    const SizedBox(
                      height: 4,
                    ),
                    category()
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  rate(),
                  const SizedBox(
                    height: 4,
                  ),
                  rateCount()
                ],
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          facilities(),
          const SizedBox(
            height: 24,
          ),
          details(),
          const SizedBox(
            height: 24,
          ),
          reviews(),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        widget.destination.name,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        margin:
            EdgeInsets.only(left: 20, top: MediaQuery.of(context).padding.top),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }

  gallery() {
    List patternGallery = [
      const StaggeredTile.count(3, 3),
      const StaggeredTile.count(2, 1.5),
      const StaggeredTile.count(2, 1.5),
    ];
    return StaggeredGridView.countBuilder(
        crossAxisCount: 5,
        shrinkWrap: true,
        itemCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        physics: const NeverScrollableScrollPhysics(),
        staggeredTileBuilder: (index) {
          return patternGallery[index % patternGallery.length];
        },
        itemBuilder: (conetxt, index) {
          if (index == 2) {
            return GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (conetxt) =>
                        GalleryPhotos(images: widget.destination.images));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ItemDetailDestinationImage(
                        destination: widget.destination, index: index),
                    Container(
                      color: Colors.black.withOpacity(0.3),
                      alignment: Alignment.center,
                      child: const Text(
                        '+ More',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return ItemDetailDestinationImage(
              destination: widget.destination, index: index);
        });
  }

  location() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: 20,
            height: 20,
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.location_on,
              color: Theme.of(context).primaryColor,
              size: 20,
            )),
        const SizedBox(
          width: 4,
        ),
        Flexible(
          child: Text(
            widget.destination.location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        )
      ],
    );
  }

  category() {
    return Row(
      children: [
        Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            child: Icon(
              Icons.fiber_manual_record,
              color: Theme.of(context).primaryColor,
              size: 15,
            )),
        const SizedBox(
          width: 4,
        ),
        Text(
          widget.destination.category,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        )
      ],
    );
  }

  rate() {
    return RatingBar.builder(
      initialRating: widget.destination.rate,
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
    );
  }

  rateCount() {
    String rate = DMethod.numberAutoDigit(widget.destination.rate);
    String rateCount =
        NumberFormat.compact().format(widget.destination.rateCount);
    return Text(
      '${rate} / $rateCount reviews',
      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
    );
  }

  facilities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Facilities',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...widget.destination.facilities.map((facility) {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.radio_button_checked,
                      size: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      facility,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    )
                  ],
                )
              ],
            ),
          );
        })
      ],
    );
  }

  details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          widget.destination.description,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        )
      ],
    );
  }

  reviews() {
    List list = [
      [
        'John Dipsy',
        'assets/images/p1.jpg',
        4.5,
        'Best place to visit. Highly recommended!',
        '2023-01-02'
      ],
      [
        'Sarah Smith',
        'assets/images/p2.jpg',
        4.7,
        'Lovely experience, will visit again.',
        '2023-02-15'
      ],
      [
        'Michael Brown',
        'assets/images/p3.jpg',
        4.5,
        'Great ambiance and friendly staff.',
        '2023-03-12'
      ],
      [
        'Emily Davis',
        'assets/images/p4.jpg',
        5.0,
        'Absolutely fantastic! A must-see spot!',
        '2023-04-08'
      ],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reviews',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        ...list.map((review) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(review[1]),
                  radius: 15,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              review[0],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          RatingBar.builder(
                            initialRating: review[2].toDouble(),
                            unratedColor: Colors.grey,
                            itemSize: 12,
                            allowHalfRating: true,
                            itemBuilder: (context, index) {
                              return const Icon(
                                Icons.star,
                                color: Colors.amber,
                              );
                            },
                            onRatingUpdate: (value) {},
                          ),
                          const Spacer(),
                          Text(
                            DateFormat('d MMM')
                                .format(DateTime.parse(review[4])),
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          )
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Text(review[3], style:const TextStyle(color: Colors.black54) ,)
                    ],
                  ),
                )
              ],
            ),
          );
        })
      ],
    );
  }
}
