import 'package:demo_app/models/shoes.dart';
import 'package:demo_app/providers/cart_provider.dart';
import 'package:demo_app/screens/tabs_screen.dart';
import 'package:demo_app/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key, required this.shoes});
  final List<Shoes> shoes;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(cartProvider.notifier).totalPrice;
    Widget content = Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: shoes.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CART SUMMARY', style: TextStyle(fontSize: 21)),
                      Divider(),
                      Row(
                        children: [
                          Text('Subtotal', style: TextStyle(fontSize: 19)),
                          Spacer(),
                          Text('\$$total', style: TextStyle(fontSize: 19)),
                        ],
                      ),
                    ],
                  ),
                );
              }
              final item = shoes[index - 1];
              return CartItem(shoe: item);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue,
              ),
              onPressed: () {},
              child: Text(
                'Checkout',
                style: TextStyle(fontSize: 19, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
    if (shoes.isEmpty) {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your cart is empty!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'Browse our categories and discover our best deals.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return TabsScreen();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  'Start Shopping',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(51, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 27),
        ),
      ),
      body: Column(children: [Expanded(child: content)]),
    );
  }
}
