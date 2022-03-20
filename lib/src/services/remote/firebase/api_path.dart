class ApiPath {
  static const String allCars = 'cars/';
  static String products(String carId) => 'providers/$carId/';
  static String locationsList (String userId)=> 'locations/$userId';
  static String categories (String userId)=> 'providers/$userId/';

}
