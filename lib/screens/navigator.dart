import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.png'),
          fit: BoxFit.cover
        ),
      ),
      child: ListView(
        children: [


        //  The First Container
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [

              ],
            ),
          ),
        ],
      ),
    );
  }
}
