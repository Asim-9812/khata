import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_app/main.dart';
import 'package:khata_app/features/login/presentation/user_login.dart';
import 'package:khata_app/view/main_page.dart';



class StatusPage extends ConsumerWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return sessionBox.isEmpty ? const UserLoginView() : const MainView();
  }
}

