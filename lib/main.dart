import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;
  Color _backgroundColor = Color.fromARGB(255, 230, 230, 230);

  void onToggleTheme(bool value) {
    setState(() {
      isDark = !isDark;
    });
    isDark
        ? _changeColor(Color.fromARGB(255, 40, 40, 40))
        : _changeColor(Color.fromARGB(255, 230, 230, 230));
  }

  void _changeColor(Color c) => setState(() => _backgroundColor = c);

  void _randomColor() {
    final rnd = Random();
    _changeColor(Colors.primaries[rnd.nextInt(Colors.primaries.length)]);
  }

  void _reset() {
    _changeColor(Color.fromARGB(255, 230, 230, 230));
    setState(() {
      isDark = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = isDark ? ThemeData.dark() : ThemeData.light();
    final textColor = theme.colorScheme.onSurface;

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: theme.colorScheme.inversePrimary,
            appBar: AppBar(
              title: const Text('Background Color Changer'),
              backgroundColor: theme.colorScheme.inversePrimary,
            ),
            body: Container(
              color: _backgroundColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tap a button to change the color!',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () => _changeColor(Colors.red),
                          child: const Text('Red'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () => _changeColor(Colors.green),
                          child: const Text('Green'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () => _changeColor(Colors.blue),
                          child: const Text('Blue'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    SwitchListTile(
                      title: Text(
                        'Dark mode',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: textColor,
                        ),
                      ),
                      value: isDark,
                      // value: false,
                      onChanged: onToggleTheme,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _randomColor,
                      child: const Text('Random color'),
                    ),
                    ElevatedButton(
                      onPressed: _reset,
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
