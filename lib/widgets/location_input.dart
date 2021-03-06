import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function _onSelectPlace;

  LocationInput(this._onSelectPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void showPreview(double latitude,double longitude){
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: latitude,
      longitude: longitude,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();    
    showPreview(locData.latitude,locData.longitude);
    widget._onSelectPlace(locData.latitude, locData.longitude);
  }

  Future<void> _getLocationOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) {
          return MapScreen(isSelecting: true);
        },
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    // print(selectedLocation);
    showPreview(selectedLocation.latitude,selectedLocation.longitude);
    widget._onSelectPlace(
        selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(_previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity, errorBuilder: (BuildContext context,
                      Object exception, StackTrace stackTrace) {
                  return Icon(Icons.do_not_disturb);
                }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.location_on,
              ),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentUserLocation,
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.map,
              ),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getLocationOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
