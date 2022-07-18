
class UserVehicleWidget{

  final String vehicleMake;
  final String vehicleModel;
  final String productionYear;
  final String vehicleValue;
  final String vehicleLicenseId;
  final String vehicleChassisNumber;
  final String vehicleMotorNumber;
  final String vehiclePlateNumber;
  final int currentIndex;
  final String vehicleType;
  final String vehicleWeight;
  final String vehicleNumberOfSeats;

  const UserVehicleWidget({
    required this.vehicleMake,
    required this.vehicleModel,
    required this.productionYear,
    required this.vehicleValue,
    required this.vehicleLicenseId,
    required this.currentIndex,
    required this.vehicleChassisNumber,
    required this.vehicleMotorNumber,
    required this.vehiclePlateNumber,
    required this.vehicleType,
    required this.vehicleWeight,
    required this.vehicleNumberOfSeats,
  });
}