import 'package:aljouf/constants/colors.dart';
import 'package:aljouf/product/models/review.dart';
import 'package:aljouf/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomReviewItem extends StatelessWidget {
  const CustomReviewItem({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: review.author!,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(
                  height: 8,
                ),
                RatingBar.builder(
                  initialRating: double.parse(review.rating.toString()),
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  ignoreGestures: true,
                  itemSize: 18,
                  unratedColor: darkGrey,
                  onRatingUpdate: (rating) {},
                  itemBuilder: (BuildContext context, int index) {
                    return const Icon(
                      Icons.star,
                      color: Colors.amber,
                    );
                  },
                ),
              ],
            ),
            CustomText(
              text: review.dateAdded!,
              color: brownishGrey,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        CustomText(
          text: review.text!,
          fontWeight: FontWeight.w400,
          color: brownishGrey,
        ),
      ],
    );
  }
}
