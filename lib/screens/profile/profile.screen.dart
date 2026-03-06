import 'package:fb_test2/screens/home/home.screen.dart';
import 'package:fb_test2/services/user/user.service.dart';
import 'package:fb_test2/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile';
  static Function(BuildContext context) push = (context) =>
      context.push(routeName);
  static Function(BuildContext context) go = (context) => context.go(routeName);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  String? _selectedGender;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = UserState.of(context).user;
      nameController.text = user?.name ?? '';
      final gender = user?.gender ?? '';
      setState(() => _selectedGender = gender.isNotEmpty ? gender : null);
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final id = UserState.of(context).user?.id;
      if (id == null) return;

      final updatedUser = await UserService.instance.updateUser(
        id: id,
        name: nameController.text.trim(),
        gender: _selectedGender ?? '',
      );

      if (context.mounted) {
        UserState.of(context).setUser(updatedUser);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Profile Updated")));
        HomeScreen.go(context);
      }
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  initialValue: _selectedGender,
                  decoration: const InputDecoration(labelText: "Gender"),
                  items: const [
                    DropdownMenuItem(value: 'male', child: Text("Male")),
                    DropdownMenuItem(value: 'female', child: Text("Female")),
                  ],
                  onChanged: (value) => setState(() => _selectedGender = value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Gender is required";
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : () => _onSubmit(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Submit"),
                      if (_isLoading) ...[
                        const SizedBox(width: 8),
                        const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
