import 'package:demo_app/models/shoes.dart';
import 'package:demo_app/screens/tabs_screen.dart';
import 'package:demo_app/widgets/shoe_item.dart';
import 'package:flutter/material.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key, required this.shoes});

  final List<Shoes> shoes;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: shoes.length,
      itemBuilder: (context, index) {
        return ShoeItem(shoe: shoes[index]);
      },
    );
    if (shoes.isEmpty) {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You haven't saved an item yet!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                  'Continue Shopping',
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: content,
    );
  }
}
