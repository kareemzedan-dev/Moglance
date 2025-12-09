


import 'package:flutter/material.dart';

Container CircularIconButton({String? image}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
      ),
      child: Card(
        shadowColor: Colors.transparent,
        elevation: 4,
        child: Center(child: Image.asset(image!, height: 24, width: 24)),
      ),
    );
  }
