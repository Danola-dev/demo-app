import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/providers/brand_filter_provider.dart';
import 'package:demo_app/widgets/shoe_grid_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String? name;
  String? image;
  @override
  void initState() {
    super.initState();
    getUsername();
    getUserimage();
  }

  Future<void> getUsername() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    setState(() {
      name = doc['username'];
    });
  }

  Future<void> getUserimage() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection('user_img')
        .doc(uid)
        .get();

    setState(() {
      image = doc['image_url'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredShoes = ref.watch(filteredShoesProvider);
    final selectedBrand = ref.watch(selectedBrandProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name == null ? '' : 'Hi $name',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Good morning!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                CircleAvatar(
                  backgroundImage: NetworkImage(image == null ? '' : image!),
                  radius: 50,
                ),
              ],
            ),
            SizedBox(height: 23),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  height: 59,
                  width: 59,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(child: _buildChip(ref, 'All', null, selectedBrand)),
                Container(
                  child: _buildChip(ref, 'Nike', 'Nike', selectedBrand),
                ),
                Container(
                  child: _buildChip(ref, 'Adidas', 'Adidas', selectedBrand),
                ),
                Container(
                  child: _buildChip(ref, 'Converse', 'Converse', selectedBrand),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                itemCount: filteredShoes.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.76,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final shoe = filteredShoes[index];
                  return ShoeGridItem(shoe: shoe);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(
    WidgetRef ref,
    String label,
    String? brand,
    String? selectedBrand,
  ) {
    final isSelected = selectedBrand == brand;

    return GestureDetector(
      onTap: () => ref.read(selectedBrandProvider.notifier).state = brand,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
