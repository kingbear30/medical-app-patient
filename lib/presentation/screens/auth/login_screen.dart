import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../logic/cubits/auth/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(LucideIcons.shieldCheck, color: AppColors.primaryCobalt, size: 48),
              const SizedBox(height: 32),
              const Text(
                'Bienvenido,',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primaryNavy),
              ),
              const Text(
                'Inicia sesion para gestionar tu salud.',
                style: TextStyle(fontSize: 16, color: AppColors.textLight),
              ),
              const SizedBox(height: 48),
              _buildTextField(
                label: 'Correo Electronico',
                hint: 'ejemplo@correo.com',
                icon: LucideIcons.mail,
                controller: _emailController,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Contraseña',
                hint: '********',
                icon: LucideIcons.lock,
                isPassword: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('¿Olvidaste tu contraseña?'),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().login(
                      _emailController.text,
                      _passwordController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryCobalt,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Iniciar Sesion', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿No tienes cuenta?'),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Registrate aqui', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Center(
                child: Column(
                  children: [
                    Icon(LucideIcons.fingerprint, color: AppColors.textLight, size: 40),
                    SizedBox(height: 8),
                    Text('Usar autenticacion biometrica', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword && _obscurePassword,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20, color: AppColors.textLight),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(_obscurePassword ? LucideIcons.eyeOff : LucideIcons.eye, size: 20),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
          ),
        ),
      ],
    );
  }
}
