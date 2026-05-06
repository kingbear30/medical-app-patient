import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/appointment_card.dart';
import '../../widgets/quick_action_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate initial data fetch
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hola,',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
            Text('Juan Perez'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(LucideIcons.bell),
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            backgroundColor: AppColors.divider,
            child: Icon(LucideIcons.user, color: AppColors.primaryNavy),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() => _isLoading = true);
          await Future.delayed(const Duration(seconds: 1));
          setState(() => _isLoading = false);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _isLoading ? _buildHeroShimmer() : _buildHeroCard(),
              const SizedBox(height: 32),
              const Text(
                'Acciones Rapidas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryNavy,
                ),
              ),
              const SizedBox(height: 16),
              _buildQuickActionsGrid(),
              const SizedBox(height: 32),
              _buildRecentResultsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard() {
    return AppointmentCard(
      doctorName: 'Dr. Alejandro Sanchez',
      date: '15 de Mayo, 2026',
      time: '10:30 AM',
      onCancel: () {},
      onDetails: () {},
    );
  }

  Widget _buildHeroShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        QuickActionCard(
          title: 'Nueva Cita',
          icon: LucideIcons.calendarPlus,
          onTap: () {},
        ),
        QuickActionCard(
          title: 'Mis Resultados',
          icon: LucideIcons.fileText,
          onTap: () {},
        ),
        QuickActionCard(
          title: 'Directorio',
          icon: LucideIcons.search,
          onTap: () {},
        ),
        QuickActionCard(
          title: 'Perfil',
          icon: LucideIcons.user,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildRecentResultsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Resultados Recientes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavy,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Ver todos'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _isLoading ? _buildResultsShimmer() : _buildResultsList(),
      ],
    );
  }

  Widget _buildResultsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.successEmerald.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  LucideIcons.fileCheck,
                  color: AppColors.successEmerald,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Analisis de Sangre Completo',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      'Laboratorio Central - 02 May 2026',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(LucideIcons.chevronRight, color: AppColors.textLight),
            ],
          ),
        );
      },
    );
  }

  Widget _buildResultsShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
          2,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
