import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  final String referralCode = 'NARAONKR11:11';
  final String phoneNumber = '+959445265001';

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invite Friends')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Refer your friends and earn rewards!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Share your referral code and get discounts & free food.\n\n'
                  'Referral Code: ',
              style: TextStyle(fontSize: 16),
            ),
            SelectableText(
              referralCode,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrange),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _makePhoneCall('tel:$phoneNumber'),
              icon: const Icon(Icons.call),
              label: const Text('Call Support for Referral Help'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                final message = 'Join me on Naraon app! Use my referral code $referralCode to get free food!';
                // You could integrate share plugin or show copy option here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Referral message copied to clipboard')),
                );
              },
              icon: const Icon(Icons.share),
              label: const Text('Share Referral Code'),
            ),
          ],
        ),
      ),
    );
  }
}
