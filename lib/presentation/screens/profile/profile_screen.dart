import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../logic/cubits/auth/auth_cubit.dart';
import '../../../logic/cubits/auth/auth_state.dart';
import '../../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is! AuthAuthenticated) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final paciente = state.paciente;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Mi Perfil Clinico'),
            actions: [
              IconButton(
                onPressed: () => context.read<AuthCubit>().logout(),
                icon: const Icon(LucideIcons.logOut, color: Colors.red),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.primaryCobalt,
                  child: Icon(LucideIcons.user, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  '${paciente.nombre} ${paciente.apellidos}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryNavy),
                ),
                Text(
                  paciente.cedula,
                  style: const TextStyle(color: AppColors.textLight),
                ),
                const SizedBox(height: 32),
                _buildInfoCard('Informacion del Seguro', [
                  _buildInfoRow('ARS', paciente.arsNombre ?? 'No especificado'),
                  _buildInfoRow('No. Afiliado', paciente.numeroAfiliado ?? 'N/A'),
                ]),
                const SizedBox(height: 16),
                _buildInfoCard('Contacto', [
                  _buildInfoRow('Telefono', paciente.telefono ?? 'No registrado'),
                ]),
                const SizedBox(height: 32),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.edit2),
                  label: const Text('Editar Datos Personales'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryCobalt)),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textLight)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
