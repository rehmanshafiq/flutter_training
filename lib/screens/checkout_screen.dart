import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state_management/api_call_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<ApiCallProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Post API Call with Provider"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Enter Name'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: jobController,
              decoration: const InputDecoration(hintText: 'Enter Job'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: jobProvider.isLoading
                    ? null
                    : () {
                  jobProvider.postJob(
                    nameController.text,
                    jobController.text,
                  );
                },
                child: jobProvider.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
