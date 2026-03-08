import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_textfield.dart';
import '../../../shared/widgets/section_title.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'Register',
                subtitle: 'Create your patient account.',
              ),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'First Name',
                controller: firstNameController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Last Name',
                controller: lastNameController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Birthday',
                controller: birthdayController,
              ),
              const SizedBox(height: 16),
              CustomTextField(label: 'Sex', controller: sexController),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Mobile Number',
                controller: mobileController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Create Account',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.otp);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
