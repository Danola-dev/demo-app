import 'package:flutter/material.dart';

class Shoes {
  const Shoes({
    required this.id,
    required this.category,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.color,
    required this.size,
    required this.details,
  });
  final String id;
  final String category;
  final String title;
  final String imageUrl;
  final int price;
  final double rating;
  final String details;
  final List<Color> color;
  final List<int> size;
}
