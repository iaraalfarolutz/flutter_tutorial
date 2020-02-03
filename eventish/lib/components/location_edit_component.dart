import 'package:eventish/models/Event.dart';
import 'package:flutter/material.dart';
import 'package:eventish/models/Location.dart';
import 'package:eventish/constants.dart';
import 'package:flutter/services.dart';

class LocationEdit extends StatefulWidget {
  final Location location;
  final Event event;
  final Function req;
  LocationEdit({@required this.location, this.event, this.req});
  @override
  _LocationEditState createState() => _LocationEditState();
}

class _LocationEditState extends State<LocationEdit> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(15.0),
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Event name',
          ),
          cursorColor: kButtonColor,
          initialValue: widget.location != null ? widget.location.name : "",
          onChanged: (text) {
            setState(() {
              widget.location.name = text;
            });
          },
        ),
        SizedBox(
          height: 15.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Latitud',
                ),
                cursorColor: kButtonColor,
                initialValue: widget.location != null
                    ? widget.location.latitud.toString()
                    : "2.3",
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                inputFormatters: [
                  BlacklistingTextInputFormatter(new RegExp('[\\ ]'))
                ],
                onChanged: (text) {
                  setState(() {
                    widget.location.latitud = double.parse(text);
                  });
                },
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Longitud',
                ),
                cursorColor: kButtonColor,
                initialValue: widget.location != null
                    ? widget.location.longitud.toString()
                    : "5.4",
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                inputFormatters: [
                  BlacklistingTextInputFormatter(new RegExp('[\\ ]'))
                ],
                onChanged: (text) {
                  setState(() {
                    widget.location.longitud = double.parse(text);
                  });
                },
              ),
            )
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        Divider(
          color: kButtonColor,
          height: 4.0,
          endIndent: 15.0,
          indent: 15.0,
          thickness: 2.0,
        ),
        CheckboxListTile(
          title: Text(
            'Confirmed: ',
            style: TextStyle(fontSize: 20.0),
          ),
          checkColor: kButtonColor,
          activeColor: Colors.white,
          value: widget.location.confirmed,
          onChanged: (value) {
            setState(() {
              widget.location.confirmed = value;
            });
          },
        ),
        Divider(
          color: kButtonColor,
          height: 4.0,
          endIndent: 15.0,
          indent: 15.0,
          thickness: 2.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        RaisedButton(
          color: kButtonColor,
          child: Text('SAVE'),
          onPressed: () {
            Navigator.of(context).pop(widget.location);
          },
        )
      ],
    );
  }
}
