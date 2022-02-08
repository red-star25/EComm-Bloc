import 'package:ecomm/constants/assets.dart';
import 'package:ecomm/intro/bloc/intro_bloc.dart';
import 'package:ecomm/intro/widgets/intro_view_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IntroBloc()..add(IntroStarted()),
      child: BlocListener<IntroBloc, IntroState>(
        listener: (context, state) {
          if (state is IntroSuccessful) {
            Navigator.of(context).pushReplacementNamed('/signin');
          }
        },
        child: Scaffold(
          body: PageView(
            controller: _pageController,
            children: [
              IntroPageItem(
                introTitleText: 'DISCOVER & BUY',
                introSubtitleText:
                    'Find what you are looking for and save your favoirutes on your wishlist',
                imageUrl: Assets.intro1,
                hasNext: true,
                controller: _pageController,
              ),
              IntroPageItem(
                introTitleText: 'EASY PAY',
                introSubtitleText:
                    'Make an order and pay online or after you pick up your purchase at store',
                imageUrl: Assets.intro2,
                hasNext: true,
                controller: _pageController,
              ),
              IntroPageItem(
                introTitleText: 'FREE SHIPPING',
                introSubtitleText:
                    'Track your parcel in real time or pick it up at the nearest store',
                imageUrl: Assets.intro3,
                hasNext: false,
                controller: _pageController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
