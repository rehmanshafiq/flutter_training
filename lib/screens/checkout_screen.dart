import 'package:flutter/material.dart';
import 'package:flutter_training/network_manager/repository.dart';

class CheckoutScreen extends StatefulWidget {

  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Post Api Call"),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Enter Name'),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: jobController,
              decoration: InputDecoration(hintText: 'Enter Job'),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() { isLoading = true; });
                    Map params = {
                      "name": nameController.text,
                      "job": jobController.text
                    };
                    Repository().postJobApi(params).then((value) {
                      print("Id: ${value.id}, Name: ${value.name}, Job: ${value.job}");
                      setState(() { isLoading = false; });
                    }).onError((error, stackTrace) {
                      print('Error: ${error.toString()}');
                    });
                  },
                  child: isLoading ? CircularProgressIndicator() : Text('Submit')
              ),
            )
          ],
        ),
      ),
    );
  }
}