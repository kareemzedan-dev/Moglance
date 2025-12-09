import 'package:flutter/material.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/views/widgets/client_home_tab_view_body.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return   const Scaffold(

      body: ClientHomeTabViewBody(),
    );
  }
}