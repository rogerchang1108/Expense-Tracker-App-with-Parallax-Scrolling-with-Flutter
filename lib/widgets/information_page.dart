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
            0,
            Icons.add,
            'Add expenses by clicking "+" on the app bar and filling out the form.',
            'Swipe to Continue',
            () {
              _pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.ease);
            },
            'Next'
          ),
          _buildPage(
            1,
            Icons.swipe,
            'Delete expenses by swiping the item in the expenses list.',
            'Swipe to Continue',
            () {
              _pageController.animateToPage(2, duration: const Duration(milliseconds: 500), curve: Curves.ease);
            },
            'Next'
          ),
          _buildPage(
            2,
            Icons.check_circle_outline,
            'Afterward, the chart displays the proportion of the amount for each category.',
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

  Widget _buildPage(int index, IconData iconData, String informationText, String hintText, VoidCallback onPressed, String buttonText) {
    double iconSize = min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) / 2.5;
    double textOffset = (MediaQuery.of(context).size.width / 2  * index) - (_currentPage * MediaQuery.of(context).size.width / 2);
    double buttonOffset = (MediaQuery.of(context).size.width * index) - (_currentPage * MediaQuery.of(context).size.width);                                          
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
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    informationText,
                    style: const TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    hintText,
                    style: const TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ),
          const SizedBox(height: 10.0),
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
