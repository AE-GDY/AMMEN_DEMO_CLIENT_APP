

import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class DataBaseService{

  final CollectionReference policyApprovals = FirebaseFirestore.instance.collection('users-policy-approvals');
  final CollectionReference policyRequests = FirebaseFirestore.instance.collection('users-policy-requests');
  final CollectionReference brokerPolicyRequests = FirebaseFirestore.instance.collection('users-policy-requests-broker');
  final CollectionReference claimRequests = FirebaseFirestore.instance.collection('users-claim-requests');
  final CollectionReference brokerClaimRequests = FirebaseFirestore.instance.collection('users-claim-requests-broker');
  final CollectionReference claimApprovals = FirebaseFirestore.instance.collection('users-claim-approvals');
  final CollectionReference usersSignedUp = FirebaseFirestore.instance.collection('users-signed-up');
  final CollectionReference insuranceCompanyList = FirebaseFirestore.instance.collection('insurance-companies');
  final CollectionReference brokerCompanyList = FirebaseFirestore.instance.collection('broker-companies');
  final CollectionReference serviceCenterList = FirebaseFirestore.instance.collection('service-centers');
  final CollectionReference complainCollection = FirebaseFirestore.instance.collection('user-complains');
  final CollectionReference centersCollection = FirebaseFirestore.instance.collection('centers-requests');


  Future updateApprovals(String insuranceComp, String policyHolderName, int currentAmount) async {
    return await policyApprovals.doc(insuranceComp).set({
      '${currentAmount-1}' : {
        'policy-holder-name': policyHolderName,
      },
      'total-approved-amount' : currentAmount,
      'company-name': insuranceComp,
    },SetOptions(merge: true),
    );
  }

  Future addServiceCenter(String serviceCenter) async {
    return await centersCollection.doc("requests").set({
      serviceCenter : {
        'total-requests': -1,
      },
    },SetOptions(merge: true),
    );
  }

  Future addCompanyToClaims(String companyType,String companyName,) async {
    return await (companyType == "Insurance Company"?claimRequests:brokerClaimRequests).doc("claims").set({
      companyName : {
        'total-claim-amount' : -1,
      },
    },SetOptions(merge: true),
    );
  }

  Future addCompanyToComplains(String companyName) async {
    return await complainCollection.doc("complains").set({
      companyName : {
        'total-complains' : -1,
      },
    },SetOptions(merge: true),
    );
  }

  Future signUpCompany(
      bool fullInsurance,
      bool thirdParty,
      String companyType,
      String companyName,
      String companyEmail,
      String companyPassword,
      String phoneNumber,
      String companyPremium,
      List<String> coverageTypes,
      List<String> additionalCoverages,
      int companyIndex,
      ) async {
    return await (companyType == "Insurance Company"?insuranceCompanyList:
    serviceCenterList).doc(companyType == "Insurance Company"?'insurance-company-list':'service-center-list').set({
      '$companyIndex' : {
        'full-insurance': fullInsurance,
        'third-party': thirdParty,
        'company-name': companyName,
        'company-phone': phoneNumber,
        'company-email': companyEmail,
        'company-password': companyPassword,
        'company-premium': companyType == "Insurance Company"?companyPremium:"",
        'coverage-types': companyType != "Service Center"?coverageTypes:"",
        'coverage-types-amount': coverageTypes.length,
        'additional-coverages-amount': additionalCoverages.length,
        'additional-coverages': companyType != "Service Center"?additionalCoverages:"",
        'company-index': companyIndex,
      },
      'company-amount': companyIndex,
    },SetOptions(merge: true),
    );
  }




  Future tempUpdateBrokerVehicles(int userIdx) async {
    return await policyRequests.doc("requests").set({
      '$userIdx':{
        'vehicle-type': '',
      }
    }, SetOptions(merge: true),
    );
  }

  Future tempUpdateBrokerVehiclesMultiple(int userIdx, int vehicleIdx) async {
    return await policyRequests.doc("requests").set({
      '$userIdx':{
        'vehicles': {
          '$vehicleIdx':{
            'vehicle-type': '',
          },
        },
      }
    }, SetOptions(merge: true),
    );
  }



  Future updateUserComplains(int complainIdx,String notSender,String notText,String notType ,int userIndex, int notificationIndex) async {
    return await usersSignedUp.doc("users").set({
      '$userIndex' : {
        'notifications': {
          '$notificationIndex':{
            'notification-type': notType,
            'notification-sender': notSender,
            'notification-text' : notText,
            'complain-index': complainIdx,
            'available': true,
          },
        },
        'notification-amount' : notificationIndex,
      },
    },SetOptions(merge: true),
    );
  }

  Future updatePolicyIdx(int currentPolicyIdx) async {
    return await policyRequests.doc("current-policy-request").set({
      'current-policy-index': currentPolicyIdx,
    },SetOptions(merge: true),
    );
  }

  Future updateSchedulingToWaitingUserApproval(String Comp, int policyIndex) async {
    return await (policyRequests).doc(Comp).set({
      '$policyIndex': {
        'status-scheduling': false,
        'status-waiting-user-schedule-approval': true,
        'status-schedule-date-denied': false,
      },
    },SetOptions(merge: true),
    );
  }

  Future updateToWaitingBrokerScheduleApproval(String Comp, int policyIndex) async {
    return await (policyRequests).doc(Comp).set({
      '$policyIndex': {
        'status-scheduling': false,
        'status-waiting-broker-schedule-approval': true,
        'status-schedule-date-denied':false,
      },
    },SetOptions(merge: true),
    );
  }


  Future brokerUpdateSchedulingToWaitingUserApproval(String Comp, int policyIndex) async {
    return await (policyRequests).doc(Comp).set({
      '$policyIndex': {
        'status-scheduling': false,
        'status-waiting-user-schedule-approval': true,
      },
    },SetOptions(merge: true),
    );
  }

  Future updateUserApprovalToInspection(String Comp, int policyIndex) async {
    return await (policyRequests).doc(Comp).set({
      '$policyIndex': {
        'status-waiting-user-schedule-approval': false,
        'status-inspection': true,
      },
    },SetOptions(merge: true),
    );
  }

  Future updateSchedulingToWaitingUserApprovalStatus(String Comp, int policyIndex) async {
    return await (policyRequests).doc(Comp).set({
      '$policyIndex': {
        'status-waiting-broker-schedule-approval': false,
        'status-waiting-user-schedule-approval': true,
      },
    },SetOptions(merge: true),
    );
  }





  Future requestsDocUpdateSchedulingToWaitingUserApproval(
      int policyIndex,String time, int day, int month,
      int year, int globalPolicyIdx,String globalComp, bool signInAsBroker) async {
    return await policyRequests.doc("requests").set({
      '$policyIndex': {
        'status-scheduling': false,
        'status-waiting-user-schedule-approval': true,
        'status-schedule-date-denied': false,
        'time-scheduled': time,
        'day-scheduled': day,
        'month-scheduled': month,
        'year-scheduled': year,
        'policy-idx': globalPolicyIdx,
        'global-comp': globalComp,
        'sign-in-as-broker': signInAsBroker,
      },
    },SetOptions(merge: true),
    );
  }

  Future requestsDocUpdateSchedulingToWaitingUserApprovalStatus(int policyIndex) async {
    return await policyRequests.doc("requests").set({
      '$policyIndex': {
        'status-waiting-broker-schedule-approval': false,
        'status-waiting-user-schedule-approval': true,
      },
    },SetOptions(merge: true),
    );
  }



  Future requestsDocUpdateToWaitingBrokerScheduleApproval(
      int policyIndex,String time, int day, int month,
      int year, int globalPolicyIdx,String globalComp, bool signInAsBroker) async {
    return await policyRequests.doc("requests").set({
      '$policyIndex': {
        'status-scheduling': false,
        'status-waiting-broker-schedule-approval': true,
        'status-schedule-date-denied': false,
        'time-scheduled': time,
        'day-scheduled': day,
        'month-scheduled': month,
        'year-scheduled': year,
        'policy-idx': globalPolicyIdx,
        'global-comp': globalComp,
        'sign-in-as-broker': signInAsBroker,
      },
    },SetOptions(merge: true),
    );
  }



  Future requestsDocUpdateUserApprovalToInspection(int policyIndex) async {
    return await policyRequests.doc("requests").set({
      '$policyIndex': {
        'status-waiting-user-schedule-approval': false,
        'status-inspection': true,
      },
    },SetOptions(merge: true),
    );
  }



  Future requestsDocUpdateInspectionToUnderwriting(int policyIndex) async {
    return await policyRequests.doc("requests").set({
      '$policyIndex': {
        'status-waiting-broker-inspection-approval': false,
        'status-underwriting': true,
        'status-inspection': false,
      },
    },SetOptions(merge: true),
    );
  }

  Future requestsDocUpdateInspectionToBrokerInspectionApproval(int policyIndex) async {
    return await policyRequests.doc("requests").set({
      '$policyIndex': {
        'status-waiting-broker-inspection-approval': true,
        'status-inspection': false,
      },
    },SetOptions(merge: true),
    );
  }

  Future requestsDocUpdateUnderwritingToBrokerUnderwritingApproval(int policyIndex) async {
    return await policyRequests.doc("requests").set({
      '$policyIndex': {
        'status-waiting-broker-underwriting-approval': true,
        'status-user-denied-policy-details': false,
        'status-underwriting': false,
      },
    },SetOptions(merge: true),
    );
  }



  Future requestsDocUpdateUnderwritingToWaitingIcApproval(int policyIndex, String policyPremium) async {
    return await policyRequests.doc("requests").set({
      '$policyIndex': {
        'status-underwriting': false,
        'status-waiting-ic-approval': true,
        'status-user-denied-policy-details': false,
        'status-waiting-broker-underwriting-approval': false,
        'policy-amount': policyPremium,
      },
    },SetOptions(merge: true),
    );
  }

  Future requestsDocUpdateUnderwritingToWaitingBrokerApproval(int policyIndex, String policyPremium) async {
    return await policyRequests.doc("requests").set({
      '$policyIndex': {
        'status-underwriting': false,
        'status-user-denied-policy-details': false,
        'status-waiting-broker-underwriting-approval': true,
        'policy-amount': policyPremium,
      },
    },SetOptions(merge: true),
    );
  }


  requestsDocUpdateUnderwritingToWaitingIcApprovalNoChangeInAmount(int policyIndex) async {
    return await policyRequests.doc("requests").set({
      '$policyIndex': {
        'status-underwriting': false,
        'status-user-denied-policy-details': false,
        'status-waiting-broker-underwriting-approval': false,
        'status-waiting-ic-approval': true,
      },
    },SetOptions(merge: true),
    );
  }

  requestsDocUpdateUnderwritingToWaitingBrokerApprovalNoChangeInAmount(int policyIndex) async {
    return await policyRequests.doc("requests").set({
      '$policyIndex': {
        'status-underwriting': false,
        'status-user-denied-policy-details': false,
        'status-waiting-broker-underwriting-approval': true,
      },
    },SetOptions(merge: true),
    );
  }




  Future requestsDocUpdateWaitingICApprovalToApprovedRequest(int policyIndex) async {
    return await policyRequests.doc("requests").set({
      '$policyIndex': {
        'status-waiting-ic-approval': false,
        'status-ic-approved': true,
      },
    },SetOptions(merge: true),
    );
  }

  Future updatingAmount(int policyIndex, int policyAmount) async {
    return await policyRequests.doc("requests").set({
      '$policyIndex': {
        'policy-amount': policyAmount,
      },
    },SetOptions(merge: true),
    );
  }

  Future updateSchedulingToWaitingDateApproval(int currentUserIdx, int currentVehicleIdx,
      int day, int month, int year, String time) async {
    return await policyRequests.doc("requests").set({
      '$currentUserIdx': {
        '$currentVehicleIdx': {
          'status-waiting-date-approval': true,
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future updateWaitingDateApprovalToApproved(int currentUserIdx, int currentVehicleIdx,
      int day, int month, int year, String time) async {
    return await policyRequests.doc("requests").set({
      '$currentUserIdx': {
        '$currentVehicleIdx': {
          'status-waiting-date-approval': false,
          'status-date-approved': true,
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future updateInspectionToUnderwriting(String Comp, int policyIndex, bool signInAsBroker) async {
    return await (signInAsBroker?brokerPolicyRequests:policyRequests).doc(Comp).set({
      '$policyIndex': {
        'status-inspection': false,
        'status-waiting-broker-inspection-approval': false,
        'status-underwriting': true,
      },
    },SetOptions(merge: true),
    );
  }

  Future updateInspectionToBrokerInspectionApproval(String Comp, int policyIndex, bool signInAsBroker) async {
    return await (signInAsBroker?brokerPolicyRequests:policyRequests).doc(Comp).set({
      '$policyIndex': {
        'status-inspection': false,
        'status-waiting-broker-inspection-approval': true,
      },
    },SetOptions(merge: true),
    );
  }

  Future updateUnderwritingToWaitingICApproval(String Comp, int policyIndex, bool signInAsBroker) async {
    return await (signInAsBroker?brokerPolicyRequests:policyRequests).doc(Comp).set({
      '$policyIndex': {
        'status-underwriting': false,
        'status-waiting-broker-underwriting-approval': false,
        'status-user-denied-policy-details': false,
        'status-waiting-ic-approval': true,
      },
    },SetOptions(merge: true),
    );
  }

  Future updateUnderwritingToWaitingApprovalBroker(String Comp, int policyIndex, bool signInAsBroker) async {
    return await (signInAsBroker?brokerPolicyRequests:policyRequests).doc(Comp).set({
      '$policyIndex': {
        'status-underwriting': false,
        'status-user-denied-policy-details': false,
        'status-waiting-broker-underwriting-approval': true,
      },
    },SetOptions(merge: true),
    );
  }


  Future updateWaitingICApprovalToApprovedRequest(String Comp, int policyIndex, bool signInAsBroker) async {
    return await (signInAsBroker?brokerPolicyRequests:policyRequests).doc(Comp).set({
      '$policyIndex': {
        'status-waiting-ic-approval': false,
        'status-ic-approved': true,
      },
    },SetOptions(merge: true),
    );
  }

  Future updatePendingPoliciesAmount(String Comp, int currentAmount, bool signInAsBroker) async {
    return await (signInAsBroker?brokerPolicyRequests:policyRequests).doc(Comp).set({
        'total-pending-policies': currentAmount,
    },SetOptions(merge: true),
    );
  }

  Future updateTotalNewRequests(String Comp, int currentAmount) async {
    return await (brokerPolicyRequests).doc(Comp).set({
      'total-new-requests': currentAmount,
    },SetOptions(merge: true),
    );
  }

  Future updateNewRequestsAmount(String Comp, int currentAmount, bool signInAsBroker) async {
    return await (signInAsBroker?brokerPolicyRequests:policyRequests).doc(Comp).set({
        'total-new-requests': currentAmount,
    },SetOptions(merge: true),
    );
  }

  Future updateApprovalsNew(String broker,String vehicleMake, String vehicleModel,int vehicleIndex, String Comp, String policyHolderName, int currentPolicyAmount, int currentPosition) async {
    return await policyApprovals.doc('approvals').set({
      '$currentPosition' : {
        'vehicle-make': vehicleMake,
        'vehicle-model': vehicleModel,
        'policy-amount' : currentPolicyAmount,
        'policy-holder-name': policyHolderName,
        'vehicle-index': vehicleIndex,
        'company-name': Comp,
        'broker-name': broker,
        'user-purchased': false,
      },
      'total-amount-approved' : currentPosition,
    },SetOptions(merge: true),
    );
  }

  Future updateApprovalsNewVehicles(int vehicleAmount,int currentVehicle,String broker,String vehicleMake, String vehicleModel,int vehicleIndex, String Comp, String policyHolderName, int currentPolicyAmount, int currentPosition) async {
    return await policyApprovals.doc('approvals').set({
      '$currentPosition' : {
        'vehicle-amount': vehicleAmount,
        'vehicles':{
          '$currentVehicle': {
            'vehicle-index': vehicleIndex,
            'vehicle-make': vehicleMake,
            'vehicle-model': vehicleModel,
          },
        },
        'policy-amount' : currentPolicyAmount,
        'policy-holder-name': policyHolderName,
        'company-name': Comp,
        'broker-name': broker,
        'user-purchased': false,
      },
      'total-amount-approved' : currentPosition,
    },SetOptions(merge: true),
    );
  }



  Future claimUpdateSchedulingToWaitingIcApproval(String Comp, int claimIndex, bool signInAsBroker) async {
    return await (signInAsBroker?brokerClaimRequests:claimRequests).doc("claims").set({
      Comp:{
        '$claimIndex': {
          'status-scheduling': false,
          'status-waiting-ic-approval': true,
        },
      },

    },SetOptions(merge: true),
    );
  }

  Future claimUpdateWaitingIcApprovalToIcApproved(String insuranceComp, int claimIndex, bool signInAsBroker) async {
    return await (signInAsBroker?brokerClaimRequests:claimRequests).doc("claims").set({
      insuranceComp:{
        '$claimIndex': {
          'status-waiting-ic-approval': false,
          'status-ic-approved': true,
          'status-waiting-requester-approval': false,
        },
      },
    },SetOptions(merge: true),
    );
  }

  Future claimUpdateApprovals(int claimNumber, int vehicleIndex,String vehicleMake, String vehicleModel,String insuranceComp, String requesterName,String claimAmount, int currentTotalClaimsIndex) async {
    return await claimApprovals.doc("approvals").set({
        '$currentTotalClaimsIndex': {
          'claim-number': claimNumber,
          'insurance-company': insuranceComp,
          'claim-requester-name':requesterName,
          'claim-amount': claimAmount,
          'vehicle-index': vehicleIndex,
          'vehicle-make': vehicleMake,
          'vehicle-model': vehicleModel,
          'user-approved':false,
        },
        'total-amount-approved': currentTotalClaimsIndex,
    },SetOptions(merge: true),
    );
  }

  Future updatePolicyRequestsData(int brokerPolicyNumber, int policyAmount, String intendedInsuranceCompany, String intendedBrokerCompany,int currentCompanyPolicy, int totalNewRequests) async{
    return await policyRequests.doc(intendedInsuranceCompany).set({
      '$currentCompanyPolicy': {
        'broker-name': intendedBrokerCompany,
        'broker-policy-number': brokerPolicyNumber,
        'policy-amount': policyAmount,

        'policy-number' : currentCompanyPolicy,
        'policy-holder-id' : globalPolicyIDs[globalCurrentPolicyIndex],
        'policy-holder-name': globalNewNames[globalCurrentPolicyIndex],
        'policy-holder-mobile': globalPolicyMobiles[globalCurrentPolicyIndex],
        'policy-holder-address': globalPolicyAddresses[globalCurrentPolicyIndex],
        'policy-holder-email':globalPolicyEmails[globalCurrentPolicyIndex],

        'vehicle-type': globalVehicleTypes[globalCurrentPolicyIndex],
        'vehicle-weight': globalVehicleWeights[globalCurrentPolicyIndex],
        'no-seats': globalNumberOfSeats[globalCurrentPolicyIndex],
        'vehicle-index': globalPolicyVehicleIndexes[globalCurrentPolicyIndex],
        'vehicle-make': globalPolicyVehicleMakes[globalCurrentPolicyIndex],
        'vehicle-model': globalPolicyVehicleModels[globalCurrentPolicyIndex],
        'vehicle-production-year': globalPolicyProductionYears[globalCurrentPolicyIndex],
        'vehicle-chassis-number': globalChassisNumbers[globalCurrentPolicyIndex],
        'vehicle-motor-number': globalPolicyMotorNumbers[globalCurrentPolicyIndex],
        'vehicle-plate-number': globalPolicyPlateNumbers[globalCurrentPolicyIndex],
        'vehicle-value': globalPolicyVehicleValues[globalCurrentPolicyIndex],
        'vehicle-license-id': globalPolicyVehicleLicenseId[globalCurrentPolicyIndex],
        'vehicle-driving-license': globalPolicyVehicleDrivingLicenses[globalCurrentPolicyIndex],

        'vehicle-amount':0,

        'status-waiting-broker-schedule-approval': false,
        'status-user-denied-policy-details':false,
        'status-schedule-date-denied':false,
        'status-waiting-broker-inspection-approval':false,
        'status-waiting-broker-underwriting-approval':false,
        'status-scheduling': true,
        'status-inspection': false,
        'status-underwriting': false,
        'status-waiting-ic-approval': false,
        'status-ic-approved': false,
        'status-waiting-user-schedule-approval': false,
      },
      'total-policy-amount' : currentCompanyPolicy,
      'total-new-requests' : totalNewRequests,
    },SetOptions(merge: true)
    );
  }

  Future updatePolicyRequestsDataCompany(
      String intendedBrokerCompany,
      int policyAmount,
      String intendedInsuranceCompany,
      int brokerPolicyNumber,
      int vehicleAmount,
      int currentVehicle,
      int currentCompanyPolicy,
      int totalNewRequests,
      ) async {
    return await policyRequests.doc(intendedInsuranceCompany).set({
      '$currentCompanyPolicy': {
        'broker-name': intendedBrokerCompany,
        'broker-policy-number': brokerPolicyNumber,
        'policy-amount': policyAmount,
        'policy-number' : currentCompanyPolicy,
        'policy-holder-id' : globalPolicyIDs[globalCurrentPolicyIndex],
        'policy-holder-name': globalNewNames[globalCurrentPolicyIndex],
        'policy-holder-mobile': globalPolicyMobiles[globalCurrentPolicyIndex],
        'policy-holder-address': globalPolicyAddresses[globalCurrentPolicyIndex],
        'policy-holder-email':globalPolicyEmails[globalCurrentPolicyIndex],
        'vehicle-amount': vehicleAmount,
        'vehicles':{
          '$currentVehicle':{
            'vehicle-type':globalVehiclesRequested[globalCurrentPolicyIndex][currentVehicle].vehicleType,
            'vehicle-weight':globalVehiclesRequested[globalCurrentPolicyIndex][currentVehicle].vehicleWeight,
            'no-seats':globalVehiclesRequested[globalCurrentPolicyIndex][currentVehicle].vehicleNumberOfSeats,
            'vehicle-index': globalVehiclesRequested[globalCurrentPolicyIndex][currentVehicle].currentIndex,
            'vehicle-make': globalVehiclesRequested[globalCurrentPolicyIndex][currentVehicle].vehicleMake,
            'vehicle-model': globalVehiclesRequested[globalCurrentPolicyIndex][currentVehicle].vehicleModel,
            'vehicle-production-year': globalVehiclesRequested[globalCurrentPolicyIndex][currentVehicle].productionYear,
            'vehicle-chassis-number': globalVehiclesRequested[globalCurrentPolicyIndex][currentVehicle].vehicleChassisNumber,
            'vehicle-motor-number': globalVehiclesRequested[globalCurrentPolicyIndex][currentVehicle].vehicleMotorNumber,
            'vehicle-plate-number': globalVehiclesRequested[globalCurrentPolicyIndex][currentVehicle].vehiclePlateNumber,
            'vehicle-value': globalVehiclesRequested[globalCurrentPolicyIndex][currentVehicle].vehicleValue,
            'vehicle-license-id': globalVehiclesRequested[globalCurrentPolicyIndex][currentVehicle].vehicleLicenseId,
            'vehicle-driving-license': globalVehiclesRequested[globalCurrentPolicyIndex][currentVehicle].vehicleLicenseId,
          },
        },

        'status-waiting-broker-schedule-approval': false,
        'status-user-denied-policy-details':false,
        'status-waiting-user-schedule-approval':false,
        'status-waiting-broker-inspection-approval':false,
        'status-waiting-broker-underwriting-approval':false,
        'status-scheduling': true,
        'status-waiting-user-schedule-approval': false,
        'status-inspection': false,
        'status-underwriting': false,
        'status-waiting-ic-approval': false,
        'status-ic-approved': false,

      },
      'total-policy-amount' : currentCompanyPolicy,
      'total-new-requests' : totalNewRequests,
    },SetOptions(merge: true)
    );
  }




  Future requestsDocUpdateIntendedCompany(int policyAmount, String intendedInsuranceCompany, int currentCompanyPolicy) async{
    return await policyRequests.doc("requests").set({
      '$currentCompanyPolicy': {
        'intended-company': intendedInsuranceCompany,
        'policy-amount': policyAmount,
      },
    },SetOptions(merge: true)
    );
  }

  Future changeIntendedCompanyUsersSignedUp(String intendedInsuranceCompany, int currentUser, int vehicleIdx) async{
    return await usersSignedUp.doc("users").set({
      '$currentUser': {
        'user-vehicles': {
          '$vehicleIdx': {
            'intended-insurance-company': intendedInsuranceCompany,
          },
        },
      },
    },SetOptions(merge: true)
    );
  }

  Future updateClaimsRequestsData(
      int claimNumberUser,
      String intendedCompany,
      int currentCompanyClaim,
      List<dynamic> invoiceItems,
      List<dynamic> invoiceFees,
      ) async {
    return await (claimRequests).doc("claims").set({
      intendedCompany:{
        '$currentCompanyClaim': {
          'claim-number-user': claimNumberUser,
          'invoice-items': invoiceItems,
          'invoice-fees': invoiceFees,
          'status-waiting-fees-approval': false,
          'status-scheduling': true,
        },
      }
    },SetOptions(merge: true)
    );
  }

  Future updateClaimsRequestsDataUser(
      int currentCompanyClaim,
      List<dynamic> invoiceItems,
      List<dynamic> invoiceFees,
      ) async {
    return await (claimRequests).doc("claims-user").set({
      '$currentCompanyClaim': {
        'invoice-items': invoiceItems,
        'invoice-fees': invoiceFees,
        'status-waiting-fees-approval': false,
        'status-scheduling': true,
      },
    },SetOptions(merge: true)
    );
  }

  Future updateClaimsRequestsDataUserWaitingICApproval(
      int currentCompanyClaim,
      ) async {
    return await (claimRequests).doc("claims-user").set({
      '$currentCompanyClaim': {
        'status-waiting-ic-approval': true,
        'status-scheduling': false,
      },
    },SetOptions(merge: true)
    );
  }

  Future updateClaimsRequestsDataUserICApproved(
      bool totalLoss,
      int currentCompanyClaim,
      double approvedFixes,
      double totalClientPay,
      ) async {
    return await (claimRequests).doc("claims-user").set({
      '$currentCompanyClaim': {
        'status-waiting-ic-approval': false,
        'status-ic-approved': true,
        'client-share': totalClientPay,
        'approved-fixes': approvedFixes,
        'total-loss': totalLoss,
      },
    },SetOptions(merge: true)
    );
  }


}

