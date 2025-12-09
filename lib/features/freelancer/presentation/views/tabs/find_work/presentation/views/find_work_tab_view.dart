import 'package:flutter/material.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/views/widgets/freelancer_find_work_tab_view_body.dart';

class FreelancerHomeTabView extends StatelessWidget {
  const FreelancerHomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return   const Scaffold(
      body: FreelancerHomeTabViewBody(),
    );
  }
}