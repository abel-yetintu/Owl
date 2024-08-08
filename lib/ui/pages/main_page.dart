import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/providers/selected_tab_provider.dart';
import 'package:owl/ui/pages/messages_page.dart';
import 'package:owl/ui/pages/profile_page.dart';
import 'package:owl/ui/pages/search_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {

  final List<Widget> _pages = const [MessagesPage(), SearchPage(), ProfilePage()];
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedTab = context.watch<SelectedTabProvider>().selectedTab;
    return Scaffold(
      body: SafeArea(child: _pages[selectedTab]),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        height: 80.h,
        selectedIndex: selectedTab,
        onDestinationSelected: (value) {
          context.read<SelectedTabProvider>().selectTab(tab: value);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.message), label: 'Messages'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
