class MapAddressProvider{
  String _originAddress;
  String _originCity;
  String _originState;
  String _originZipCode;
  String _destinationAddress;
  String _destinationCity;
  String _destinationState;
  String _destinationZipCode;

  // Getters
  get originAddress => _originAddress;
  get originCity => _originCity;
  get originState => _originState;
  get originZipCode => _originZipCode;
  get destinationAddress => _destinationAddress;
  get destinationCity => _destinationCity;
  get destinationState => _destinationState;
  get destinationZipCode => _destinationZipCode;

  // Setters
  MapAddressProvider(
      this._originAddress,
      this._originCity,
      this._originState,
      this._destinationZipCode,
      this._destinationAddress,
      this._destinationCity,
      this._destinationState,
      this._originZipCode,
  );
}