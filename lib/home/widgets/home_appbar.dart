import 'package:ecomm/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key, required this.appBar}) : super(key: key);
  final AppBar appBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      title: Text(
        'Home',
        style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 35),
      ),
      centerTitle: true,
      actions: <Widget>[
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded) {
              return IconButton(
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                ),
                onPressed: () {
                  BlocProvider.of<HomeBloc>(context)
                      .add(HomeEventLogout(context));
                },
              );
            }
            return Container();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
