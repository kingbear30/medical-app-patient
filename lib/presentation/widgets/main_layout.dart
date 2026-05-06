import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons_flutter.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/appointments/appointments_screen.dart';
import '../screens/results/results_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../../logic/cubits/citas/citas_cubit.dart';
import '../../core/theme/app_colors.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Cargamos los datos iniciales al entrar al layout principal
    context.read<CitasCubit>().cargarCitas();
  }

  final List<Widget> _screens = [
    const DashboardScreen(),
    const AppointmentsScreen(),
    const ResultsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryCobalt,
        unselectedItemColor: AppColors.textLight,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.calendar), label: 'Citas'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.fileText), label: 'Resultados'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: 'Perfil'),
        ],
      ),
    );
  }
}
