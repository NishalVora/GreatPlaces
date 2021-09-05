import 'dart:io';
import 'package:Great_Places/models/place.dart';

import '../providers/great_places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = 'add-place-screen';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat,double lng){
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);

  }

  void savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage,_pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                      // decoration:,
                    ),
                    SizedBox(height: 10),
                    ImageInput(_selectImage),
                    SizedBox(height:10),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          
          RaisedButton.icon(
            color: Theme.of(context).accentColor,
            onPressed: savePlace,
            icon: Icon(Icons.add),
            label: Text('Add a place'),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          )
        ],
      ),
    );
  }
}