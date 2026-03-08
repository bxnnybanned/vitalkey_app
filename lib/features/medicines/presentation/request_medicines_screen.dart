import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_textfield.dart';

class RequestMedicinesScreen extends StatefulWidget {
  const RequestMedicinesScreen({super.key});

  @override
  State<RequestMedicinesScreen> createState() => _RequestMedicinesScreenState();
}

class _RequestMedicinesScreenState extends State<RequestMedicinesScreen> {
  final TextEditingController medicineController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  void submitRequest() {
    if (medicineController.text.trim().isEmpty ||
        quantityController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter medicine name and quantity.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Medicine request submitted successfully.')),
    );

    medicineController.clear();
    quantityController.clear();
    notesController.clear();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Ready for Pickup':
        return Colors.green;
      case 'Pending Review':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final requests = MockData.medicineRequests;

    return Scaffold(
      appBar: AppBar(title: const Text('Request Medicines')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Medicine Request Form',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Submit your medicine request and review previous requests below.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),

              CustomTextField(
                label: 'Medicine Name',
                controller: medicineController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Quantity',
                controller: quantityController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Notes (Optional)',
                controller: notesController,
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              CustomButton(text: 'Submit Request', onPressed: submitRequest),

              const SizedBox(height: 30),
              const Text(
                'Recent Requests',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),

              ...requests.map((item) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.medicineName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Quantity: ${item.quantity}'),
                      Text('Requested Date: ${item.requestedDate}'),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: getStatusColor(item.status).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          item.status,
                          style: TextStyle(
                            color: getStatusColor(item.status),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
