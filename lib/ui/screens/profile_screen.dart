import 'package:flutter/material.dart';
import 'package:task_manager/ui/auth_controller/auth_controller.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _setUserData();
  }

  void _setUserData() {
    _emailTEController.text = AuthController.userData?.email ?? '';
    _firstNameTEController.text = AuthController.userData?.firstName ?? '';
    _lastNameTEController.text = AuthController.userData?.lastName ?? '';
    _phoneTEController.text = AuthController.userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(
        isProfileOpened: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Text(
                    'Update Profile',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildPhotoPicker(),
                const SizedBox(height: 8),
                TextFormField(
                  enabled: false,
                  controller: _emailTEController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _firstNameTEController,
                  decoration: const InputDecoration(
                    hintText: 'First name',
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _lastNameTEController,
                  decoration: const InputDecoration(
                    hintText: 'Last name',
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneTEController,
                  decoration: const InputDecoration(
                    hintText: 'Phone',
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordTEController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {}
                  },
                  child: const Icon(
                    Icons.arrow_circle_right_outlined,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPicker() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 100,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
              color: Colors.grey,
            ),
            child: const Text(
              'Photo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          const Text('Selected photo')
        ],
      ),
    );
  }
}
