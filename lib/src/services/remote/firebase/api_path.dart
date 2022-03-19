class ApiPath {
  static const String allCars = 'cars/';
  static String products(String carId) => 'cars/$carId';
  static String locationsList (String userId)=> 'locations/$userId';

}
