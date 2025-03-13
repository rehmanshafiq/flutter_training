import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/utils/app_strings.dart';

import '../block_cubit/post_job_api_cubit.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Post API Call with Cubit"),
      ),
      body: BlocProvider(
        create: (context) => PostJobApiCubit(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),


              TextField(
                controller: jobController,
                decoration: const InputDecoration(
                  hintText: 'Enter Job',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Submit Button
              BlocBuilder<PostJobApiCubit, JobApiState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state is JobApiLoading
                          ? null
                          : () {
                        context.read<PostJobApiCubit>().postJob(
                          nameController.text,
                          jobController.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: state is JobApiLoading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : const Text(AppStrings.submit),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Display API Response or Error
              BlocBuilder<PostJobApiCubit, JobApiState>(
                builder: (context, state) {
                  if (state is JobApiSuccess) {
                    return Column(
                      children: [
                        Text(
                          'Job Created Successfully!',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text('ID: ${state.createdJob.id}'),
                        Text('Name: ${state.createdJob.name}'),
                        Text('Job: ${state.createdJob.job}'),
                      ],
                    );
                  } else if (state is JobApiError) {
                    return Text(
                      'Error: ${state.error}',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink(); // Hide when no state
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}