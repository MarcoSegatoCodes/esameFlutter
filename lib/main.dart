import 'package:esame_flutter/contactdetail.dart';
import 'package:esame_flutter/people.dart';
import 'package:flutter/material.dart';
import 'package:esame_flutter/contactform.dart';
import 'package:share_plus/share_plus.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: [
            if (people.isEmpty) const Text("non c'è niente"),
            for (var i = 0; i < people.length; i++)
              ListTile(
                leading: const Icon(Icons.person),
                title: Text("${people[i].firstName} ${people[i].lastName}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        final phones = people[i].phoneNumbers.join(", ");
                        final contactText =
                            "${people[i].firstName} ${people[i].lastName}\nPhone: $phones";
                        SharePlus.instance.share(
                          ShareParams(text: contactText),
                        );
                      },
                    ),
                  ],
                ),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Contactdetail(icontact: people[i]),
                    ),
                  );

                  if (result != null) {
                    setState(() {
                      people[i] = result;
                    });
                  }
                },
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createContact,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _createContact() async {
    final result = await showDialog<Person>(
      context: context,
      builder: (context) {
        return ContactFormDialog();
      },
    );

    if (result == null) return;

    setState(() {
      people.add(result);
    });
  }
}
