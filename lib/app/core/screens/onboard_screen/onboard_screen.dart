import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../features/settings/presentation/controller/settings_controller.dart';
import '../../routes/app_route.dart';
import 'pages/connection_page.dart';
import 'pages/controls_page.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int _currentIndex = 0;
  late final PageController _pageController = PageController(initialPage: _currentIndex);

  final List<Widget> pages = [
    const ConnectionPage(),
    const ControlsPage(),
  ];
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _changePage(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  itemCount: pages.length,
                  itemBuilder: (context, index) => pages[index],
                  controller: _pageController,
                  onPageChanged: _changePage,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (index) => InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () => _pageController.animateToPage(index, duration: const Duration(milliseconds: 150), curve: Curves.easeIn),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: index == _currentIndex
                            ? Theme.of(context).textTheme.bodyMedium?.color
                            : Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 25),
                child: TextButton(
                  onPressed: () {
                    GetIt.I.call<SettingsController>().isFirstOpening.value = false;
                    context.pushReplacementNamed(AppRoute.homeScreen);
                  },
                  child: Text(
                    "GOT IT!",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
