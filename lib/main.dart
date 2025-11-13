import "package:esame_flutter/todo.dart";
import "package:flutter/material.dart";
import "package:reactive_forms/reactive_forms.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _list = <Todo>[];
  bool _showOnlyDone = false;
  List<Todo> get displayedList =>
      _showOnlyDone ? _list.where((t) => t.isDone).toList() : _list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Devo ricordarmi di comprare i BROCCOLI e..."),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _list.removeWhere((todo) => todo.isDone == true);
              });
            },
            label: const Text("Delete completed tasks"),
          ),
          const SizedBox(width: 30),
          ElevatedButton.icon(
            icon: const Icon(Icons.done_outline_rounded),
            onPressed: () {
              setState(() {
                _showOnlyDone = !_showOnlyDone;
              });
            },
            label: (_showOnlyDone
                ? const Text("show all tasks")
                : const Text("show completed tasks")),
          ),
          const SizedBox(width: 30),
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            if (_list.isEmpty) const Text("non c'è niente"),
            for (final (i, todo) in displayedList.indexed)
              CheckboxListTile(
                value: todo.isDone,
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                subtitle: Text(
                  todo.description,
                  style: TextStyle(
                    decoration: todo.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _list[i].isDone = value);
                },
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _displayForm(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute<Todo>(
        builder: (context) {
          return AddTodoForm();
        },
      ),
    );
    if (!context.mounted) return;

    if (result == null) return;
    setState(() {
      _list.add(result);
    });
  }
}

class AddTodoForm extends StatelessWidget {
  AddTodoForm({super.key});

  final _form = FormGroup({
    "title": FormControl<String>(
      value: "",
      validators: [const RequiredValidator(), const MinLengthValidator(3)],
    ),
    "description": FormControl<String>(
      value: "",
      validators: [const RequiredValidator(), const MinLengthValidator(20)],
    ),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Inserisci una task")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ReactiveForm(
          formGroup: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("nuovo todo!", style: theme.textTheme.headlineSmall),
              const SizedBox(height: 40),
              ReactiveTextField<String>(
                formControlName: "title",
                decoration: InputDecoration(
                  hintText: "titolo della task...",
                  filled: true,
                  fillColor: Color.fromARGB(255, 215, 215, 215),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ReactiveTextField<String>(
                formControlName: "description",
                decoration: InputDecoration(
                  hintText: "descrizione della task...",
                  filled: true,
                  fillColor: const Color.fromARGB(255, 215, 215, 215),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                validationMessages: {
                  ValidationMessage.required: (error) =>
                      'La descrizione è obbligatoria',
                  ValidationMessage.minLength: (error) =>
                      'La descrizione deve essere di almeno 20 caratteri',
                },
              ),
              const SizedBox(height: 80),
              ElevatedButton(
                onPressed: () => _submit(context),
                child: const Text("salva!"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    if (!_form.valid) return;

    final todo = Todo(
      createdAt: DateTime.now(),
      title: _form.control("title").value as String,
      description: _form.control("description").value as String,
    );
    Navigator.pop(context, todo);
  }
}
