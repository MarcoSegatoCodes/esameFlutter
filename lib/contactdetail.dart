import 'package:esame_flutter/contactform.dart';
import 'package:esame_flutter/people.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contactdetail extends StatefulWidget {
  final Person icontact;

  const Contactdetail({super.key, required this.icontact});

  @override
  State<Contactdetail> createState() => _ContactdetailState();
}

class _ContactdetailState extends State<Contactdetail> {
  late Person _currentContact;

  @override
  void initState() {
    super.initState();
    _currentContact = widget.icontact;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, _currentContact);
          },
        ),
        title: const Text("Dettaglio"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            _currentContact.firstName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            _currentContact.lastName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            _currentContact.email,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            _currentContact.phoneNumbers.join(", "),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 30),
          Row(
            children: [
              ElevatedButton(
                onPressed: _currentContact.phoneNumbers.isNotEmpty
                    ? () async {
                        final uri = Uri.parse(
                          "tel:${_currentContact.phoneNumbers.first}",
                        );
                        await launchUrl(uri);
                      }
                    : null,
                child: const Text('Chiama'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _currentContact.email.isNotEmpty
                    ? () async {
                        final uri = Uri.parse(
                          "mailto:${_currentContact.email}",
                        );
                        await launchUrl(uri);
                      }
                    : null,
                child: const Text('Email'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _modifyContact,
                child: const Icon(Icons.mode_edit),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _modifyContact() async {
    final result = await showDialog<Person>(
      context: context,
      builder: (context) {
        return ContactFormDialog(icontact: _currentContact);
      },
    );

    if (result == null) return;

    setState(() {
      _currentContact = result;
    });
  }
}
