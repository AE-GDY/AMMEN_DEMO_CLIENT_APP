


import 'dart:ui';

import 'package:newest_insurance/models/user_vehicle.dart';

const mainColor = Color(0xff2470c7);
double globalWidth = 100;
double globalHeight = 100;

List<String> clientNamesForPolicyRequests = [];

int currentPoliciesApproved = 0;


// Policy Issuance global variables
int globalCurrentPolicyIndex = -1;
List<int> globalPolicyPositions = [];
List<bool> globalPolicyApprovedByIC = [];
List<int> globalPolicyAmounts = [];
List<String> globalNewNames = [];
List<String> globalPolicyIDs = [];
List<String> globalPolicyMobiles = [];
List<String> globalPolicyAddresses = [];
List<String> globalPolicyEmails = [];
List<String> globalPolicyVehicleMakes = [];
List<String> globalPolicyVehicleModels = [];
List<String> globalPolicyProductionYears = [];
List<String> globalPolicyVehicleValues = [];
List<String> globalPolicyVehicleLicenseId = [];
List<String> globalPolicyVehicleDrivingLicenses = [];
List<int> globalPolicyVehicleIndexes = [];
List<String> globalPolicyPlateNumbers = [];
List<String> globalChassisNumbers = [];
List<String> globalPolicyMotorNumbers = [];
List<String> globalBrokerNames = [];
List<int> globalBrokerPolicyNumbers = [];
List<List<UserVehicleWidget>> globalVehiclesRequested = [];
String globalCurrentInsuranceCompanyAssigned  = '';

// Claim Issuance Global Variables
List<String> globalClaimCenters = [];
List<int> globalClaimNumbers = [];
List<String> globalClaimAccidentInfo = [];
List<String> globalClaimAccidentLocations = [];
List<String> globalClaimAddresses = [];
List<String> globalClaimDateOfBirths = [];
List<String> globalClaimEmails = [];
List<String> globalClaimIds = [];
List<String> globalClaimMobiles = [];
List<String> globalClaimRequesterNames = [];
List<String> globalClaimVehicleLicenses = [];
List<int> globalClaimVehicleIndexes = [];
List<String> globalClaimVehicleMakes = [];
List<String> globalClaimVehicleModels = [];
List<String> globalClaimVehicleProductionYears = [];
List<String> globalClaimVehicleValues = [];
List<String> globalClaimIntendedInsuranceCompanies = [];
List<bool> globalClaimApprovedByIC = [];
List<bool> globalClaimApprovedByUser = [];
List<int> globalClaimNumberUsers = [];
List<bool> globalDeclinedAmount = [];
List<String> globalUserComments = [];
List<String> globalPolicyValues = [];

// keeps track of which claim is currently selected
int globalCurrentClaimIndex = 0;



//complain information
List<String> globalComplainRequestersNames = [];
List<String> globalComplainRequestersIDs = [];
List<String> globalComplainRequestersDrivingLicenses = [];
List<String> globalComplainRequestersEmails = [];
List<String> globalComplainRequestersComplains = [];
int globalCurrentComplainIndex = 0;
List<int> globalCurrentIndexes = [];





// keeps track of how many policies have been approved by every insurance company
Map<String, int> currentPolicyAmountApproved = {
  'المجموعة العربية المصرية للتأمين': 0,
  'مصر للتأمين': 0,
  'قناة السويس للتأمين': 0,
  'الشركة الأهلية للتأمين': 0,
  'نايل تكافل': 0,
  'بيت التأمين المصري السعودي': 0,
  'شركة المهندس للتأمين': 0,
  'الدلتا للتأمين': 0,
};


List<String> insuranceCompanyList = [
  'المجموعة العربية المصرية للتأمين',
  'مصر للتأمين',
  'قناة السويس للتأمين',
  'الشركة الأهلية للتأمين',
  'نايل تكافل',
  'بيت التأمين المصري السعودي',
  'شركة المهندس للتأمين',
  'الدلتا للتأمين',
];

List<String> brokerCompanyList = [
  'Deraya Insurance Brokerage',
  'BMW Egypt Insurance',
  'Future Insurance Brokerage',
  'GoodLife Insurance Brokers',
  'GIG Insurance Brokers',
];

List<String> serviceCentersAndWorkshopsList = [
  'Tobgui Auto Service Center',
  'ESC (European Service Center)',
  'Auto Fix Service Center',
  'Car Clinic Service Center',
  'VAG Egypt Garage',
  'Fix Your Range Egypt',
  'Caps Auto Egypt',
];


String? insComp;
String? brokerComp;
String? serviceOrWorkshop;

String currentInsuranceCompany = "المجموعة العربية المصرية للتأمين";
String currentBrokerCompany = "Deraya Insurance Brokerage";
String currentServiceOrWorkshop = 'Tobgui Auto Service Center';

String currentCompany = '';

bool signInAsRegulator = false;
bool signInAsBroker = false;
bool signInAsServiceOrWorkshop = false;


bool onCalender = false;
DateTime timePicked = DateTime.now();


class UserPolicyIssuance{
  // user info when registering for policy issuance
  String intendedInsuranceCompany = '';
  int insuranceAmount = 0;
  String policyHolderID = '';
  String policyHolderName = '';
  String mobile = '';
  String address = '';
  String email = '';
  String policyNumber = '';

  String vehicleChassisNumber = '';
  String vehicleMotorNumber = '';
  String vehiclePlateNumber = '';

// vehicle info when registering for policy issuance
  int vehicleIndex = 0;
  String vehicleMake = '';
  String vehicleModel = '';
  String productionYear = '';
  String vehicleValue = '';
  String carLicenseId = '';
  String drivingLicenseId = '';

  UserPolicyIssuance({
    required this.vehicleIndex,
    required this.insuranceAmount,
    required this.intendedInsuranceCompany,
    required this.policyHolderID,
    required this.policyHolderName,
    required this.mobile,
    required this.address,
    required this.email,


    required this.vehicleMake,
    required this.vehicleModel,
    required this.productionYear,
    required this.vehicleValue,
    required this.carLicenseId,
    required this.drivingLicenseId,

    required this.vehicleChassisNumber,
    required this.vehicleMotorNumber,
    required this.vehiclePlateNumber,
  });

}

List<List<dynamic>> globalInvoiceItems = [];
List<List<dynamic>> globalInvoiceFees = [];
List<dynamic> invoiceItems = [];
List<dynamic> invoiceFees = [];


List<dynamic> invoiceItemsOnComp = [];
List<dynamic> invoiceFeesOnComp = [];
List<bool> invoiceItemsChecked = [];

bool waitingIcApproval = false;

double overallFees = 0;
double approvedFixesAmount = 0;
double totalClientPay = 0;
double companyShareAmount = 0;
double clientDeductibleAmount = 0;
double outOfCoverageAmount = 0;


String policyPremium = "";


bool onBrokerDetails = false;


String globalCompanyAssigned = '';

List<List<int>> globalPolicyMultipleVehicleIndexes = [];

List<int> globalComplainUserIdxs = [];

List<String> globalVehicleTypes = [];
List<String> globalVehicleWeights = [];
List<String> globalNumberOfSeats = [];


String currentPage = 'dashboard';