import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_system/routes/routes.dart';

import '../Bloc/home_bloc.dart';

final homeBloc = HomeBloc();

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName ?? '';
    final email = user?.email ?? 'No Email';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FD),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listener: (context, state) {
          if (state is HomeError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is HomeEmailSent) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Email sent')));
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeInitial) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      "👋 Welcome Back!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      name.isNotEmpty ? name : email,
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is HomeEmailSent) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Transform.scale(
                  scale: 0.5,
                  child: Image.network(
                    "https://cdn.dribbble.com/userupload/23452400/file/original-894d9de0225a207d34a588bfb659f2bf.gif",
                  ),
                ),
              ),
            );
          } else if (state is HomeVerified) {
            return Center(child: Text("Email is already verified"));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          homeBloc.add(HomeVerifyEmailEvent(email));
        },
        child: Icon(Icons.verified_outlined, color: Colors.white),
      ),
    );
  }
}
