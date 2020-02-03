import 'package:eventish/components/location_edit_component.dart';
import 'package:eventish/components/web_service.dart';
import 'package:eventish/models/Location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eventish/models/Event.dart';

import '../constants.dart';

class LocationPage extends StatefulWidget {
  final Event event;
  final Function onPush;
  LocationPage({this.event, this.onPush});
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Future<Location> location;
  Location myLocation;
  Function reqPost = (eventId, location) {
    return WebService.postLocation(eventId, location);
  };
  Function reqPut = (eventId, location) {
    return WebService.updateLocation(eventId, location);
  };

  @override
  void initState() {
    super.initState();
    if (widget.event.location != null) {
      location = WebService.getLocationOfEvent(widget.event.id);
    } else {
      myLocation = Location.createFromOwner(widget.event.organizer);
      myLocation.confirmed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackColor,
      drawerScrimColor: kCardColor,
      body: FutureBuilder<Location>(
        future: location,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LocationEdit(
              location: snapshot.data,
              event: widget.event,
              req: reqPut,
            );
          } else if (snapshot.connectionState == ConnectionState.waiting)
            return Text("loading ...");
          // By default, show a loading spinner.
          return LocationEdit(
            location: myLocation,
            event: widget.event,
            req: reqPost,
          );
        },
      ),
    );
  }
}
