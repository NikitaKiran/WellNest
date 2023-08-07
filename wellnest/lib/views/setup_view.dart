import 'package:flutter/material.dart';

class SetupView extends StatelessWidget {
  const SetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Up Quiz'),
        backgroundColor: const Color(0xFFFFCACC),
      ),
      body: const SetupForm(),
    );
  }
}

class SetupForm extends StatefulWidget {
  const SetupForm({super.key});

  @override
  SetupFormState createState() {
    return SetupFormState();
  }
}

class SetupFormState extends State<SetupForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _age = TextEditingController();
  final _country = TextEditingController();
  final _avgsleep = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _age.dispose();
    _country.dispose();
    _avgsleep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              controller: _name,
              decoration: const InputDecoration(hintText: 'Enter your name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: _age,
              decoration: const InputDecoration(hintText: 'Enter your age'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: _country,
              decoration: const InputDecoration(
                  hintText: 'Enter the country you are living in'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid country';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: _avgsleep,
              decoration: const InputDecoration(
                  hintText: 'Enter your average sleep time (in hours)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid value';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () async {
                
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/verify/',
                    (_) => false,
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
