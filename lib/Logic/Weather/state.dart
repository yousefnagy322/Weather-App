import 'package:weatherapp/Data/model/weather_model.dart';

class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherSuccessState extends WeatherState {
  final weatherModel;

  WeatherSuccessState({required this.weatherModel});
}

class WeatherErrorState extends WeatherState {
  final String error;

  WeatherErrorState(this.error);
}
