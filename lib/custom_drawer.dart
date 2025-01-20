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
          MyListTile(
            textTheme: textTheme,
            text: 'Profile',
            leadingIconData: Icons.person_rounded,
            onTap: () {
              // Handle profile tap
              Navigator.pop(context);
            },
          ),
          MyListTile(
            textTheme: textTheme,
            text: 'History',
            leadingIconData: Icons.history_rounded,
            onTap: () {
              // Handle history tap
              Navigator.pop(context);
            },
          ),
          MyListTile(
            textTheme: textTheme,
            text: 'Earnings',
            leadingIconData: Icons.attach_money_rounded,
            onTap: () {
              // Handle profile tap
              Navigator.pop(context);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Divider(height: 1),
          ),
          MyListTile(
            textTheme: textTheme,
            text: 'Privacy Policy',
            leadingIconData: Icons.privacy_tip_rounded,
            onTap: () {
              // Handle privacy policy tap
              Navigator.pop(context);
            },
          ),
          MyListTile(
            textTheme: textTheme,
            text: 'Feedback',
            leadingIconData: Icons.feedback_rounded,
            onTap: () {
              // Handle profile tap
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class MyListTile extends StatelessWidget {
  const MyListTile({
    super.key,
    required this.textTheme,
    required this.text,
    required this.leadingIconData,
    required this.onTap,
  });

  final TextTheme textTheme;
  final String text;
  final IconData leadingIconData;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      leading: Icon(leadingIconData, size: 24),
      title: Text(text, style: textTheme.bodyLarge),
      onTap: onTap,
    );
  }
}
