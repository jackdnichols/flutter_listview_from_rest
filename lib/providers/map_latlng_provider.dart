class MapLatLngProvider{
  double _originLatitude;
  double _originLongitude;
  double _destinationLatitude;
  double _destinationLongitude;

  // Getters
  get originLatitude => _originLatitude;
  get originLongitude => _originLongitude;
  get destinationLatitude => _destinationLatitude;
  get destinationLongitude => _destinationLongitude;

  // Setters
  MapLatLngProvider(
      this._originLatitude,
      this._originLongitude,
      this._destinationLatitude,
      this._destinationLongitude,
  );
}

