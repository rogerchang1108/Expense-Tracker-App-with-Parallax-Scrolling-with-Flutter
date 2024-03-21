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
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
      // ignore: avoid_print
      print(_currentPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Information'),
      // ),
      body: PageView(
        controller: _pageController,
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
    double textOffset = buttonText == 'Next' ? -(_currentPage * MediaQuery.of(context).size.width / 2)
                                             : MediaQuery.of(context).size.width / 2 
                                               - (_currentPage * MediaQuery.of(context).size.width / 2);
    double buttonOffset = buttonText == 'Next' ? -(_currentPage * MediaQuery.of(context).size.width)
                                             : MediaQuery.of(context).size.width 
                                               - (_currentPage * MediaQuery.of(context).size.width);                                          
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.translate(
            offset: const Offset(0, 0),
            child: Icon(
              iconData,
              size: iconSize ,
            )
          ),
          const SizedBox(height: 10.0),
          Transform.translate(
            offset: Offset(textOffset, 0),
            child: Text(
              labelText,
              style: const TextStyle(fontSize: 18.0),
            )
          ),
          const SizedBox(height: 20.0),
          Transform.translate(
            offset: Offset(buttonOffset, 0),
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(buttonText),
            )
          ),
        ],
      ),
    );
  }
}
