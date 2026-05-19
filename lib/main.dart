import 'package:flutter/material.dart';
import 'views/first_launch/first_launch_screen.dart';
import 'views/dashboard/dashboard_screen.dart';
import 'views/settings/settings_screen.dart';
import 'themes/seasonal_theme.dart';
import 'services/storage_service.dart';
import 'services/pin_service.dart';
import 'views/auth/pin_lock_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  await NotificationService.init();
  await NotificationService.rescheduleAllRecurring();
  runApp(const RoseateOSApp());
}

class RoseateOSApp extends StatefulWidget {
  const RoseateOSApp({super.key});

  @override
  State<RoseateOSApp> createState() => _RoseateOSAppState();
}

class _RoseateOSAppState extends State<RoseateOSApp> {
  Season? _manualSeason;
  bool _bootstrapComplete = false;
  bool _hasProfile = false;
  bool _pinEnabled = false;
  bool _pinPassed = false;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final hasProfile = await StorageService.hasUserProfile();
    final pinEnabled = hasProfile && await PinService.isPinEnabled();
    setState(() {
      _hasProfile = hasProfile;
      _pinEnabled = pinEnabled;
      _pinPassed = !pinEnabled;
      _bootstrapComplete = true;
    });
  }

  void _setManualSeason(Season season) {
    setState(() {
      _manualSeason = season;
    });
  }

  void _onPinSuccess() {
    setState(() {
      _pinPassed = true;
    });
  }

  void _onProfileCreated() {
    setState(() {
      _hasProfile = true;
      _pinPassed = true;
      _pinEnabled = false;
    });
  }

  Widget _buildHome(Season season) {
    if (!_bootstrapComplete) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (!_hasProfile) {
      return FirstLaunchScreen(onProfileCreated: _onProfileCreated);
    }
    if (_pinEnabled && !_pinPassed) {
      return PinLockScreen(
        onValidate: PinService.checkPin,
        onSuccess: _onPinSuccess,
      );
    }
    return const DashboardScreen();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final season = _manualSeason ?? SeasonalTheme.getCurrentSeason(now);
    final colors = SeasonalTheme.seasonColors[season]!;

    return SeasonalTheme(
      season: season,
      primaryColor: colors['primary']!,
      backgroundColor: colors['background']!,
      onOverride: _setManualSeason,
      child: MaterialApp(
        title: 'RoseateOS',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: colors['primary']!),
          scaffoldBackgroundColor: colors['background'],
          useMaterial3: true,
        ),
        home: _buildHome(season),
        routes: {
          '/dashboard': (context) => const DashboardScreen(),
          '/settings': (context) => SettingsScreen(
                selectedSeason: season,
                onSeasonChanged: _setManualSeason,
              ),
        },
      ),
    );
  }
}
