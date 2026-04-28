import 'package:demo_app/models/shoes.dart';
import 'package:demo_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/screens/shoe_details_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_app/widgets/banner_widget.dart';

class CartItem extends ConsumerWidget {
  const CartItem({super.key, required this.shoe});

  final Shoes shoe;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 4, top: 20),
      child: Padding(
        padding: const EdgeInsets.only(top: 13),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) {
                  return ShoeDetailsScreen(shoe: shoe);
                },
              ),
            );
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      child: Image(image: NetworkImage(shoe.imageUrl)),
                    ),
                    SizedBox(width: 19),
                    Column(
                      children: [
                        Text(
                          shoe.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 1),
                        Text(
                          '\$${shoe.price}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, bottom: 12),
                child: TextButton(
                  onPressed: () {
                    showTopBanner(context, 'Product was removed from cart');
                    ref.read(cartProvider.notifier).removeItem(shoe);
                  },
                  child: Text(
                    'Remove',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
