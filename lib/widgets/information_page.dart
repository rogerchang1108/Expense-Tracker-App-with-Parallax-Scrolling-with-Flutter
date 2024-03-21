import 'dart:math';
import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() {
    return _InformationPageState();
  }
}

class _InformationPageState extends State<InformationPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Information'),
      // ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          _buildPage(
            Icons.swipe, 
            'Swipe to Continue',
            () {
              _pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.ease);
            },
            'Next'
          ),
          _buildPage(
            Icons.check_circle_outline,
            'Finish Tutorial',
            () {
              Navigator.of(context).pop();
            },
            'Done'
          ),
        ],
      ),
    );
  }

  Widget _buildPage(IconData iconData, String labelText, VoidCallback onPressed, String buttonText) {
    double iconSize = min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) / 2;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: iconSize ,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          const SizedBox(height: 10.0),
          Text(
            labelText,
            style: const TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: onPressed,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
