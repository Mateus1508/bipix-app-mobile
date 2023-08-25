import 'package:flutter/material.dart';

import '../services/utilities.dart';

class CustomTabs extends StatelessWidget {
  const CustomTabs({
    super.key,
    required this.tabs,
    this.tabController,
    this.selectedColor,
  });

  final List<Widget> tabs;
  final TabController? tabController;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49,
      width: 345,
      decoration: BoxDecoration(
        color: const Color(0XFF171A1D),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: selectedColor ?? getColors(context).primary,
        ),
        indicatorPadding: const EdgeInsets.all(5),
        labelColor: Colors.white,
        labelStyle: getStyles(context).labelLarge,
        unselectedLabelColor: Colors.white,
        tabs: tabs,
      ),
    );
  }
}
