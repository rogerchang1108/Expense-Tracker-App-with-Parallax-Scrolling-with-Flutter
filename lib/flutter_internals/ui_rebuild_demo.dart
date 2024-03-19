import 'package:flutter/material.dart';

class UIRebuildDemo1 extends StatefulWidget {
  const UIRebuildDemo1({Key? key}) : super(key: key);

  @override
  State<UIRebuildDemo1> createState() => _UIRebuildDemo1State();
}

class _UIRebuildDemo1State extends State<UIRebuildDemo1> {
  var _isUnderstood = false;

  @override
  Widget build(BuildContext context) {
    print('UIRebuildDemo1 BUILD called');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Every Flutter developer should have a basic understanding of Flutter\'s internals!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Do you understand how Flutter updates UIs?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => setState(() => _isUnderstood = false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => setState(() => _isUnderstood = true),
                  child: const Text('Yes'),
                ),
              ],
            ),
            if (_isUnderstood) const Text('Awesome!'),
          ],
        ),
      ),
    );
  }
}

class UIRebuildDemo2 extends StatelessWidget {
  const UIRebuildDemo2({super.key});

  @override
  Widget build(BuildContext context) {
    print('UIRebuildDemo2 BUILD called');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Every Flutter developer should have a basic understanding of Flutter\'s internals!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Do you understand how Flutter updates UIs?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            DemoButtons(),
          ],
        ),
      ),
    );
  }
}

class DemoButtons extends StatefulWidget {
  const DemoButtons({super.key});

  @override
  StatefulElement createElement() {
    print('DemoButtons CREATE_ELEMENT called');

    return super.createElement();
  }

  @override
  State<DemoButtons> createState() {
    return _DemoButtonsState();
  }
}

class _DemoButtonsState extends State<DemoButtons> {
  var _isUnderstood = false;

  @override
  Widget build(BuildContext context) {
    print('DemoButtons BUILD called');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isUnderstood = false;
                });
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isUnderstood = true;
                });
              },
              child: const Text('Yes'),
            ),
          ],
        ),
        if (_isUnderstood) const Text('Awesome!'),
      ],
    );
  }
}
