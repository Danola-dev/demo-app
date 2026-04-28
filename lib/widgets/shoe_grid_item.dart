import 'package:demo_app/models/shoes.dart';
import 'package:demo_app/screens/shoe_details_screen.dart';
import 'package:flutter/material.dart';

class ShoeGridItem extends StatefulWidget {
  const ShoeGridItem({super.key, required this.shoe});

  final Shoes shoe;

  @override
  State<ShoeGridItem> createState() => _ShoeGridItemState();
}

class _ShoeGridItemState extends State<ShoeGridItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) {
              return ShoeDetailsScreen(shoe: widget.shoe);
            },
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: Image(image: NetworkImage(widget.shoe.imageUrl)),
          ),

          Text(widget.shoe.title, style: TextStyle(fontSize: 15)),
          Text(
            '\$${widget.shoe.price}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
