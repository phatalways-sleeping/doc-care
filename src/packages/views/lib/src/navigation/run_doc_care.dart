// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/screens.dart';
import 'package:views/src/screens/admin/management/v2/create/flows/dc_admin_create_staff_flow.dart';
import 'package:views/src/screens/admin/management/v2/remove/screens/dc_staff_removal_screen.dart';
import 'package:views/src/screens/admin/report/dc_admin_generate_report.dart';
import 'package:views/src/screens/authentication/change_password/dc_change_password_screen.dart';
import 'package:views/src/screens/doctors/absent/dc_doctor_absent_screen.dart';
import 'package:views/src/screens/doctors/prescription/dc_doctor_prescribe_medicine_flow.dart';
import 'package:views/src/screens/receptionist/absent/dc_receptionist_absent.dart';
import 'package:views/src/screens/users/booking/flows/dc_doctor_view_main_screen.dart';
import 'package:views/src/screens/users/booking/flows/dc_schedule_view_screen.dart';
import 'package:views/src/screens/users/prescription/dc_customer_view_prescription_flow.dart';

void runDocCare() => runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepositoryService>(
            create: (context) => SupabaseAuthenticationRepository(),
          ),
          RepositoryProvider<StorageRepositoryService>(
            create: (context) => SupabaseStorageRepository(),
          ),
          RepositoryProvider<AdministratorRepositoryService>(
            create: (context) => SupabaseAdminRepository(),
          ),
        ],
        child: MaterialApp(
          title: 'DocCare',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: const DocCareLightColorScheme(),
          ),
          initialRoute: '/prescription',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/splash':
                return MaterialPageRoute(
                  builder: (context) => RestorationScope(
                    restorationId: 'splash',
                    child: DCSplashScreen(
                      navigatorKey: GlobalKey<NavigatorState>(
                        debugLabel: 'splash',
                      ),
                    ),
                  ),
                );
              case '/sign-up':
                return MaterialPageRoute(
                  builder: (context) => DCSignUpScreen(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'sign-up',
                    ),
                  ),
                );
              case '/forgot-password':
                return MaterialPageRoute(
                  builder: (context) => DCChangePasswordScreen(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'forgot-password',
                    ),
                  ),
                );
              case '/sign-out':
                return MaterialPageRoute(
                  builder: (context) => const SizedBox.shrink(),
                );
              case '/home':
                return MaterialPageRoute(
                  builder: (context) => const SizedBox.shrink(),
                );
              case '/profile':
                return MaterialPageRoute(
                  builder: (context) => DCProfileScreen(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'profile',
                    ),
                  ),
                );
              case '/prescription':
                return MaterialPageRoute(
                  builder: (context) => DCCustomerViewPrescriptionFlow(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'prescription',
                    ),
                  ),
                );
              case '/schedule/doctor':
                return MaterialPageRoute(
                  builder: (context) => DCDoctorViewMainScreen(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'schedule/doctor',
                    ),
                  ),
                );
              case '/booking':
                return MaterialPageRoute(
                  builder: (context) => DCScheduleViewScreen(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'schedule',
                    ),
                  ),
                );
              case '/notification':
                return MaterialPageRoute(
                  builder: (context) => const SizedBox.shrink(),
                );
              case '/admin/home':
                return MaterialPageRoute(
                  builder: (context) => const SizedBox.shrink(),
                );
              case '/admin/reports':
                return MaterialPageRoute(
                  builder: (context) => DCAdminGenerateReportScreen(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'admin/reports',
                    ),
                  ),
                );
              case '/admin/staff/create':
                return MaterialPageRoute(
                  builder: (context) => const DCAdminCreateStaffFlow(),
                );
              case '/admin/staff/delete':
                return MaterialPageRoute(
                  builder: (context) => const DCStaffRemovalScreen(),
                );
              case '/doctor/home':
                return MaterialPageRoute(
                  builder: (context) => const SizedBox.shrink(),
                );
              case '/doctor/message':
                return MaterialPageRoute(
                  builder: (context) => const SizedBox.shrink(),
                );
              case '/doctor/notification':
                return MaterialPageRoute(
                  builder: (context) => const SizedBox.shrink(),
                );
              case '/doctor/prescribe':
                return MaterialPageRoute(
                  builder: (context) => DCDoctorPrescibeMedicineFlow(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'prescribe-doctor',
                    ),
                    customerName: 'John Doe', // Later we replace
                  ),
                );
              case '/doctor/absent-request':
                return MaterialPageRoute(
                  builder: (context) => const DCDoctorAbsentScreen(),
                );
              case '/receptionist/home':
                return MaterialPageRoute(
                  builder: (context) => const DCReceptionistAbsentScreen(),
                );
              case '/receptionist/booking':
                return MaterialPageRoute(
                  builder: (context) => DCDoctorViewMainScreen(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'schedule/receptionist',
                    ),
                  ),
                );

              default:
                return MaterialPageRoute(
                  builder: (context) => const SizedBox.shrink(),
                );
            }
          },
          restorationScopeId: 'doccare',
        ),
      ),
    );