class MockDoctor {
  final String name;
  final String specialization;
  final List<String> availableSlots;

  MockDoctor({
    required this.name,
    required this.specialization,
    required this.availableSlots,
  });
}

class MockAppointment {
  final String doctorName;
  final String date;
  final String time;
  final String status;
  final String queueNumber;
  final String reason;

  MockAppointment({
    required this.doctorName,
    required this.date,
    required this.time,
    required this.status,
    required this.queueNumber,
    required this.reason,
  });
}

class MockMedicineRequest {
  final String medicineName;
  final String quantity;
  final String status;
  final String requestedDate;

  MockMedicineRequest({
    required this.medicineName,
    required this.quantity,
    required this.status,
    required this.requestedDate,
  });
}

class MockData {
  static List<MockDoctor> doctors = [
    MockDoctor(
      name: 'Dr. Maria Santos',
      specialization: 'General Physician',
      availableSlots: ['8:00 AM', '9:00 AM', '10:30 AM', '1:00 PM'],
    ),
    MockDoctor(
      name: 'Dr. Jose Reyes',
      specialization: 'Family Medicine',
      availableSlots: ['8:30 AM', '11:00 AM', '2:00 PM', '3:30 PM'],
    ),
    MockDoctor(
      name: 'Dr. Angela Cruz',
      specialization: 'Community Health',
      availableSlots: ['9:30 AM', '10:00 AM', '1:30 PM', '4:00 PM'],
    ),
  ];

  static List<MockAppointment> appointments = [
    MockAppointment(
      doctorName: 'Dr. Maria Santos',
      date: 'March 15, 2026',
      time: '9:00 AM',
      status: 'Confirmed',
      queueNumber: 'A-001',
      reason: 'Fever and cough',
    ),
    MockAppointment(
      doctorName: 'Dr. Jose Reyes',
      date: 'March 18, 2026',
      time: '2:00 PM',
      status: 'Pending',
      queueNumber: 'A-007',
      reason: 'Follow-up checkup',
    ),
  ];

  static List<MockMedicineRequest> medicineRequests = [
    MockMedicineRequest(
      medicineName: 'Paracetamol',
      quantity: '10 tablets',
      status: 'Ready for Pickup',
      requestedDate: 'March 10, 2026',
    ),
    MockMedicineRequest(
      medicineName: 'Amoxicillin',
      quantity: '14 capsules',
      status: 'Pending Review',
      requestedDate: 'March 08, 2026',
    ),
  ];
}
