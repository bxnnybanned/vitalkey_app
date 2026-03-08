import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_textfield.dart';
import '../../../shared/widgets/section_title.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'Verify OTP',
                subtitle: 'Enter the code sent to your mobile number.',
              ),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'OTP Code',
                controller: otpController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Verify',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.additionalInfo);
                },
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Resend OTP'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
