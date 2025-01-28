import 'package:flutter/material.dart';
import 'package:meri_ride/credits.dart';
import 'package:meri_ride/driver.dart';

class MyDrawer extends StatelessWidget {
  final Driver driver;

  const MyDrawer({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              '${driver.firstName} ${driver.lastName}',
              style: textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              driver.phoneNumber,
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                '${driver.firstName[0]}${driver.lastName[0]}',
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
            text: 'MeriCredit',
            leadingIconData: Icons.credit_card_rounded,
            onTap: () {
              // Handle profile tap
              // Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreditsPage(driver: driver)),
              );
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
