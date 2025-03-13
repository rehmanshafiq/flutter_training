import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/utils/app_strings.dart';
import '../block_cubit/get_user_api_call_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(AppStrings.getApiHeading),
      ),
      body: BlocProvider(
        create: (context) => GetUserApiCubit()..getUserListApi(),
        child: BlocBuilder<GetUserApiCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserSuccess) {
              return ListView.builder(
                itemCount: state.responseInMapModel.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final user = state.responseInMapModel.data?[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user?.avatar ?? ""),
                    ),
                    title: Text(user?.firstName ?? ""),
                    subtitle: Text(user?.email ?? ""),
                  );
                },
              );
            } else if (state is UserFailure) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text(AppStrings.noDataAvailable));
            }
          },
        ),
      ),
    );
  }
}