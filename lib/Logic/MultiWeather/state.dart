import 'package:weatherapp/Data/model/weather_model.dart';

class MultiWeatherState {}

class MultiWeatherInitialState extends MultiWeatherState {}

class MultiWeatherLoadingState extends MultiWeatherState {}

class MultiWeatherEmptyState extends MultiWeatherState {}

class MultiWeatherSuccessState extends MultiWeatherState {
  final List<WeatherModel> weatherList;

  MultiWeatherSuccessState(this.weatherList);
}

class MultiWeatherErrorState extends MultiWeatherState {
  final String error;
  MultiWeatherErrorState(this.error);
}
