

class appUser{
  final String uid;
  final String name;
  final String idNumber;
  final String address;
  final String mobileNumber;
  final String emailAddress;
  final String idCopy;

  appUser({
    required this.uid,
    this.name = "",
    this.idNumber = "-1",
    this.address = "none",
    this.mobileNumber = "-1",
    this.emailAddress = "-1",
    this.idCopy = "-1"
  });
}