import 'package:flutter/material.dart';

class TcScreen extends StatelessWidget {
  const TcScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const tc = '''# Terms & Conditions
**Effective Date:** July 20, 2025  
**Application Name:** RoseateOS  
**Developer Entity:** Zakyasshii's Technologies (for branding purposes only; not a registered legal entity)  
**Supervised by:** Internal Legal Advisor, under compliance guidelines inspired by software governance best practices.

---

## 1. INTRODUCTION
Welcome to RoseateOS, a proprietary offline application created and maintained by Farish Aqasha, known by the developer alias Zakyasshii. This document outlines the legally binding terms and conditions ("Terms") that govern your access to and use of the application ("App", "Software", or "RoseateOS").

By installing, accessing, or using RoseateOS, you agree to comply with and be bound by these Terms. If you do not agree with these Terms, you must discontinue use of the App immediately.

---

## 2. DEFINITIONS
- **Developer:** Farish Aqasha, also operating under the personal brand name Zakyasshii Technologies.
- **User:** You, the individual installing or using the App.
- **App/Software:** RoseateOS in any form (APK, compiled package, installer, etc.), including all features, content, and intellectual assets.
- **Device:** Any smartphone, tablet, or compatible hardware on which the App is installed.

---

## 3. LICENSE GRANT
Subject to your full compliance with these Terms, the Developer hereby grants you a limited, non-exclusive, non-transferable, non-sublicensable, revocable license to use RoseateOS solely for personal, offline, and non-commercial purposes.

You may not:
- Reproduce, distribute, publicly display, or perform the Software or any part of it.
- Modify, reverse-engineer, decompile, or disassemble the Software or any component therein.
- Use the App in a manner that violates applicable laws, including data privacy laws or intellectual property rights.
- Resell, license, lease, or lend the Software to any third party.

---

## 4. INTELLECTUAL PROPERTY RIGHTS
All rights, titles, and interests in and to the App, including but not limited to source code, scripts, visual design, architecture, databases, UI/UX elements, feature systems, icons, and associated assets are exclusively owned by the Developer.

© 2025 Farish Aqasha (Zakyasshii Technologies). All rights reserved.

Unauthorized use of the Software, or copying its visual or functional identity, constitutes infringement and may result in legal action, including cease and desist orders, digital takedowns, or civil claims.

---

## 5. DATA USAGE & PRIVACY
RoseateOS is built with offline privacy as a core principle. The App:
- Does not transmit or collect user data remotely.
- Operates entirely without internet connection.
- Stores all information locally on your device only.
- Allows users to set PIN or fingerprint locks for encryption and security.

**Important Notice:** You, as the user, are solely responsible for protecting your own data through secure usage practices, password/PIN management, and performing regular encrypted backups.

---

## 6. SECURITY & ENCRYPTION
This App includes optional biometric/PIN protection and local data encryption. While these features are provided for user safety, the Developer does not guarantee absolute protection against device-level breaches, root/jailbreak environments, or third-party tampering.

If your device is lost, damaged, or compromised, your locally stored data may be at risk. The Developer is not liable for any loss, leak, or corruption of data resulting from user negligence, third-party access, or hardware failure.

---

## 7. LIMITATION OF LIABILITY
To the fullest extent permissible under applicable law:
- The App is provided on an "as-is" and "as-available" basis, without warranties of any kind.
- The Developer makes no representations or guarantees regarding uninterrupted functionality, absence of bugs, or fitness for a particular purpose.
- The Developer shall not be liable for any indirect, incidental, punitive, or consequential damages arising from the use or inability to use the App — including, but not limited to, data loss, productivity losses, device errors, or legal disputes resulting from improper use.

---

## 8. TERMINATION
The Developer reserves the right to terminate your license to use RoseateOS without prior notice if:
- You breach any clause of these Terms;
- You attempt to decompile, tamper with, or redistribute the App;
- You engage in unlawful use of the App that could harm the Developer’s reputation or breach intellectual rights.

Upon termination, you must immediately delete all copies of RoseateOS from your device and backups.

---

## 9. MODIFICATIONS & UPDATES
The Developer may, at their sole discretion, release updates to improve features or performance. However:
- There is no obligation to provide ongoing updates or customer support.
- Updates may alter, add, or remove certain features.
- It is your responsibility to back up your data before applying updates.
- Future versions may include optional integration with external services or tools. Any new features will be governed by updated Terms if applicable.

---

## 10. USER RESPONSIBILITIES
You agree to:
- Use RoseateOS ethically and only for its intended purposes.
- Maintain the security of your device and data.
- Not use the App for illegal, unethical, or harmful activities, including storing pirated content or distributing offensive materials.
- Not falsely present yourself as the developer or affiliate of Zakyasshii Technologies.

---

## 11. GOVERNING LAW
These Terms shall be governed by and construed in accordance with the laws of Malaysia, without regard to its conflict of law provisions.

Any legal disputes arising from these Terms shall be subject to the exclusive jurisdiction of the courts of Malaysia.

---

## 12. CONTACT & LEGAL INQUIRIES
For legal notices, support inquiries, or permissions requests, please contact:
- 📧 Email: zakyasshii@gmail.com
- 📱 Instagram (preferred): @zakyashii

---

## 13. ACCEPTANCE OF TERMS
By installing or using RoseateOS, you affirm that:
- You are at least 16 years old or have legal guardian permission.
- You have read, understood, and agreed to be bound by these Terms.
- You assume all responsibility for your use and your data.

If you do not agree to any part of these Terms, please uninstall and cease usage of RoseateOS immediately.''';

    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: const Text(tc, style: TextStyle(fontSize: 15)),
        ),
      ),
    );
  }
} 