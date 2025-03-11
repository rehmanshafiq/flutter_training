import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state_management/api_call_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<ApiCallProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Get API Call with Provider"),
      ),
      body: userProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: userProvider.responseInMapModel.data?.length ?? 0,
        itemBuilder: (context, index) {
          final user = userProvider.responseInMapModel.data?[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user?.avatar ?? ""),
            ),
            title: Text(user?.firstName ?? ""),
            subtitle: Text(user?.email ?? ""),
          );
        },
      ),
    );
  }
}
