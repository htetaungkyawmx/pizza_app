import 'package:flutter/material.dart';
import 'login_screen.dart'; // Make sure this path is correct

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false, // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('박성운', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () {},
                child: const Text('View profile', style: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(height: 16),
              // Orders, Favourites, Payments, Addresses
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  _ProfileTile(icon: Icons.receipt_long, label: 'Orders'),
                  _ProfileTile(icon: Icons.favorite_border, label: 'Favourites'),
                  _ProfileTile(icon: Icons.payment, label: 'Payments'),
                  _ProfileTile(icon: Icons.location_on_outlined, label: 'Addresses'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          const _SectionTitle(title: 'Perks for you'),
          const _ListTileRow(icon: Icons.card_giftcard, label: 'Vouchers'),
          const _ListTileRow(icon: Icons.emoji_events, label: 'Naraon rewards'),
          const _ListTileRow(icon: Icons.group_add_outlined, label: 'Invite friends'),
          const SizedBox(height: 24),
          const _SectionTitle(title: 'General'),
          const _ListTileRow(icon: Icons.help_outline, label: 'Help center'),
          const _ListTileRow(icon: Icons.policy_outlined, label: 'Terms & policies'),

          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.shade100,
              foregroundColor: Colors.white.shade800,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}

extension on Color {
  get shade100 => null;

  get shade800 => null;
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ProfileTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: Colors.grey.shade800),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListTileRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ListTileRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.grey.shade800),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
