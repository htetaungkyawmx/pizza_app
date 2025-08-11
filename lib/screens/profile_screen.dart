import 'package:Naraon/screens/payments_screen.dart';
import 'package:Naraon/screens/terms_policies_screen.dart';
import 'package:Naraon/screens/vouchers_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'addresses_screen.dart';
import 'favourites_screen.dart';
import 'help_center_screen.dart';
import 'invite_friends_screen.dart';
import 'login_screen.dart';
import 'naraon_rewards_screen.dart';
import 'orders_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
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
              const Text(
                '박성운',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () {
                  // TODO: Add view profile action
                },
                child: const Text('View profile', style: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(height: 16),
              // Orders, Favourites, Payments, Addresses grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _ProfileTile(
                    icon: Icons.receipt_long,
                    label: 'Orders',
                    onTap: () => _navigateTo(context, const OrdersScreen()),
                  ),
                  _ProfileTile(
                    icon: Icons.favorite_border,
                    label: 'Favourites',
                    onTap: () => _navigateTo(context, const FavouritesScreen()),
                  ),
                  _ProfileTile(
                    icon: Icons.payment,
                    label: 'Payments',
                    onTap: () => _navigateTo(context, const PaymentsScreen()),
                  ),
                  _ProfileTile(
                    icon: Icons.location_on_outlined,
                    label: 'Addresses',
                    onTap: () => _navigateTo(context, const AddressesScreen()),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          const _SectionTitle(title: 'Perks for you'),
          _ListTileRow(
            icon: Icons.card_giftcard,
            label: 'Vouchers',
            onTap: () => _navigateTo(context, const VouchersScreen()),
          ),
          _ListTileRow(
            icon: Icons.emoji_events,
            label: 'Naraon rewards',
            onTap: () => _navigateTo(context, const NaraonRewardsScreen()),
          ),
          _ListTileRow(
            icon: Icons.group_add_outlined,
            label: 'Invite friends',
            onTap: () => _navigateTo(context, const InviteFriendsScreen()),
          ),
          const SizedBox(height: 24),
          const _SectionTitle(title: 'General'),
          _ListTileRow(
            icon: Icons.help_outline,
            label: 'Help center',
            onTap: () => _navigateTo(context, const HelpCenterScreen()),
          ),
          _ListTileRow(
            icon: Icons.policy_outlined,
            label: 'Terms & policies',
            onTap: () => _navigateTo(context, const TermsPoliciesScreen()),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            label: const Text(
              'Logout',
              style: TextStyle(color: Colors.redAccent),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.redAccent),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ProfileTile({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
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
  final VoidCallback? onTap;

  const _ListTileRow({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.grey.shade800),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
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