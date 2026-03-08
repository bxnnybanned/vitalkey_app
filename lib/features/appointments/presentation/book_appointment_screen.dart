import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_textfield.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  MockDoctor? selectedDoctor;
  String? selectedTime;
  final TextEditingController reasonController = TextEditingController();

  void submitAppointment() {
    if (selectedDoctor == null ||
        selectedTime == null ||
        reasonController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all appointment details.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Appointment Submitted'),
        content: Text(
          'Doctor: ${selectedDoctor!.name}\n'
          'Time: $selectedTime\n'
          'Reason: ${reasonController.text.trim()}\n\n'
          'Your queue number is A-010.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final doctors = MockData.doctors;

    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Schedule Consultation',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Select a doctor, choose a schedule, and enter your reason for visit.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),

              const Text(
                'Select Doctor',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              ...doctors.map((doctor) {
                final isSelected = selectedDoctor == doctor;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDoctor = doctor;
                      selectedTime = null;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFEFF6FF)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.border,
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.surface,
                          child: const Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                doctor.specialization,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              if (selectedDoctor != null) ...[
                const SizedBox(height: 10),
                const Text(
                  'Available Schedule',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: selectedDoctor!.availableSlots.map((slot) {
                    final isSelected = selectedTime == slot;
                    return ChoiceChip(
                      label: Text(slot),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          selectedTime = slot;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],

              const SizedBox(height: 24),
              CustomTextField(
                label: 'Reason for Visit',
                controller: reasonController,
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Submit Appointment',
                onPressed: submitAppointment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
