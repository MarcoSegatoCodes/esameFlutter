import 'package:flutter/material.dart';
import 'package:esame_flutter/people.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ContactFormDialog extends StatefulWidget {
  final Person? icontact;
  const ContactFormDialog({super.key, this.icontact});
  @override
  State<ContactFormDialog> createState() => _ContactFormDialogState();
}

class _ContactFormDialogState extends State<ContactFormDialog> {
  late final FormGroup _form;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      "firstName": FormControl<String>(
        value: widget.icontact?.firstName ?? "",
        validators: [RequiredValidator(), MinLengthValidator(3)],
      ),
      "lastName": FormControl<String>(
        value: widget.icontact?.lastName ?? "",
        validators: [RequiredValidator(), MinLengthValidator(3)],
      ),
      "email": FormControl<String>(
        value: widget.icontact?.email ?? "",
        validators: [
          Validators.required,
          Validators.pattern(
            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
          ),
        ],
      ),
      "phoneNumbers": FormControl<String>(
        value: widget.icontact?.phoneNumbers.join(", ") ?? "",
        validators: [Validators.required, Validators.pattern(r'^[0-9,\s]+$')],
      ),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ReactiveForm(
          formGroup: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("nuovo contatto!", style: theme.textTheme.headlineSmall),
              SizedBox(height: 40),
              ReactiveTextField(
                formControlName: "firstName",
                decoration: InputDecoration(
                  labelText: "Nome",
                  hintText: "Nome...",
                ),
              ),
              ReactiveTextField(
                formControlName: "lastName",
                decoration: InputDecoration(
                  labelText: "Cognome",
                  hintText: "Cognome...",
                ),
              ),
              SizedBox(height: 20),
              ReactiveTextField(
                formControlName: "email",
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Email...",
                ),
              ),
              SizedBox(height: 20),
              ReactiveTextField(
                formControlName: 'phoneNumbers',
                decoration: InputDecoration(
                  labelText: "Numeri",
                  hintText: "Numeri di Telefono...",
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 80),
              ElevatedButton(onPressed: _submit, child: Text("salva!")),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_form.valid) return;

    final phoneInput = _form.control("phoneNumbers").value as String;
    final phoneNumbers = phoneInput
        .split(",")
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList();

    final person = Person(
      firstName: _form.control("firstName").value,
      lastName: _form.control("lastName").value,
      email: _form.control("email").value,
      phoneNumbers: phoneNumbers,
    );

    Navigator.pop(context, person);
  }
}
