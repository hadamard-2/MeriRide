import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'Lemma Derese',
              style: textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              '+251 98 765 4321',
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'LD',
                style: textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_rounded),
            title: Text('Profile', style: textTheme.bodyLarge),
            onTap: () {
              // Handle profile tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.history_rounded),
            title: Text('History', style: textTheme.bodyLarge),
            onTap: () {
              // Handle history tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.attach_money_rounded),
            title: Text('Earnings', style: textTheme.bodyLarge),
            onTap: () {
              // Handle earnings tap
              Navigator.pop(context);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Divider(height: 1),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_rounded),
            title: Text('Privacy Policy', style: textTheme.bodyLarge),
            onTap: () {
              // Handle privacy policy tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback_rounded),
            title: Text('Feedback', style: textTheme.bodyLarge),
            onTap: () {
              // Handle feedback tap
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
