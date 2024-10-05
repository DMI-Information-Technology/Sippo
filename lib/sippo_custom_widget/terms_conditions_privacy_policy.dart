import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  const PrivacyPolicyWidget({super.key});

  static const typesOfUserData = [
    'Name',
    'Phone Number',
    'Email address',
    'Location (area)',
    'Abilities(Optional)',
    'Skills (optional)',
    'Occupation and past occupations (optional)',
    'Languages and language levels (optional)',
    'Gender (optional)',
    'Profile picture (optional)',
    'Nationality (optional)',
    'CV (optional)',
    'Past Projects(Optional)',
  ];
  static const typesOfCompanyData = [
    'Name',
    'Email address',
    'Headquarters location',
    'Other company locations(optional)',
    'Images of the company(optional)',
    'Description(optional)',
    'Company fields',
    'Website (optional)'
  ];
  static const purposeDataCollection = [
    'To match users with potential employers',
    'To send job notifications and recommendations',
    'To personalize the app experience',
    "To improve the app's functionality",
    'To communicate with users and companies',
    'To provide customer support'
  ];
  static const userControl = [
    'You can edit or delete your profile information at any time.',
    'You can deactivate your account to remove your data from the App.',
    'You can opt out of receiving job notifications and recommendations.',
    "You can contact us to request access to or deletion of your data.",
  ];
  static const additionNotes = [
    'Sippo does not collect any sensitive data.',
    'Sippo does not target children.',
    "This Privacy Policy is accessible within the App's Settings.",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('1. Introduction'),
                  subtitle: Text(
                    'A3mal Al Mustaqbal ("we" or "us") is committed to protecting your privacy.'
                    ' This Privacy Policy explains how we collect, use,'
                    ' and share your personal data when you use the Sippo mobile application ("App").',
                  ),
                ),
                ListTile(
                  title: Text('2. Types of Data Collected'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'We collect the following types of data from you:\nUser Data:',
                      ),
                      ...typesOfUserData.map((e) => _TextItemList(e)),
                      Text(
                        'Company Data:',
                      ),
                      ...typesOfCompanyData.map((e) => _TextItemList(e)),
                    ],
                  ),
                ),
                ListTile(
                  title: Text('3. Purpose of Data Collection'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'We use your data for the following purposes:',
                      ),
                      ...purposeDataCollection.map((e) => _TextItemList(e)),
                      Text(
                        'We do not share any personal data with third parties for advertising or marketing purposes. '
                        'We may share limited user data with third-party service providers who assist us in operating the App,'
                        ' such as cloud storage providers and analytics platforms. '
                        'These service providers are contractually obligated to protect your data and only use it for authorized purposes.',
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text('4. User Control'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'You have the following control over your data:',
                      ),
                      ...userControl.map((e) => _TextItemList(e)),
                    ],
                  ),
                ),
                ListTile(
                  title: Text('5. Data Security'),
                  subtitle: Text(
                    'We take security measures to protect your data from unauthorized access,'
                    ' disclosure, alteration, or destruction. These measures include encryption,'
                    ' access controls, and security audits.',
                  ),
                ),
                ListTile(
                  title: Text('6. Data Retention'),
                  subtitle: Text(
                    'We retain your data for as long as necessary to provide the services'
                    ' of the App and to comply with legal requirements. You can request '
                    'deletion of your data at any time.',
                  ),
                ),
                ListTile(
                  title: Text('7. Privacy Policy Changes'),
                  subtitle: Text(
                    'We may update this Privacy Policy from time to time. We will notify you of any material changes by posting the updated Privacy Policy on the App.',
                  ),
                ),
                ListTile(
                  title: Text('8. Contact Us'),
                  subtitle: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text:
                            'If you have any questions about this Privacy Policy,'
                            ' please contact us at ',
                      ),
                      WidgetSpan(
                        child: Text(
                          'info@sippo.ly.',
                          style: dmsregular.copyWith(color: Colors.blueAccent),
                        ),
                      )
                    ]),
                  ),
                ),
                ListTile(
                  title: Text('10. Additional Notes'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:
                        additionNotes.map((e) => _TextItemList(e)).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomButton(
          onTapped: () {
            Navigator.pop(context);
          },
          text: 'ok'.tr,
        )
      ],
    );
  }
}

class TermsConditionsWidget extends StatelessWidget {
  const TermsConditionsWidget({super.key});

  static const definitions = [
    'App: Refers to the Sippo mobile application.',
    'Company: A3mal Al Mustaqbal, the owners of the Sippo app.',
    'Email address',
    'User: Any individual who downloads and uses the Sippo app.',
    'Content: All information, text, images, videos, or other materials uploaded or posted on Sippo.',
  ];
  static const userConduct = [
    'Post any illegal, harmful, offensive, or misleading content.',
    "Misuse Sippo's features or engage in any activity that disrupts the app's functionality.",
    'Share personal information of others without their consent.',
    'Violate any applicable laws or regulations.',
  ];
  static const additionalTerms = [
    'User profiles are visible to companies for the purpose of job matching.',
    'Users can control the visibility of their profile information.',
    'Private user data will never be shared with companies.',
    "Content is monitored and inappropriate content may be removed.",
    'Sippo uses Google Maps API to obtain user location data.',
    'Sippo is a free app and will not charge users for its services.'
  ];
  static const userControl = [
    'You can edit or delete your profile information at any time.',
    'You can deactivate your account to remove your data from the App.',
    'You can opt out of receiving job notifications and recommendations.',
    "You can contact us to request access to or deletion of your data.",
  ];
  static const additionNotes = [
    'Sippo does not collect any sensitive data.',
    'Sippo does not target children.',
    "This Privacy Policy is accessible within the App's Settings.",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('1. Introduction'),
                  subtitle: Text(
                    'Welcome to Sippo, a job portal designed to connect job seekers with employers in Libya.'
                    ' These Terms and Conditions govern your use of the Sippo app and its related services.'
                    ' By using Sippo, you agree to these terms.',
                  ),
                ),
                ListTile(
                  title: Text('2. Definitions'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: definitions.map((e) => _TextItemList(e)).toList(),
                  ),
                ),
                ListTile(
                  title: Text('3. Grant of License'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'YThe Company grants you a non-exclusive,'
                        ' non-transferable license to use the Sippo app for personal,'
                        ' non-commercial purposes.',
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text('4. User Conduct'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'You agree to use Sippo in a responsible and lawful manner. You may not:',
                      ),
                      ...userConduct.map((e) => _TextItemList(e)),
                    ],
                  ),
                ),
                ListTile(
                  title: Text('5. Data Security'),
                  subtitle: Text(
                    'We take security measures to protect your data from unauthorized access,'
                    ' disclosure, alteration, or destruction. These measures include encryption,'
                    ' access controls, and security audits.',
                  ),
                ),
                ListTile(
                  title: Text('6. Intellectual Property'),
                  subtitle: Text(
                    'All intellectual property rights in the Sippo app and its content are owned by the Company or its licensors.'
                    ' You may not copy, reproduce, distribute, or modify any content without express permission.',
                  ),
                ),
                ListTile(
                  title: Text('7. Data Privacy'),
                  subtitle: Text(
                    'The Company collects and uses certain user data to provide the services of Sippo.'
                    ' Please refer to our Privacy Policy for detailed information on our data practices.',
                  ),
                ),
                ListTile(
                  title: Text('8. Third-Party Services'),
                  subtitle: Text(
                    'Sippo may use third-party services,'
                    ' such as Google Maps API, to provide certain features.'
                    ' You acknowledge that these third-party services may have their own'
                    ' terms and conditions and privacy policies.',
                  ),
                ),
                ListTile(
                  title: Text('9. Disclaimers and Limitations of Liability'),
                  subtitle: Text(
                    'The Sippo app is provided "as-is" with no warranties.'
                    ' The Company is not liable for any damages arising from your use of the app.',
                  ),
                ),
                ListTile(
                  title: Text('10. Termination'),
                  subtitle: Text(
                    'You may terminate your use of Sippo at any time.'
                    ' The Company may terminate your access for violations of these terms.',
                  ),
                ),
                ListTile(
                  title: Text('11. Updates and Modifications'),
                  subtitle: Text(
                    'The Company reserves the right to update or modify these terms and the Sippo app without prior notice.',
                  ),
                ),
                ListTile(
                  title: Text('12. Governing Law and Dispute Resolution'),
                  subtitle: Text(
                    'These terms are governed by the laws of Libya.'
                    ' Any disputes arising from these terms will be resolved in the courts of Tripoli, Libya.',
                  ),
                ),
                ListTile(
                  title: Text('13. Additional Terms'),
                  subtitle: Column(
                    children:
                        additionalTerms.map((e) => _TextItemList(e)).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomButton(
          onTapped: () {
            Navigator.pop(context);
          },
          text: 'ok'.tr,
        )
      ],
    );
  }
}

class _TextItemList extends StatelessWidget {
  const _TextItemList(
    this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.drawer,
      minVerticalPadding: 0.0,
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0.0,
      titleAlignment: ListTileTitleAlignment.center,
      visualDensity: VisualDensity(vertical: VisualDensity.minimumDensity),
      minLeadingWidth: 24,
      leading: Icon(
        Icons.circle,
        size: 8,
        color: Colors.black,
      ),
      title: Text(text),
    );
  }
}
