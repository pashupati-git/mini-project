import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zotoapp/repositories/weather_repository.dart';

import '../models/weather_model.dart';

//Weather State-Represents the current state of weather data

class WeatherState {
  final bool isLoading;
  final WeatherModel? currentWeather;
  final ForecastModel? forecast;
  final String? errorMessage;

  WeatherState(
      {this.isLoading = false,
      this.currentWeather,
      this.forecast,
      this.errorMessage});

  WeatherState copyWith({
    bool? isLoading,
    WeatherModel? currentWeather,
    ForecastModel? forecast,
    String? errorMessage,
  }) {
    return WeatherState(
        isLoading: isLoading ?? this.isLoading,
        currentWeather: currentWeather ?? this.currentWeather,
        forecast: forecast ?? this.forecast,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  //Helper getters
  bool get hasError => errorMessage != null;
  bool get hasData => currentWeather != null;
  bool get isInitial => !isLoading && !hasData && !hasError;
}

//Weather Repository Provider-singleton instance
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepository();
});

//Weather Notifier -Manages weather state and business logic
class WeatherNotifier extends Notifier<WeatherState> {
  @override
  WeatherState build() {
    return WeatherState();
  }

  //fetch weather by city name
  Future<void> fetchWeatherByCity(String city) async {
    state = state.copyWith(isLoading: true, errorMessage: null); //loading state
    try {
      final repository = ref.read(weatherRepositoryProvider);
      final currentWeather = await repository.getWeatherByCity(city);
      final forecast = await repository.getForecast(city);
      state = WeatherState(
        isLoading: false,
        currentWeather: currentWeather,
        forecast: forecast,
        errorMessage: null,
      );
    } catch (e) {
      state = WeatherState(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  //fetch weather by location
  Future<void> fetchWeatherByLocation() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final repository = ref.read(weatherRepositoryProvider);
      final currentWeather = await repository.getWeatherByLocation();
      final forecast = await repository.getForecast(currentWeather.cityName);
      state = WeatherState(
        isLoading: false,
        currentWeather: currentWeather,
        forecast: forecast,
        errorMessage: null,
      );
    } catch (e) {
      state = WeatherState(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  //Reset state to initial state
  void reset(){
    state = WeatherState();
  }
}


//Weather Notifier Provider-main p=rovider for weather state

final weatherNotifierProvider=NotifierProvider<WeatherNotifier,WeatherState>(
    ()=>WeatherNotifier(),
);



//Aditional providers for specific use cases


//Provider to check if weather is loaded
final isWeatherLoadedProvider=Provider<bool>((ref){
  final weatherState=ref.watch(weatherNotifierProvider);
  return weatherState.hasData;
});

//Provider to get current temperature
final currentTemperatureProvider=Provider((ref){
  final weatherState=ref.watch(weatherNotifierProvider);
  return weatherState.currentWeather?.temperature;
});

//Provider to get forecast count
final forecastCountProvider=Provider((ref){
  final weatherState=ref.watch(weatherNotifierProvider);
  return weatherState.forecast?.forecasts.length??0;
});