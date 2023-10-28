import 'package:farm_swap_mobile_final/provider/user_type_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<UserTypeProvider>(
          builder: (context, value, child) {
            return Text(value.getUserType);
          },
        ),
      ),
    );
  }
}
