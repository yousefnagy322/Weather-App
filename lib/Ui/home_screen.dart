import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/Data/model/weather_model.dart';
import 'package:weatherapp/Logic/Weather/cubit.dart';
import 'package:weatherapp/Logic/Weather/state.dart';
import 'package:weatherapp/Ui/location_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()..getweather(),
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoadingState) {
            return Scaffold(
              backgroundColor: Colors.blue[300],
              body: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          }
          if (state is WeatherSuccessState) {
            WeatherModel model = state.weatherModel;

            return Scaffold(
              backgroundColor: Colors.blue[300],
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('lib/assets/City View.png'),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 45),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/assets/Location Icon.png',
                            alignment: Alignment.bottomCenter,
                          ),
                          Text(
                            model.location.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              shadows: [
                                Shadow(
                                  color: Color(0x25000000),
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LocationScreen(),
                                ),
                              );
                            },
                            child: Image.asset('lib/assets/Menu Icon.png'),
                          ),
                          // Icon(Icons.menu, color: Colors.white, size: 31),
                        ],
                      ),
                      SizedBox(height: 65),
                      //date
                      Text(
                        DateFormat(
                          'MMMM d',
                        ).format(DateTime.parse(model.location.localtime)),

                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      //updated date
                      Text(
                        'Updated ${DateFormat("d/M/yyyy h:mm a").format(DateTime.parse(model.location.localtime))}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Color(0x25000000),
                              offset: Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Image.network(
                        height: 95,
                        width: 95,
                        'http:${model.current.condition.icon}',
                        fit: BoxFit.fitHeight,
                      ),
                      Text(
                        '${model.current.condition.text}',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Color(0x25000000),
                              offset: Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 27.8),
                            child: Text(
                              '${model.current.tempC.toInt()}',
                              style: TextStyle(
                                height: 1,
                                fontSize: 86,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Color(0x25000000),
                                    offset: Offset(0, 4),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              '°c',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Color(0x25000000),
                                    offset: Offset(0, 4),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Image.asset('lib/assets/Icon Humidity.png'),

                              Text(
                                'HUMIDITY',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  shadows: [
                                    Shadow(
                                      color: Color(0x25000000),
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${model.current.humidity}%',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  shadows: [
                                    Shadow(
                                      color: Color(0x25000000),
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset('lib/assets/Icon Wind.png'),
                              SizedBox(height: 4),
                              Text(
                                'WIND',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  shadows: [
                                    Shadow(
                                      color: Color(0x25000000),
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),

                              Text(
                                '${model.current.windKph}km/h',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  shadows: [
                                    Shadow(
                                      color: Color(0x25000000),
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset('lib/assets/Icon Feels Like.png'),
                              Text(
                                'FEELS LIKE',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  shadows: [
                                    Shadow(
                                      color: Color(0x25000000),
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '  ${model.current.feelslike_c.toInt()}°',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  shadows: [
                                    Shadow(
                                      color: Color(0x25000000),
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 16,
                          left: 20,
                          right: 20,
                        ),
                        height: 153,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Color(0xff535353).withOpacity(0.6),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: model.forecast.forecastday.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: 25,
                                left: 25,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormat('E d').format(
                                      DateTime.parse(
                                        model.forecast.forecastday[index].date,
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffECECEC),
                                      fontWeight: FontWeight.w400,
                                      shadows: [
                                        Shadow(
                                          color: Color(0x25000000),
                                          offset: Offset(0, 4),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Image.network(
                                    width: 42,
                                    height: 42,
                                    fit: BoxFit.fitHeight,
                                    'https:${model.forecast.forecastday[index].day.condition.icon}',
                                  ),
                                  Text(
                                    ' ${model.forecast.forecastday[index].day.maxtempC.toInt()}°',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xffECECEC),
                                      fontWeight: FontWeight.w400,
                                      shadows: [
                                        Shadow(
                                          color: Color(0x25000000),
                                          offset: Offset(0, 4),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${model.forecast.forecastday[index].day.maxwind_kph.toInt()}\nkm/h',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffECECEC),
                                      fontWeight: FontWeight.w400,
                                      shadows: [
                                        Shadow(
                                          color: Color(0x25000000),
                                          offset: Offset(0, 4),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is WeatherErrorState) {
            return SizedBox(child: Text(state.error));
          }
          return SizedBox(child: Text('error state'));
        },
      ),
    );
  }
}
