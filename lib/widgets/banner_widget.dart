import 'package:flutter/material.dart';

class TopBanner extends StatefulWidget {
  final String message;
  final VoidCallback onClose;

  const TopBanner({required this.message, required this.onClose});

  @override
  State<TopBanner> createState() => _TopBannerState();
}

class _TopBannerState extends State<TopBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slide;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    slide = Tween(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slide,
      child: Material(
        color: Colors.green,
        child: Container(
          height: 110,
          width: double.infinity,
          padding: EdgeInsets.only(top: 40, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),

              GestureDetector(
                onTap: widget.onClose,
                child: Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
