import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget buildMenuCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                offset: Offset(0, 4),
                color: Color(0x0F000000),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.surface,
                  child: Icon(icon, color: AppColors.primary, size: 26),
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final menus = [
      {
        'title': 'Book Appointment',
        'subtitle': 'Schedule your consultation',
        'icon': Icons.calendar_month,
        'route': AppRoutes.bookAppointment,
      },
      {
        'title': 'My Appointments',
        'subtitle': 'View booking history',
        'icon': Icons.receipt_long,
        'route': AppRoutes.myAppointments,
      },
      {
        'title': 'Request Medicines',
        'subtitle': 'Check medicine requests',
        'icon': Icons.medication_outlined,
        'route': AppRoutes.requestMedicines,
      },
      {
        'title': 'Doctor Availability',
        'subtitle': 'See doctor schedules',
        'icon': Icons.medical_services_outlined,
        'route': AppRoutes.doctorAvailability,
      },
      {
        'title': 'Profile',
        'subtitle': 'Manage patient details',
        'icon': Icons.person_outline,
        'route': AppRoutes.profile,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('VitalKey-iosk')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Good day, Patient!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Manage your appointments, medicines, and profile in one place.',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Clinic Hours',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Monday to Friday • 8:00 AM to 5:00 PM',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  itemCount: menus.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1.02,
                  ),
                  itemBuilder: (context, index) {
                    final item = menus[index];
                    return buildMenuCard(
                      context: context,
                      icon: item['icon'] as IconData,
                      title: item['title'] as String,
                      subtitle: item['subtitle'] as String,
                      onTap: () {
                        Navigator.pushNamed(context, item['route'] as String);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
