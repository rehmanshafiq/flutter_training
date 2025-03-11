import 'package:flutter/material.dart';
import 'package:flutter_training/models/response_in_map.dart';
import 'package:flutter_training/network_manager/repository.dart';

class SearchScreen extends StatefulWidget {

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  bool isLoading = true;
  ResponseInMapModel responseInMapModel = ResponseInMapModel();

  getData() {
    Repository().getUserList().then((value) {
      responseInMapModel = value;
      isLoading = false;
      setState(() {

      });
    }).onError((error, stackTrace) {
      print('Error => ${error.toString()}');
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Get Api Call"),
      ),
      body: isLoading? Center(child: CircularProgressIndicator(),) :
      ListView.builder(
        itemCount: responseInMapModel.data?.length??0,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(responseInMapModel.data?[index].avatar??""),
              ),
              title: Text(responseInMapModel.data?[index].firstName??""),
              subtitle: Text(responseInMapModel.data?[index].email??""),
            );
          }
      ),
    );
  }
}