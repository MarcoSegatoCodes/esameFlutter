import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class GreeterWidget extends StatefulWidget {
  const GreeterWidget({super.key});

  @override
  State<GreeterWidget> createState() => _GreeterWidgetState();
}

class _GreeterWidgetState extends State<GreeterWidget> {
  late final FormGroup _form;
  String _message = "";
  String _name = "";
  String _greet = "";

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      "name": FormControl<String>(
        value: "",
        validators: [RequiredValidator(), MinLengthValidator(3)],
      ),
      "greet": FormControl<String>(
        value: "",
        validators: [RequiredValidator(), MinLengthValidator(2)],
      ),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _updateGreeting() {
    final name = _form.control('name').value as String?;
    final greet = _form.control('greet').value as String?;
    setState(() {
      _name = name ?? '';
      _greet = greet ?? '';
      _message = _name.isEmpty ? '' : '$greet $_name';
    });
  }

  void _reset() {
    _form.reset(value: {'name': ''});
    _form.reset(value: {'greet': ''});

    setState(() {
      _name = "";
      _greet = "";
      _message = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ReactiveForm(
        formGroup: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ReactiveTextField(
              formControlName: "greet",
              decoration: InputDecoration(hintText: "Enter Your Greeting"),
            ),
            ReactiveTextField(
              formControlName: "name",
              decoration: InputDecoration(hintText: "Enter Your Name"),
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _updateGreeting,
                  child: const Text('Greet this guy'),
                ),
                const SizedBox(width: 10),

                ElevatedButton(onPressed: _reset, child: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 30),
            Text(_message),
          ],
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[GreeterWidget()],
        ),
      ),
    );
  }
}
