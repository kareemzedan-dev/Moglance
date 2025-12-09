import 'package:flutter/material.dart';
import 'package:taskly/core/utils/colors_manger.dart';

class ReceiveOffers extends StatefulWidget {
  const ReceiveOffers({super.key});

  @override
  State<ReceiveOffers> createState() => _ReceiveOffersState();
}

bool? isChecked = false;

class _ReceiveOffersState extends State<ReceiveOffers> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked!;
            });
          },
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isChecked! ? ColorsManager.primary : Colors.transparent,
              border: Border.all(color: ColorsManager.primary, width: 2.0),
              borderRadius: BorderRadius.circular(4),
            ),
            child:
                isChecked!
                    ? const Center(
                      child: Icon(Icons.done, color: Colors.white, size: 16),
                    )
                    : null,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'Yes, I want to receive offers and discounts',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
