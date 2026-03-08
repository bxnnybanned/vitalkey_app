import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_textfield.dart';
import '../../../shared/widgets/section_title.dart';

class AdditionalInfoScreen extends StatelessWidget {
  AdditionalInfoScreen({super.key});

  final TextEditingController addressController = TextEditingController();
  final TextEditingController emergencyNameController = TextEditingController();
  final TextEditingController emergencyContactController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Additional Information')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'Complete Profile',
                subtitle: 'Provide your address and emergency contact details.',
              ),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'Address',
                controller: addressController,
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Emergency Contact Name',
                controller: emergencyNameController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Emergency Contact Number',
                controller: emergencyContactController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Save',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.dashboard,
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
