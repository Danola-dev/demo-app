import 'package:demo_app/models/shoes.dart';
import 'package:demo_app/providers/cart_provider.dart';
import 'package:demo_app/providers/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/widgets/size_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_app/widgets/banner_widget.dart';

class ShoeDetailsScreen extends ConsumerStatefulWidget {
  const ShoeDetailsScreen({super.key, required this.shoe});

  final Shoes shoe;

  @override
  ConsumerState<ShoeDetailsScreen> createState() => _ShoeDetailsScreenState();
}

class _ShoeDetailsScreenState extends ConsumerState<ShoeDetailsScreen> {
  int? selectedSize;
  @override
  Widget build(BuildContext context) {
    void showTopBanner(BuildContext context, String message) {
      final overlay = Overlay.of(context);

      late OverlayEntry overlayEntry;

      overlayEntry = OverlayEntry(
        builder: (context) {
          return Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopBanner(
              message: message,
              onClose: () => overlayEntry.remove(),
            ),
          );
        },
      );

      overlay.insert(overlayEntry);

      Future.delayed(Duration(seconds: 3), () {
        overlayEntry.remove();
      });
    }

    final favoriteShoe = ref.watch(favoriteShoeProvider);
    final isFavorite = favoriteShoe.contains(widget.shoe);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  final wasAdded = ref
                      .read(favoriteShoeProvider.notifier)
                      .toggleFavoriteShoe(widget.shoe);
                  showTopBanner(
                    context,
                    wasAdded
                        ? 'Product successfully added to favorites'
                        : 'Product was removed successfully',
                  );
                },
                icon: AnimatedSwitcher(
                  duration: Duration(milliseconds: 700),
                  transitionBuilder: (child, animation) => RotationTransition(
                    turns: Tween(begin: 0.8, end: 1.0).animate(animation),
                    child: child,
                  ),
                  child: Icon(
                    size: 30,
                    isFavorite ? Icons.star : Icons.star_border,
                    key: ValueKey(isFavorite),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 320,
              width: double.infinity,
              child: Image(
                image: NetworkImage(widget.shoe.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Text(
                    widget.shoe.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Spacer(),
                  Text(
                    '\$${widget.shoe.price}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: const Color.fromARGB(255, 22, 120, 199),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.blue, size: 29),
                  SizedBox(width: 5),
                  Text(
                    widget.shoe.rating.toString(),
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 13),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 6),
                  Text(widget.shoe.details),
                  SizedBox(height: 13),
                  Text(
                    'Color:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 13),
                  Row(
                    spacing: 21,
                    children: widget.shoe.color.map((color) {
                      return Container(
                        padding: EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(color: color),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Size:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 13),
                  GestureDetector(
                    onTap: () async {
                      final result = await showModalBottomSheet(
                        context: context,
                        builder: (context) =>
                            SizeSelector(sizes: widget.shoe.size),
                      );
                      if (result != null) {
                        setState(() {
                          selectedSize = result;
                        });
                      }
                    },
                    child: Container(
                      width: selectedSize == null ? 152 : 100,
                      padding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            selectedSize == null
                                ? 'Choose size'
                                : 'Size: $selectedSize',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 7),
                          if (selectedSize == null)
                            Icon(Icons.arrow_forward, size: 19),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).addItem(widget.shoe);
                      showTopBanner(context, 'Cart succesfully updated');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
