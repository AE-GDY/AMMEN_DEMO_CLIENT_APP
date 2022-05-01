import 'package:flutter/material.dart';
import 'package:newest_insurance/models/user.dart';
import 'package:newest_insurance/pages/broker_company_dashboard.dart';
import 'package:newest_insurance/pages/claim_status.dart';
import 'package:newest_insurance/pages/claims_page.dart';
import 'package:newest_insurance/pages/complain_details.dart';
import 'package:newest_insurance/pages/complains.dart';
import 'package:newest_insurance/pages/home.dart';
import 'package:newest_insurance/pages/insurance_company_dashboard.dart';
import 'package:newest_insurance/pages/login.dart';
import 'package:newest_insurance/pages/policies_page.dart';
import 'package:newest_insurance/pages/policies_page_broker.dart';
import 'package:newest_insurance/pages/policy_status.dart';
import 'package:newest_insurance/pages/policy_status_broker.dart';
import 'package:newest_insurance/pages/service_center.dart';
import 'package:newest_insurance/pages/service_center_claim_details.dart';
import 'package:newest_insurance/pages/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newest_insurance/pages/vehicles_requested.dart';
import 'package:newest_insurance/pages_regulator/broker_companies.dart';
import 'package:newest_insurance/pages_regulator/broker_info.dart';
import 'package:newest_insurance/pages_regulator/claim_info.dart';
import 'package:newest_insurance/pages_regulator/claims.dart';
import 'package:newest_insurance/pages_regulator/company_info.dart';
import 'package:newest_insurance/pages_regulator/complains_info.dart';
import 'package:newest_insurance/pages_regulator/complains_regulator.dart';
import 'package:newest_insurance/pages_regulator/fraud.dart';
import 'package:newest_insurance/pages_regulator/home_page.dart';
import 'package:newest_insurance/pages_regulator/insurance_companies.dart';
import 'package:newest_insurance/pages_regulator/insurance_companies_table.dart';
import 'package:newest_insurance/pages_regulator/insurance_company_page.dart';
import 'package:newest_insurance/pages_regulator/policies.dart';
import 'package:newest_insurance/services/authentication.dart';
import 'package:provider/provider.dart';

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAziDcd2PF0SN8yOE8m23_A4diglniENMo", // Your apiKey
      appId: "1:694959465222:web:ec7e9763c7a1246d513487", // Your appId
      messagingSenderId: "694959465222", // Your messagingSenderId
      projectId: "insurance-project-7c01e", // Your projectId
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<appUser?>.value(
      initialData: null,
      value: AuthService().users,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/':(context) => LoginPage(),
          '/broker_details':(context) => BrokerDetails(),
          '/vehiclesRequested':(context) => VehiclesRequested(),
          '/broker-dashboard': (context) => BrokerCompanyDashboard(),
          '/broker-page':(context) => PoliciesPageBroker(),
          '/broker-policy-status':(context) => PolicyStatusBroker(),
          '/home': (context) => InsuranceCompanyDashboard(),
          '/fraud': (context) => Fraud(),
          '/home-regulator': (context) => MyHomePage(title: 'Home'),
          '/insurance_details': (context) => InsuranceDetails(),
          '/insurance_table': (context) =>InsuranceCompaniesDetails(),
          '/insurance_page': (context) => InsuranceCompanyPage(),
          '/policy-status': (context) => PolicyStatus(),
          '/complains': (context) => Complains(),
          '/claims-page':(context) => ClaimsPage(),
          '/claim-status':(context)=> ClaimStatus(),
          '/policies-page':(context)=> PoliciesPage(),
          '/complains-details': (context) => ComplainsDetails(),
          '/service-center-dashboard':(context) => ServiceCenterDashboard(),
          '/service-center-details':(context) => CenterClaimDetails(),
          '/company-info': (context) => CompanyInfo(),
          '/broker-info': (context) => BrokerInfo(),
          '/claim-info': (context) => ClaimInfo(),
          '/complains-info':(context) => ComplainsInfo(),
          '/claims-regulator': (context) => Claims(),
          '/policies-regulator': (context) => Policies(),
          '/complains_regulator':(context) => ComplainsRegulator(),
        },
      ),
    );
  }
}

