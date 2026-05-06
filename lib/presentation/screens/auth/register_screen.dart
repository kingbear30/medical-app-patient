import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Paciente'),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Crea tu cuenta medica',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryNavy),
            ),
            const Text(
              'Completa tus datos para empezar.',
              style: TextStyle(fontSize: 14, color: AppColors.textLight),
            ),
            const SizedBox(height: 32),
            _buildFieldGroup('Datos Personales', [
              _buildInput('Nombre', LucideIcons.user),
              _buildInput('Apellidos', LucideIcons.user),
              _buildInput('Cedula', LucideIcons.idCard),
              _buildInput('Telefono', LucideIcons.phone),
            ]),
            const SizedBox(height: 24),
            _buildFieldGroup('Seguro Medico', [
              _buildInput('ARS (Seguro)', LucideIcons.shield),
              _buildInput('Numero de Afiliado', LucideIcons.hash),
            ]),
            const SizedBox(height: 24),
            _buildFieldGroup('Seguridad', [
              _buildInput('Correo Electronico', LucideIcons.mail),
              _buildInput('Contraseña', LucideIcons.lock, isPassword: true),
            ]),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryCobalt,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Finalizar Registro', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldGroup(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryCobalt, letterSpacing: 1.2),
        ),
        const SizedBox(height: 16),
        ...children.expand((w) => [w, const SizedBox(height: 16)]),
      ],
    );
  }

  Widget _buildInput(String label, IconData icon, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 18),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
      ),
    );
  }
}
