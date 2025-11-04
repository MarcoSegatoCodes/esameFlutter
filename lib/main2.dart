import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const ColorChangerApp());

class ColorChangerApp extends StatefulWidget {
  const ColorChangerApp({super.key});

  @override
  State<ColorChangerApp> createState() => _ColorChangerAppState();
}

class _ColorChangerAppState extends State<ColorChangerApp> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: Colors.green,
      brightness: _isDark ? Brightness.dark : Brightness.light,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: scheme, useMaterial3: true),
      home: ColorChangerPage(
        isDark: _isDark,
        onToggleTheme: (v) => setState(() => _isDark = v),
      ),
    );
  }
}

class ColorChangerPage extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onToggleTheme;

  const ColorChangerPage({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<ColorChangerPage> createState() => _ColorChangerPageState();
}

class _ColorChangerPageState extends State<ColorChangerPage> {
  Color _backgroundColor = Colors.white;

  void _changeColor(Color c) => setState(() => _backgroundColor = c);

  void _randomColor() {
    final rnd = Random();
    _changeColor(Colors.primaries[rnd.nextInt(Colors.primaries.length)]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

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
                style: theme.textTheme.titleMedium?.copyWith(color: textColor),
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
                  style: theme.textTheme.bodyLarge?.copyWith(color: textColor),
                ),
                value: widget.isDark,
                onChanged: widget.onToggleTheme,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _randomColor,
                child: const Text('Random color'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
