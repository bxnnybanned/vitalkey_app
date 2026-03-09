import 'package:flutter/material.dart';

void main() {
  runApp(const VitalKeyApp());
}

class VitalKeyApp extends StatelessWidget {
  const VitalKeyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VitalKey-iosk',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class PatientAccount {
  final String firstName;
  final String lastName;
  final String birthday;
  final String age;
  final String sex;
  final String mobileNumber;
  final String password;

  PatientAccount({
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.age,
    required this.sex,
    required this.mobileNumber,
    required this.password,
  });

  String get fullName => '$firstName $lastName';
}

class AppointmentRecord {
  final String doctorName;
  final String date;
  final String time;
  final String reason;
  final String queueNumber;
  final String status;

  AppointmentRecord({
    required this.doctorName,
    required this.date,
    required this.time,
    required this.reason,
    required this.queueNumber,
    required this.status,
  });
}

class MedicineRequestRecord {
  final String medicineName;
  final String quantity;
  final String notes;
  final String status;
  final String requestedDate;

  MedicineRequestRecord({
    required this.medicineName,
    required this.quantity,
    required this.notes,
    required this.status,
    required this.requestedDate,
  });
}

class MockAuthService {
  static final List<PatientAccount> registeredAccounts = [];
  static PatientAccount? currentUser;
  static final List<AppointmentRecord> appointments = [];
  static final List<MedicineRequestRecord> medicineRequests = [];

  static bool mobileAlreadyExists(String mobile) {
    return registeredAccounts.any(
      (account) => account.mobileNumber == mobile.trim(),
    );
  }

  static bool register(PatientAccount account) {
    if (mobileAlreadyExists(account.mobileNumber)) {
      return false;
    }
    registeredAccounts.add(account);
    return true;
  }

  static bool login(String mobile, String password) {
    try {
      final user = registeredAccounts.firstWhere(
        (account) =>
            account.mobileNumber == mobile.trim() &&
            account.password == password,
      );
      currentUser = user;
      return true;
    } catch (e) {
      return false;
    }
  }

  static void logout() {
    currentUser = null;
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.health_and_safety,
              size: 90,
              color: Colors.blue.shade700,
            ),
            const SizedBox(height: 20),
            const Text(
              'VitalKey-iosk',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Patient Mobile Application',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;

  InputDecoration customInputDecoration(String label, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFF8F9FB),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      suffixIcon: suffixIcon,
    );
  }

  void loginAccount() {
    final mobile = mobileController.text.trim();
    final password = passwordController.text;

    if (mobile.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter mobile number and password.'),
        ),
      );
      return;
    }

    final success = MockAuthService.login(mobile, password);

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid mobile number or password.')),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                'Welcome Back',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Login to access your appointments and health services.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                decoration: customInputDecoration('Mobile Number'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: customInputDecoration(
                  'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: loginAccount,
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text('Create Account'),
                ),
              ),
              const SizedBox(height: 20),
              if (MockAuthService.registeredAccounts.isEmpty)
                const Text(
                  'No registered local account yet.',
                  style: TextStyle(color: Colors.grey),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthdayController = TextEditingController();
  final ageController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? selectedSex;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  InputDecoration customInputDecoration(String label, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFF8F9FB),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      suffixIcon: suffixIcon,
    );
  }

  Future<void> pickBirthday() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final formatted =
          '${pickedDate.month}/${pickedDate.day}/${pickedDate.year}';

      final now = DateTime.now();
      int age = now.year - pickedDate.year;
      if (now.month < pickedDate.month ||
          (now.month == pickedDate.month && now.day < pickedDate.day)) {
        age--;
      }

      setState(() {
        birthdayController.text = formatted;
        ageController.text = age.toString();
      });
    }
  }

  void createAccount() {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final birthday = birthdayController.text.trim();
    final age = ageController.text.trim();
    final mobile = mobileController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        birthday.isEmpty ||
        age.isEmpty ||
        selectedSex == null ||
        mobile.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all required fields.')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password and confirm password do not match.'),
        ),
      );
      return;
    }

    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must be at least 8 characters.'),
        ),
      );
      return;
    }

    if (MockAuthService.mobileAlreadyExists(mobile)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mobile number is already registered.')),
      );
      return;
    }

    final account = PatientAccount(
      firstName: firstName,
      lastName: lastName,
      birthday: birthday,
      age: age,
      sex: selectedSex!,
      mobileNumber: mobile,
      password: password,
    );

    final success = MockAuthService.register(account);

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed. Try again.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account created successfully. You can now login.'),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

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
              const Text(
                'Register',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Create your patient account.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),

              TextField(
                controller: firstNameController,
                decoration: customInputDecoration('First Name'),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: lastNameController,
                decoration: customInputDecoration('Last Name'),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: birthdayController,
                readOnly: true,
                onTap: pickBirthday,
                decoration: customInputDecoration(
                  'Birthday',
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: ageController,
                readOnly: true,
                decoration: customInputDecoration('Age'),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: selectedSex,
                decoration: customInputDecoration('Sex'),
                items: const [
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedSex = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              TextField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                decoration: customInputDecoration('Mobile Number'),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: customInputDecoration(
                  'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: confirmPasswordController,
                obscureText: obscureConfirmPassword,
                decoration: customInputDecoration(
                  'Confirm Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureConfirmPassword = !obscureConfirmPassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: createAccount,
                  child: const Text('Create Account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget buildMenuCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Widget screen,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: Ink(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            boxShadow: const [
              BoxShadow(
                blurRadius: 8,
                offset: Offset(0, 4),
                color: Color(0x0A000000),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFF3F4F6),
                child: Icon(icon, color: Colors.blue),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = MockAuthService.currentUser;

    final menus = [
      {
        'title': 'Book Appointment',
        'icon': Icons.calendar_month,
        'screen': const BookAppointmentScreen(),
      },
      {
        'title': 'My Appointments',
        'icon': Icons.receipt_long,
        'screen': const MyAppointmentsScreen(),
      },
      {
        'title': 'Request Medicines',
        'icon': Icons.medication,
        'screen': const RequestMedicinesScreen(),
      },
      {
        'title': 'Doctor Availability',
        'icon': Icons.medical_services,
        'screen': const DoctorAvailabilityScreen(),
      },
      {
        'title': 'Profile',
        'icon': Icons.person,
        'screen': const ProfileScreen(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('VitalKey-iosk'),
        actions: [
          IconButton(
            onPressed: () {
              MockAuthService.logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good day, ${user?.firstName ?? 'Patient'}!',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              user == null
                  ? 'Manage your appointments and records easily.'
                  : 'Welcome, ${user.fullName}. Manage your appointments and records easily.',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FB),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Clinic Hours',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Monday to Friday • 8:00 AM to 5:00 PM',
                    style: TextStyle(color: Colors.grey),
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
                  childAspectRatio: 1.05,
                ),
                itemBuilder: (context, index) {
                  final item = menus[index];
                  return buildMenuCard(
                    context: context,
                    icon: item['icon'] as IconData,
                    title: item['title'] as String,
                    screen: item['screen'] as Widget,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final reasonController = TextEditingController();
  String? selectedDoctor;
  String? selectedTime;

  final List<String> doctors = ['Dr. Maria Santos', 'Dr. Jose Reyes'];

  final List<String> timeSlots = [
    '8:00 AM',
    '9:00 AM',
    '10:00 AM',
    '1:00 PM',
    '2:00 PM',
  ];

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

    final queueNumber = 'A-00${MockAuthService.appointments.length + 1}';

    MockAuthService.appointments.add(
      AppointmentRecord(
        doctorName: selectedDoctor!,
        date: 'March 15, 2026',
        time: selectedTime!,
        reason: reasonController.text.trim(),
        queueNumber: queueNumber,
        status: 'Pending',
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Appointment submitted. Queue Number: $queueNumber'),
      ),
    );

    setState(() {
      selectedDoctor = null;
      selectedTime = null;
      reasonController.clear();
    });
  }

  InputDecoration customInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFF8F9FB),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedDoctor,
              decoration: customInputDecoration('Select Doctor'),
              items: doctors
                  .map(
                    (doctor) =>
                        DropdownMenuItem(value: doctor, child: Text(doctor)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedDoctor = value;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedTime,
              decoration: customInputDecoration('Select Time'),
              items: timeSlots
                  .map(
                    (time) => DropdownMenuItem(value: time, child: Text(time)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedTime = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              maxLines: 4,
              decoration: customInputDecoration('Reason for Visit'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: submitAppointment,
                child: const Text('Submit Appointment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    final appointments = MockAuthService.appointments.reversed.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('My Appointments')),
      body: appointments.isEmpty
          ? const Center(child: Text('No appointments yet.'))
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final item = appointments[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.doctorName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Date: ${item.date}'),
                      Text('Time: ${item.time}'),
                      Text('Reason: ${item.reason}'),
                      Text('Queue Number: ${item.queueNumber}'),
                      const SizedBox(height: 10),
                      Text(
                        item.status,
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class RequestMedicinesScreen extends StatefulWidget {
  const RequestMedicinesScreen({super.key});

  @override
  State<RequestMedicinesScreen> createState() => _RequestMedicinesScreenState();
}

class _RequestMedicinesScreenState extends State<RequestMedicinesScreen> {
  final medicineController = TextEditingController();
  final quantityController = TextEditingController();
  final notesController = TextEditingController();

  InputDecoration customInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFF8F9FB),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

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

    MockAuthService.medicineRequests.add(
      MedicineRequestRecord(
        medicineName: medicineController.text.trim(),
        quantity: quantityController.text.trim(),
        notes: notesController.text.trim(),
        status: 'Pending Review',
        requestedDate: 'March 15, 2026',
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Medicine request submitted.')),
    );

    setState(() {
      medicineController.clear();
      quantityController.clear();
      notesController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final requests = MockAuthService.medicineRequests.reversed.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Request Medicines')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: medicineController,
              decoration: customInputDecoration('Medicine Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: customInputDecoration('Quantity'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              maxLines: 3,
              decoration: customInputDecoration('Notes (Optional)'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: submitRequest,
                child: const Text('Submit Request'),
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Requests',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            if (requests.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('No medicine requests yet.'),
              ),
            ...requests.map(
              (item) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.medicineName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Quantity: ${item.quantity}'),
                    Text('Requested Date: ${item.requestedDate}'),
                    if (item.notes.isNotEmpty) Text('Notes: ${item.notes}'),
                    const SizedBox(height: 10),
                    const Text(
                      'Pending Review',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorAvailabilityScreen extends StatelessWidget {
  const DoctorAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Availability')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. Maria Santos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text('General Physician'),
                SizedBox(height: 8),
                Text('Available: 8:00 AM, 9:00 AM, 10:00 AM'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. Jose Reyes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text('Family Medicine'),
                SizedBox(height: 8),
                Text('Available: 1:00 PM, 2:00 PM, 3:00 PM'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget buildInfo(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                MockAuthService.logout();
                Navigator.pop(dialogContext);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = MockAuthService.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: user == null
          ? const Center(child: Text('No user logged in.'))
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 36,
                        backgroundColor: Color(0xFFF3F4F6),
                        child: Icon(Icons.person, size: 36, color: Colors.blue),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Patient ID: VK-${user.mobileNumber.substring(user.mobileNumber.length - 4)}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                buildInfo('Full Name', user.fullName),
                buildInfo('Mobile Number', user.mobileNumber),
                buildInfo('Birthday', user.birthday),
                buildInfo('Age', user.age),
                buildInfo('Sex', user.sex),
                buildInfo(
                  'Patient ID',
                  'VK-${user.mobileNumber.substring(user.mobileNumber.length - 4)}',
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      showLogoutDialog(context);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                  ),
                ),
              ],
            ),
    );
  }
}
