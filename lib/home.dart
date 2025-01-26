import 'package:flutter/material.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:meri_ride/custom_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool switchVal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // background color is a placeholder for the map
      backgroundColor: Colors.blueGrey,

      key: _scaffoldKey,
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _topBar(),
            const RideRequestCard(),
          ],
        ),
      ),
    );
  }

  SizedBox _topBar() {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                icon: const Icon(Icons.menu_rounded, size: 27),
              ),
              Text(
                switchVal ? 'Online' : 'Offline',
                style: const TextStyle(fontSize: 18),
              ),
              Transform.scale(
                scale: 0.85,
                child: Switch(
                    value: switchVal,
                    onChanged: (newVal) {
                      setState(() {
                        switchVal = newVal;
                      });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RideRequestCard extends StatelessWidget {
  const RideRequestCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const PassengerInfo(),
                  Column(
                    spacing: 3,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'ETB 365',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '12 Km',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const RideDetails(),
              const ActionButtons()
            ],
          ),
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 15,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 2, color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Decline',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              child: const Text(
                'Accept',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RideDetails extends StatelessWidget {
  const RideDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      children: [
        Column(
          spacing: 2,
          children: [
            Icon(
              Icons.trip_origin_rounded,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
            DottedDashedLine(
              height: 54,
              width: 0,
              axis: Axis.vertical,
              strokeWidth: 2,
              dashColor: Colors.grey.shade500,
            ),
            Icon(
              Icons.location_on_rounded,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            )
          ],
        ),
        Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pick-up Point',
              style: TextStyle(color: Colors.grey.shade500),
            ),
            const Text(
              'Summit, CMC',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Text(
              'Drop-off Point',
              style: TextStyle(color: Colors.grey.shade500),
            ),
            const Text(
              'HiLCoE, 4 Kilo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

class PassengerInfo extends StatelessWidget {
  const PassengerInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/old_cars_2.png',
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
        ),
        Column(
          spacing: 3,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Abebe Kebede',
              style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold),
            ),
            Text(
              '+251 91 234 5678',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            )
          ],
        )
      ],
    );
  }
}
