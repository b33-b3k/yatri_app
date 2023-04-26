import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      body: const AllRoutes(),
    );
  }
}

class AllRoutes extends StatefulWidget {
  const AllRoutes({super.key});

  //variables
  static const double rSize = 1.5;
  static const String r1 = 'Dhulikhel'; //might be we can access from database
  static const int routeNo = 1;
  static String comp1 = 'Mayur Yatayat';
  static String s1 = 'Kalanki';
  static String e1 = 'Airport';

  @override
  State<AllRoutes> createState() => _AllRoutesState();
}

class _AllRoutesState extends State<AllRoutes> {
  final items = [
    'Product 1',
    'Product 2',
    'Product 3',
    'Product 4',
    'Product 5'
  ];
  @override
  Widget build(BuildContext context) {
    // var rSize = MediaQuery.of(context).size.width / 333;
    // var rSize = 1.5;
    return Container(
      padding: EdgeInsets.fromLTRB(19 * AllRoutes.rSize, 29 * AllRoutes.rSize,
          21.5 * AllRoutes.rSize, 13 * AllRoutes.rSize),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            // ignore: avoid_unnecessary_containers
            return Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 15 * AllRoutes.rSize),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => print('Route 1 tapped'),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * AllRoutes.rSize,
                          0 * AllRoutes.rSize,
                          1 * AllRoutes.rSize,
                          0 * AllRoutes.rSize),
                      padding: EdgeInsets.fromLTRB(
                          9 * AllRoutes.rSize,
                          10 * AllRoutes.rSize,
                          28 * AllRoutes.rSize,
                          10 * AllRoutes.rSize),
                      width: double.infinity,
                      height: 130 * AllRoutes.rSize,
                      decoration: BoxDecoration(
                        color: const Color(0xffd9d9d9),
                        borderRadius:
                            BorderRadius.circular(10 * AllRoutes.rSize),
                      ),
                      // alignment: Alignment.topCenter,
                      child: Row(
                        //for route 1
                        children: [
                          Column(
                            //C1
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                'Route ${index + 1}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '${AllRoutes.r1}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                          Column(
                            //C2
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '${AllRoutes.comp1}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'From: ${AllRoutes.s1}',
                                ),
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'To: ${AllRoutes.e1}',
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                          Column(
                            //C3
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Spacer(),
                              Icon(Icons.bus_alert_outlined),
                              // Image.asset('bus.png'),
                              Text('12'),
                              Spacer(),
                              Icon(Icons.social_distance_outlined),
                              // Image.asset('distance.png'),
                              Text('21.5'),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                          Column(
                            //C4
                            children: const [
                              Spacer(),
                              // Image.asset('bus-stop.png'),
                              Icon(Icons.stop_circle),
                              Text('12'),
                              Spacer(),
                              // Image.asset('clock.png'),
                              Icon(Icons.access_time),
                              Text('21.5'),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
