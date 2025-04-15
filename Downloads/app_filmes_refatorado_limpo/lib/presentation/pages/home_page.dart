import 'package:flutter/material.dart';

import 'tab_search.dart';
import 'recent_searches.dart';

class PageInitial extends StatelessWidget {
  const PageInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Catálogo de Filmes"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "search"),
              Tab(text: "Recent"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TabSearch(),
            TabRecent(),
          ],
        ),
      ),
    );
  }
}
