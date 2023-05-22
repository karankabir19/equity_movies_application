// Package
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Common
import '../common/colors.dart';

// Pages
import '../pages/home_page.dart';
import '../pages/popular_page.dart';
import '../pages/top_rated_page.dart';
import '../pages/upcoming_page.dart';

// Screen
import './movie_search_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isListView = false;
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Home(
        isListView: isListView,
      ),
      PopularPageWidget(
        isListView: isListView,
      ),
      TopRated(
        isListView: isListView,
      ),
      UpcomingPage(
        isListView: isListView,
      ),
    ];
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Movie App',
          style: TextStyle(color: textColor),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  isListView = !isListView;
                },
              );
            },
            icon: AnimatedCrossFade(
              firstChild: const Icon(
                Icons.grid_view,
                color: iconColor,
              ),
              secondChild: const Icon(
                Icons.list,
                color: iconColor,
              ),
              crossFadeState: isListView
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 500),
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => const MovieSearchScreen());
            },
            icon: const Icon(
              Icons.search_rounded,
              color: iconColor,
            ),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 1000),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: _pages[currIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: navBgColor.withOpacity(0.3),
        elevation: 0,
        currentIndex: currIndex,
        selectedItemColor: iconColor,
        unselectedItemColor: Colors.white24,
        onTap: (value) {
          setState(() {
            currIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Popular',
            icon: Icon(
              Icons.favorite_border_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Top Rated',
            icon: Icon(
              Icons.arrow_outward_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Upcoming',
            icon: Icon(
              Icons.upcoming_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
