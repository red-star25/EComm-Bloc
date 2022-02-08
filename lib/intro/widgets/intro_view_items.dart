import 'package:ecomm/constants/colors.dart';
import 'package:ecomm/intro/intro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroPageItem extends StatelessWidget {
  const IntroPageItem({
    Key? key,
    required this.introTitleText,
    required this.introSubtitleText,
    required this.hasNext,
    required this.imageUrl,
    required this.controller,
  }) : super(key: key);

  final String introTitleText;
  final String introSubtitleText;
  final String imageUrl;
  final bool hasNext;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(160),
              bottomRight: Radius.circular(160),
            ),
          ),
        ),
        const SizedBox(height: 50),
        Column(
          children: [
            Text(
              introTitleText,
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 46),
              child: Text(
                introSubtitleText,
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (!hasNext) {
                    BlocProvider.of<IntroBloc>(context).add(IntroFinished());
                  } else {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: const BoxDecoration(
                      color: AppColors.buttonColor,
                    ),
                    child: Center(
                      child: hasNext
                          ? Text(
                              'NEXT',
                              style: Theme.of(context).textTheme.button,
                            )
                          : Text(
                              'Sign In',
                              style: Theme.of(context).textTheme.button,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
