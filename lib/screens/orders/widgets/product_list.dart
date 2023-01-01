import 'package:flutter/material.dart';
import 'package:nassem/utils/custom_widgets/custom_app_image.dart';
import 'package:nassem/utils/custom_widgets/custom_price_row.dart';
import 'package:nassem/utils/custom_widgets/custom_text.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomImage(
          urlImage:
              "https://i.picsum.photos/id/297/536/354.jpg?hmac=FUNXwbNpJpjLHIDJ5skSQWj4ETqgiWEWx6pSGYCNyp4",
          width: 70,
          height: 70,
          borderRadius: BorderRadius.circular(10),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: CustomText(
          "بوكيه ورد جميل",
        )),
        const SizedBox(
          width: 10,
        ),
        PriceRow(
          price: 100,
        )
      ],
    );
  }
}
