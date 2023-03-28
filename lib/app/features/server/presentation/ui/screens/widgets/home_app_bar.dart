part of '../home_screen.dart';

class HomeAppBar extends StatefulWidget {
  final double expandedHeight;
  final Widget flexibleSpace;
  final Color? flexibleSpaceColor;
  const HomeAppBar({
    super.key,
    required this.expandedHeight,
    required this.flexibleSpace,
    this.flexibleSpaceColor,
  });
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final AnimationController _animationRotateController;
  late final Animation<double> _animationHeight;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1050),
      reverseDuration: const Duration(milliseconds: 1300),
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
    );
    _animationRotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animationHeight = Tween<double>(
      begin: 0,
      end: widget.expandedHeight + WidgetsBinding.instance.window.padding.top,
    )
        .chain(CurveTween(curve: Curves.elasticInOut)) //
        .animate(_animationController);
    _animationController.addListener(_onAnimation);
    super.initState();
  }

  void _onAnimation() {
    if (_animationController.value > 0.5) {
      _animationRotateController.forward();
    } else {
      _animationRotateController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationRotateController.dispose();
    super.dispose();
  }

  void hideFlexibleSpace() {
    if (!_animationController.isAnimating && _animationController.isCompleted) {
      _animationController.reverse();
    }
  }

  void _showFlexibleSpace() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  void _showAboutDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => const AppAboutDialog(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SliverAppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          pinned: true,
          floating: true,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 10),
              Text(
                "MPC Remote Control",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
              ),
              AnimatedBuilder(
                animation: _animationRotateController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animationRotateController.value * pi,
                    child: IconButton(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: _showFlexibleSpace,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 30,
                      ),
                    ),
                  );
                },
              ),
              const Spacer(),
            ],
          ),
          expandedHeight: _animationHeight.value,
          flexibleSpace: Visibility(
            visible: _animationController.isAnimating || _animationController.isCompleted,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                color: widget.flexibleSpaceColor ?? Colors.transparent,
                height: widget.expandedHeight,
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                margin: EdgeInsets.only(top: ScreenUtils().appBarAndStatusBarHeight(context)),
                child: widget.flexibleSpace,
              ),
            ),
          ),
          actions: [
            PopupMenuButton(
              offset: const Offset(0, 5),
              icon: const Icon(Icons.more_vert_rounded),
              position: PopupMenuPosition.under,
              onSelected: (value) {
                context.pushNamed(value);
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: AppRoute.fileBrowserScreen,
                  child: Text("File Browser"),
                ),
                const PopupMenuItem(
                  value: AppRoute.manageServersScreen,
                  child: Text("Manage Servers"),
                ),
                const PopupMenuItem(
                  value: AppRoute.settingsScreen,
                  child: Text("Settings"),
                ),
                PopupMenuItem(
                  onTap: _showAboutDialog,
                  child: const Text("About"),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
