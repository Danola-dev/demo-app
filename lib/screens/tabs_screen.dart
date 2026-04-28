import 'package:demo_app/providers/cart_provider.dart';
import 'package:demo_app/providers/favorites_provider.dart';
import 'package:demo_app/screens/cart_screen.dart';
import 'package:demo_app/screens/home_screen.dart';
import 'package:demo_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/screens/saved_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int pageIndex = 0;

  void selectPage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activepage = HomeScreen();
    final cartItems = ref.watch(cartProvider);

    if (pageIndex == 1) {
      var favoriteShoes = ref.watch(favoriteShoeProvider);
      activepage = SavedScreen(shoes: favoriteShoes);
    }

    if (pageIndex == 2) {
      var shoeCart = ref.watch(cartProvider);
      activepage = CartScreen(shoes: shoeCart);
    }

    if (pageIndex == 3) {
      activepage = ProfileScreen();
    }
    return Scaffold(
      body: activepage,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(color: Colors.blueAccent),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        currentIndex: pageIndex,
        onTap: selectPage,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.home, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.favorite, size: 28),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart, size: 30),
                if (cartItems.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: -5,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        cartItems.length.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.person, size: 36),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
