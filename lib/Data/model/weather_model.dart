class WeatherModel {
  final Location location;
  final Current current;
  final Forecast forecast;

  WeatherModel({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }
}

class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;
  final int localtimeEpoch;
  final String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      tzId: json['tz_id'],
      localtimeEpoch: json['localtime_epoch'],
      localtime: json['localtime'],
    );
  }
}

class Current {
  final String lastUpdated;
  final double tempC;
  final int isDay;
  final Condition condition;
  final double windKph;
  final int humidity;
  final double feelslike_c;

  Current({
    required this.lastUpdated,
    required this.tempC,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.humidity,
    required this.feelslike_c,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      lastUpdated: json['last_updated'],
      tempC: (json['temp_c'] as num).toDouble(),
      isDay: json['is_day'],
      condition: Condition.fromJson(json['condition']),
      windKph: (json['wind_kph'] as num).toDouble(),
      humidity: json['humidity'],
      feelslike_c: (json['feelslike_c'] as num).toDouble(),
    );
  }
}

class Condition {
  final String text;
  final String icon;
  final int code;

  Condition({required this.text, required this.icon, required this.code});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: json['icon'],
      code: json['code'],
    );
  }
}

class Forecast {
  final List<ForecastDay> forecastday;

  Forecast({required this.forecastday});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      forecastday: (json['forecastday'] as List)
          .map((e) => ForecastDay.fromJson(e))
          .toList(),
    );
  }
}

class ForecastDay {
  final String date;
  final Day day;
  final Astro astro;
  final List<Hour> hour;

  ForecastDay({
    required this.date,
    required this.day,
    required this.astro,
    required this.hour,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      date: json['date'],
      day: Day.fromJson(json['day']),
      astro: Astro.fromJson(json['astro']),
      hour: (json['hour'] as List).map((e) => Hour.fromJson(e)).toList(),
    );
  }
}

class Day {
  final double maxtempC;
  final double mintempC;
  final double avgtempC;
  final Condition condition;
  final double maxwind_kph;

  Day({
    required this.maxtempC,
    required this.mintempC,
    required this.avgtempC,
    required this.condition,
    required this.maxwind_kph,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxtempC: (json['maxtemp_c'] as num).toDouble(),
      mintempC: (json['mintemp_c'] as num).toDouble(),
      avgtempC: (json['avgtemp_c'] as num).toDouble(),
      maxwind_kph: (json['maxwind_kph'] as num).toDouble(),
      condition: Condition.fromJson(json['condition']),
    );
  }
}

class Astro {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;

  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
  });

  factory Astro.fromJson(Map<String, dynamic> json) {
    return Astro(
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      moonrise: json['moonrise'],
      moonset: json['moonset'],
    );
  }
}

class Hour {
  final String time;
  final double tempC;
  final int isDay;
  final Condition condition;
  final double windKph;
  final int humidity;

  Hour({
    required this.time,
    required this.tempC,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.humidity,
  });

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      time: json['time'],
      tempC: (json['temp_c'] as num).toDouble(),
      isDay: json['is_day'],
      condition: Condition.fromJson(json['condition']),
      windKph: (json['wind_kph'] as num).toDouble(),
      humidity: json['humidity'],
    );
  }
}
