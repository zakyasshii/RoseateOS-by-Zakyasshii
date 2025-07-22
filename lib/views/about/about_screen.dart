import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const aboutUs = '''# About Us

## Developer & Vision
**Farish Aqasha** (known online as **Zakyasshii**) is the visionary creator and sole maintainer of RoseateOS. With a background in Computer Science and a passion for intuitive, aesthetic software, Farish has dedicated his career to exploring the intersection of user experience, productivity, and digital design. Zakyasshii Technologies is his personal brand, representing a commitment to creative independence and empowering technology.

## About RoseateOS
RoseateOS is a self-contained, offline productivity and personal management app developed by Zakyasshii Technologies. It elegantly combines planning, tracking, journaling, goal-setting, and personal archives into one seamless, seasonally dynamic, and visually immersive ecosystem.

Originally crafted for personal use, RoseateOS was designed to give Farish complete control over his digital life. Recognizing its broader value, he has refined and shared it for public or limited distribution, while maintaining its core principles of privacy, offline operation, and visual elegance.

## Copyright & Ownership
All content, source code, design, and features of RoseateOS are © 2025 by Zakyasshii Technologies. All rights reserved. Zakyasshii Technologies is a developer alias and branding name; all legal rights and responsibilities belong solely to Farish Aqasha, the sole creator and copyright holder.

## Contact
For inquiries or feedback:
- 📧 Email: zakyasshii@gmail.com
- 📱 Instagram: [@zakyashii](https://instagram.com/zakyashii) (Recommended)
''';

    const copyright = '''Copyright © 2025 Farish Aqasha (Zakyasshii Technologies)
All rights reserved.

RoseateOS and all associated source code, design, features, and content are the exclusive intellectual property of Farish Aqasha, also known as Zakyasshii, under the developer alias Zakyasshii Technologies.

Zakyasshii Technologies is a personal developer brand and not a registered legal entity. All legal rights, responsibilities, and claims belong solely to Farish Aqasha.

Unauthorized reproduction, distribution, or use of any part of RoseateOS is strictly prohibited and may result in legal action.''';

    return Scaffold(
      appBar: AppBar(title: const Text('About RoseateOS')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(aboutUs, style: TextStyle(fontSize: 15)),
              SizedBox(height: 24),
              Text('Copyright', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 8),
              Text(copyright, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
} 