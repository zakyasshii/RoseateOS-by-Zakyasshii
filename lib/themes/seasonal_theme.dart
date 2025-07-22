import 'package:flutter/material.dart';

enum Season { spring, summer, fall, winter }

class SeasonalTheme extends InheritedWidget {
  final Season season;
  final Color primaryColor;
  final Color backgroundColor;
  final void Function(Season)? onOverride;

  SeasonalTheme({
    required this.season,
    required this.primaryColor,
    required this.backgroundColor,
    this.onOverride,
    required Widget child,
  }) : super(child: child);

  static SeasonalTheme of(BuildContext context) {
    final SeasonalTheme? result = context.dependOnInheritedWidgetOfExactType<SeasonalTheme>();
    assert(result != null, 'No SeasonalTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SeasonalTheme oldWidget) => season != oldWidget.season;

  static Season getCurrentSeason(DateTime now) {
    final month = now.month;
    if (month >= 3 && month <= 5) return Season.spring;
    if (month >= 6 && month <= 8) return Season.summer;
    if (month >= 9 && month <= 11) return Season.fall;
    return Season.winter;
  }

  static Map<Season, Map<String, Color>> seasonColors = {
    Season.spring: {
      'primary': Colors.green,
      'background': Colors.greenAccent,
    },
    Season.summer: {
      'primary': Colors.orange,
      'background': Colors.yellowAccent,
    },
    Season.fall: {
      'primary': Colors.brown,
      'background': Colors.orangeAccent,
    },
    Season.winter: {
      'primary': Colors.blue,
      'background': Colors.blueGrey,
    },
  };
} 