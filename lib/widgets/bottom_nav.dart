import 'package:ecomm/constants/colors.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  BottomNav({Key? key, required this.currentIndex}) : super(key: key);
  int currentIndex;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: (value) {
        switch (value) {
          case 0:
            setState(() {
              widget.currentIndex = value;
            });
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            setState(() {
              widget.currentIndex = value;
            });
            Navigator.pushNamed(context, '/favourite');
            break;
          case 2:
            setState(() {
              widget.currentIndex = value;
            });
            Navigator.pushNamed(context, '/cart');
            break;
          default:
        }
      },
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 30,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_rounded),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
      ],
      selectedItemColor: AppColors.buttonColor,
    );
  }
}
