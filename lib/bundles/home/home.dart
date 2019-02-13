import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/inventory/inventory_page.dart';
import 'package:inventory_management/bundles/material/material_info_page.dart';
import 'package:inventory_management/bundles/memo/memo_page.dart';
import 'package:inventory_management/bundles/printing/printing_page.dart';
import 'package:inventory_management/bundles/setting/setting_page.dart';

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Color color,
    TickerProvider vsync,
  })  : _icon = icon,
        _color = color,
        _title = title,
        item = BottomNavigationBarItem(
          icon: icon,
          activeIcon: activeIcon,
          title: Text(title),
          backgroundColor: color,
        ),
        controller = AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = controller.drive(CurveTween(
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));
  }

  final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  Animation<double> _animation;

  FadeTransition transition(
      BottomNavigationBarType type, BuildContext context) {
    Color iconColor;
    if (type == BottomNavigationBarType.shifting) {
      iconColor = _color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }

    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: _animation.drive(
          Tween<Offset>(
            begin: const Offset(0.0, 0.02), // Slightly down.
            end: Offset.zero,
          ),
        ),
        child: IconTheme(
          data: IconThemeData(
            color: iconColor,
            size: 120.0,
          ),
          child: Semantics(
            label: 'Placeholder for $_title tab',
            child: _icon,
          ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<Home> with TickerProviderStateMixin {
  TabController controller;
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.fixed;
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 5, vsync: this);
    _navigationViews = <NavigationIconView>[
      NavigationIconView(
        icon: const Icon(Icons.gradient),
        title: 'stock',
        color: Colors.teal,
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.print),
        title: 'print',
        color: Colors.indigo,
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.note),
        title: 'meno',
        color: Colors.pink,
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.adjust),
        title: 'inventory',
        color: Colors.pink,
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.settings),
        title: 'setting',
        color: Colors.pink,
        vsync: this,
      )
    ];

    for (NavigationIconView view in _navigationViews)
      view.controller.addListener(_rebuild);

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews) view.controller.dispose();
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        controller.index = index;
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );
    return Scaffold(
      body: new TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          MaterialInfoPage(),
          PrintingPage(),
          MemoPage(),
          InventoryPage(),
          Setting(),
        ],
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}
