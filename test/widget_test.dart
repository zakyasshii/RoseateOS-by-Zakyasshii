import 'package:flutter_test/flutter_test.dart';
import 'package:roseateos/themes/seasonal_theme.dart';

void main() {
  test('SeasonalTheme maps April to spring', () {
    expect(
      SeasonalTheme.getCurrentSeason(DateTime(2025, 4, 15)),
      Season.spring,
    );
  });
}
