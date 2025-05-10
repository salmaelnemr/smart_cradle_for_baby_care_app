import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smart_cradle_for_baby_care_app/Core/models/baby_temp_model.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_loading_indicator.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/main_app_bar.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Core/dio/api_provider.dart';
import '../../Widgets/app/vital_signs.dart';
import '../../Widgets/app_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  static const _fetchInterval = Duration(seconds: 300);
  static const _firebasePath = "sensor_data";

  final _apiProvider = ApiProvider();
  final _databaseRef = FirebaseDatabase.instance.ref(_firebasePath);
  StreamSubscription<DatabaseEvent>? _vitalSignsSubscription;
  late Timer _timer;

  String _babyTemperature = "0 °C";
  String _homeTemperature = "0 °C";
  String _heartRate = "0 BPM";
  String _breathing = "0%";
  String _weight = "0 kg";

  double _babyTemperatureRatio = 0.0;
  double _homeTemperatureRatio = 0.0;
  double _breathingRatio = 0.0;
  double _weightRatio = 0.0;

  bool _isLoading = true;
  String? _errorMessage;
  BabyTempModel? babyTempModel;

  final List<FlSpot> _heartRateSpots = List.generate(31, (index) {
    final List<double> values = [
      20,
      25,
      40,
      50,
      35,
      40,
      30,
      20,
      25,
      40,
      50,
      35,
      50,
      60,
      40,
      50,
      20,
      25,
      40,
      50,
      35,
      80,
      30,
      20,
      25,
      40,
      50,
      35,
      50,
      60,
      40
    ];
    return FlSpot(index.toDouble(), values[index]);
  });

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startFetchingData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _startFetchingData();
    } else if (state == AppLifecycleState.paused) {
      _stopFetchingData();
    }
  }

  @override
  void dispose() {
    _stopFetchingData();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _startFetchingData() {
    _listenToVitalSigns();
    _timer = Timer.periodic(_fetchInterval, (_) => _fetchBabyTemperature());
    _fetchBabyTemperature();
  }

  void _stopFetchingData() {
    _timer.cancel();
    _vitalSignsSubscription?.cancel();
    _vitalSignsSubscription = null;
  }

  Future<void> _fetchBabyTemperature() async {
    try {
      setState(() => _isLoading = true);
      final babyTemp = await _apiProvider.getBabyTemp();
      setState(() {
        babyTempModel = babyTemp;
        if (babyTemp != null && babyTemp.temp != null) {
          final temp = babyTemp.temp!.toDouble();
          _babyTemperature = "${temp.toStringAsFixed(1)} °C";
          _babyTemperatureRatio = _calculateRatio(temp, min: 35.0, max: 40.0);
          _errorMessage = null;
        } else {
          _errorMessage = "No temperature data available from API";
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Error fetching temperature: $e";
        _isLoading = false;
      });
    }
  }

  void _listenToVitalSigns() {
    _vitalSignsSubscription = _databaseRef.onValue.listen(
      (DatabaseEvent event) {
        final data = event.snapshot.value as Map<dynamic, dynamic>?;
        setState(() {
          if (data != null) {
            final homeTemp = (data['temperature'] ?? 42).toDouble();
            final hr = (data['heartRate'] ?? 78).toDouble();
            final spO2 = (data['spo2'] ?? 95).toDouble();
            final w = (data['weight'] ?? 5).toDouble();

            _homeTemperature = "${homeTemp.toStringAsFixed(1)} °C";
            _heartRate = "${hr.toStringAsFixed(0)} BPM";
            _breathing = "${spO2.toStringAsFixed(0)}%";
            _weight = "${w.toStringAsFixed(1)} kg";

            _homeTemperatureRatio = _calculateRatio(homeTemp, min: -10.0, max: 60.0);
            _breathingRatio = _calculateRatio(spO2, min: 0.0, max: 100.0);
            _weightRatio = _calculateRatio(w, min: 0.0, max: 15.0);

            _isLoading = false;
            _errorMessage = null;
          } else {
            _errorMessage = "No data available from Firebase";
            _isLoading = false;
          }
        });
      },
      onError: (error) {
        setState(() {
          _errorMessage = "Error fetching Firebase data: $error";
          _isLoading = false;
        });
      },
    );
  }

  double _calculateRatio(double value,
      {required double min, required double max}) {
    if (value < min) return 0.0;
    if (value > max) return 1.0;
    return (value - min) / (max - min);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const MainAppBar(
        appName: 'IntelliNest',
        profileIcon: 'Assets/Images/profileIcon.png',
        notificationIcon: 'Assets/Images/notificationIcon.png',
      ),
      body: _isLoading
          ? const Center(
              child: AppLoadingIndicator(),
            )
          : _errorMessage != null
              ? Center(
                  child: AppText(
                  title: _errorMessage!,
                  color: AppColors.black,
                ))
              : VitalSignsView(
                  babyTemperature: _babyTemperature,
                  homeTemperature: _homeTemperature,
                  heartRate: _heartRate,
                  breathing: _breathing,
                  weight: _weight,
                  babyTemperatureRatio: _babyTemperatureRatio,
                  homeTemperatureRatio: _homeTemperatureRatio,
                  breathingRatio: _breathingRatio,
                  weightRatio: _weightRatio,
                  heartRateSpots: _heartRateSpots,
                ),
    );
  }
}
