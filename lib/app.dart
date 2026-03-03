import 'package:flutter/material.dart';
import 'routes.dart';

import 'screens/splash/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/profile/profile_setup_screen.dart';
import 'screens/profile/patient_id_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/request/request_menu_screen.dart';
import 'screens/request/checkup_request_screen.dart';
import 'screens/request/medicine_request_screen.dart';
import 'screens/schedule/schedule_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthcare Appointment',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) =>
            const SplashScreen(), // ok kung const talaga SplashScreen mo
        AppRoutes.login: (_) => const LoginScreen(), // ok kung const
        AppRoutes.register: (_) => RegisterScreen(),
        AppRoutes.profileSetup: (_) => ProfileSetupScreen(),
        AppRoutes.patientId: (_) => PatientIdScreen(),
        AppRoutes.home: (_) => const HomeScreen(), // ok kung const
        AppRoutes.requestMenu: (_) => RequestMenuScreen(),
        AppRoutes.checkupRequest: (_) => CheckupRequestScreen(),
        AppRoutes.medicineRequest: (_) => MedicineRequestScreen(),
        AppRoutes.schedule: (_) => ScheduleScreen(),
      },
    );
  }
}
