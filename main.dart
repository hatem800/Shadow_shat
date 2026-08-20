import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';
// متغير عام يتحكم في حالة حركة الحوت في كل التطبيق
final ValueNotifier<bool> whaleMotionNotifier = ValueNotifier<bool>(true);

// متغير عام يتحكم في تفعيل أو إيقاف صوت الحوت من الإعدادات
final ValueNotifier<bool> whaleSoundNotifier = ValueNotifier<bool>(true);

// متغير عام يتحكم في التشفير التلقائي للرسائل
final ValueNotifier<bool> autoEncryptNotifier = ValueNotifier<bool>(false);

// متغير عام خاص بالكود المتغير للغرفة السرية
final ValueNotifier<String> secretRoomCodeNotifier = ValueNotifier<String>("SHADOW-999");

void main() {
  runApp(const ShadowChatApp());
}

class ShadowChatApp extends StatelessWidget {
  const ShadowChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const ChatListScreen(),
    );
  }
}

// ==========================================
// 1. القائمة الرئيسية
// ==========================================
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> names = [
      "✨ 🌑 SHADOW CHAT 🌑 ✨",
      "Meta AI",
      "Soltan 🤙",
      "Kazdora 🌯🍟",
      "Boks",
    ];

    final List<String> lastMessages = [
      "أهلاً بك في نظام shadow chat",
      "تمام 🔥 الشفرات جاهزة...",
      "لو تعرف تكلمني...",
      "Hamody: من يومين",
      "Kickboxing class: Tuesday",
    ];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/magic_bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.black.withOpacity(0.6),
              centerTitle: true,
              title: const Text(
                "✨ 🌑 SHADOW CHAT 🌑 ✨",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: Color(0xFF00FF66)),
                  tooltip: 'بحث',
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white70),
                  tooltip: 'الإعدادات',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundColor: const Color(0xFF00FF66).withOpacity(0.2),
                    child: Text(
                      names[index][0],
                      style: const TextStyle(
                        color: Color(0xFF00FF66),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    names[index],
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    lastMessages[index],
                    style: const TextStyle(color: Colors.white70),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Text(
                    "أمس",
                    style: TextStyle(color: Color(0xFF00FF66), fontSize: 12),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatScreen(),
                      ),
                    );
                  },
                );
              },
            ),
            floatingActionButton: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00FF66).withOpacity(0.6),
                    blurRadius: 18,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: PopupMenuButton<String>(
                color: Colors.grey[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0xFF00FF66), width: 1),
                ),
                offset: const Offset(0, -180),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'status',
                    child: Row(
                      children: [
                        Icon(Icons.amp_stories, color: Color(0xFF00FF66)),
                        SizedBox(width: 10),
                        Text('خيارات الحالة', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'security',
                    child: Row(
                      children: [
                        Icon(Icons.security, color: Colors.cyanAccent),
                        SizedBox(width: 10),
                        Text('تأمين الدردشة', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'secret_room',
                    child: Row(
                      children: [
                        Icon(Icons.vpn_key, color: Colors.amberAccent),
                        SizedBox(width: 10),
                        Text('الغرفة السرية (Password)', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'ghost',
                    child: Row(
                      children: [
                        Icon(Icons.visibility_off, color: Colors.purpleAccent),
                        SizedBox(width: 10),
                        Text('الوضع الخفي', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
                onSelected: (String result) {
                  if (result == 'status') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم فتح خيارات الحالة ✨')),
                    );
                  } else if (result == 'security') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تفعيل تأمين الدردشة 🛡️')),
                    );
                  } else if (result == 'secret_room') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SecretRoomScreen(),
                      ),
                    );
                  } else if (result == 'ghost') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SecretChatScreen(),
                      ),
                    );
                  }
                },
                child: FloatingActionButton(
                  onPressed: null,
                  backgroundColor: Colors.black,
                  elevation: 0,
                  highlightElevation: 0,
                  shape: const CircleBorder(
                    side: BorderSide(color: Color(0xFF00FF66), width: 2),
                  ),
                  child: const Icon(
                    Icons.fingerprint,
                    color: Color(0xFF00FF66),
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// ==========================================
// 2. شاشة الغرفة السرية
// ==========================================
class SecretRoomScreen extends StatefulWidget {
  const SecretRoomScreen({super.key});

  @override
  State<SecretRoomScreen> createState() => _SecretRoomScreenState();
}

class _SecretRoomScreenState extends State<SecretRoomScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _codeController = TextEditingController();
  bool _isUnlocked = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            '🔐 الغرفة السرية المحصنة',
            style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          backgroundColor: Colors.black87,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.amberAccent),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Colors.grey[900]!,
                Colors.black,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: _isUnlocked ? _buildSecretWorkspace() : _buildCodeEntryView(),
          ),
        ),
      ),
    );
  }

  Widget _buildCodeEntryView() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _pulseAnimation,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.amberAccent.withOpacity(0.5), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amberAccent.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(Icons.fingerprint, size: 70, color: Colors.amberAccent),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'منطقة مقيدة أمنياً',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'أدخل الكود المتغير الحالي للوصول إلى محتوى الغرفة السرية',
              style: TextStyle(color: Colors.white54, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<String>(
              valueListenable: secretRoomCodeNotifier,
              builder: (context, currentCode, child) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF00FF66).withOpacity(0.3)),
                  ),
                  child: Text(
                    'الكود النشط حالياً: $currentCode',
                    style: const TextStyle(color: Color(0xFF00FF66), fontSize: 12, fontFamily: 'monospace'),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _codeController,
              style: const TextStyle(color: Colors.white, letterSpacing: 2),
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: '••••••••',
                hintStyle: const TextStyle(color: Colors.white24),
                filled: true,
                fillColor: Colors.grey[900],
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.amberAccent, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF00FF66), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 5,
                ),
                icon: const Icon(Icons.lock_open, color: Colors.black),
                label: const Text('فك التشفير والدخول', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                onPressed: () {
                  if (_codeController.text.trim() == secretRoomCodeNotifier.value) {
                    setState(() {
                      _isUnlocked = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم فتح الغرفة السرية بنجاح 🚀')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('الكود خطأ! ❌ برجاء مراجعة الكود المتغير')),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecretWorkspace() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.amberAccent.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.amberAccent, width: 1),
          ),
          child: Row(
            children: [
              const Icon(Icons.security, color: Colors.amberAccent, size: 36),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'أنت الآن في النطاق الآمن',
                      style: TextStyle(color: Colors.amberAccent, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'البيانات هنا مشفرة كلياً ولا تظهر في السجل الرئيسي للتطبيق.',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'إدارة إعدادات الغرفة:',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder<String>(
          valueListenable: secretRoomCodeNotifier,
          builder: (context, code, child) {
            return ListTile(
              tileColor: Colors.grey[900],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              leading: const Icon(Icons.code, color: Color(0xFF00FF66)),
              title: const Text('تغيير الكود المتغير', style: TextStyle(color: Colors.white, fontSize: 14)),
              subtitle: Text('الكود الحالي: $code', style: const TextStyle(color: Colors.white54, fontSize: 12)),
              trailing: const Icon(Icons.edit, color: Colors.amberAccent),
              onTap: () => _changeSecretCode(context),
            );
          },
        ),
        const SizedBox(height: 15),
        const Text(
          'المحادثات المخفية داخل الغرفة:',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                tileColor: Colors.grey[900]?.withOpacity(0.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                leading: const CircleAvatar(
                  backgroundColor: Colors.amberAccent,
                  child: Icon(Icons.vpn_key, color: Colors.black),
                ),
                title: const Text('المجموعة السوداء (Shadow Ops)', style: TextStyle(color: Colors.white)),
                subtitle: const Text('آخر رسالة: تم تأمين التردد بنجاح...', style: TextStyle(color: Colors.white54, fontSize: 12)),
                trailing: const Icon(Icons.lock, color: Color(0xFF00FF66), size: 18),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SecretChatScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _changeSecretCode(BuildContext context) {
    final TextEditingController newCodeController = TextEditingController(text: secretRoomCodeNotifier.value);
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Text('تحديث الكود المتغير', style: TextStyle(color: Colors.amberAccent)),
            content: TextField(
              controller: newCodeController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'أدخل الكود الجديد',
                labelStyle: TextStyle(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.amberAccent)),
              ),
            ),
            actions: [
              TextButton(
                child: const Text('إلغاء', style: TextStyle(color: Colors.white54)),
                onPressed: () => Navigator.pop(dialogContext),
              ),
              TextButton(
                child: const Text('حفظ', style: TextStyle(color: Colors.amberAccent)),
                onPressed: () {
                  if (newCodeController.text.trim().isNotEmpty) {
                    secretRoomCodeNotifier.value = newCodeController.text.trim();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم تحديث الكود المتغير بنجاح ✨')),
                    );
                  }
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
// ==========================================
// 3. شاشة الشات الجماعي السري (المجموعة السرية الآمنة 🛡️)
// ==========================================
class SecretChatScreen extends StatefulWidget {
  const SecretChatScreen({super.key});

  @override
  State<SecretChatScreen> createState() => _SecretChatScreenState();
}

class _SecretChatScreenState extends State<SecretChatScreen> with SingleTickerProviderStateMixin {
  bool _isUnlocked = false; 
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  final List<Map<String, dynamic>> _secretMessages = [
    {
      "sender": "System", 
      "text": "أهلاً بك في المجموعة السرية الآمنة", 
      "isMe": false
    },
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  void _sendSecretMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _secretMessages.add({
          "sender": "أنت",
          "text": _messageController.text.trim(),
          "isMe": true,
        });
        _messageController.clear();
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _passController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isUnlocked ? _buildChatInterface() : _buildPasswordInterface();
  }

  // 1. واجهة الباسورد (العنوان في المنتصف والقفل على الشمال)
  Widget _buildPasswordInterface() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          centerTitle: true, // جعل العنوان في المنتصف
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'المجموعة السرية الآمنة',
                style: TextStyle(color: Colors.amberAccent, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Icon(Icons.lock_rounded, color: Colors.amberAccent, size: 18), // القفل على الشمال من النص
            ],
          ),
          backgroundColor: const Color(0xFF121212),
          elevation: 2,
          iconTheme: const IconThemeData(color: Colors.amberAccent),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _pulseAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.amberAccent.withOpacity(0.08),
                      border: Border.all(color: Colors.amberAccent, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amberAccent.withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.lock_rounded, color: Colors.amberAccent, size: 55),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'المجموعة السرية الآمنة 🛡️',
                  style: TextStyle(color: Colors.amberAccent, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.1),
                ),
                const SizedBox(height: 8),
                const Text(
                  'منطقة مقيدة أمنياً - أدخل مفتاح التشفير',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 40),
                Container(
                  constraints: const BoxConstraints(maxWidth: 380),
                  child: TextField(
                    controller: _passController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.amberAccent, fontSize: 18, letterSpacing: 2),
                    decoration: InputDecoration(
                      hintText: '••••••••••••',
                      hintStyle: TextStyle(color: Colors.grey[700]),
                      filled: true,
                      fillColor: const Color(0xFF141414),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.amberAccent, width: 1.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  constraints: const BoxConstraints(maxWidth: 380),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amberAccent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 8,
                      shadowColor: Colors.amberAccent.withOpacity(0.5),
                    ),
                    onPressed: () {
                      if (_passController.text.trim() == "SHADOW-999") {
                        setState(() => _isUnlocked = true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('الكود غير صحيح! حاول مجدداً', style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lock_open_rounded, size: 20),
                        SizedBox(width: 8),
                        Text('فك التشفير والدخول', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 2. واجهة الشات الجماعي السري
  Widget _buildChatInterface() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'المجموعة السرية الآمنة',
                style: TextStyle(color: Colors.amberAccent, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Icon(Icons.security, color: Colors.amberAccent, size: 20),
            ],
          ),
          backgroundColor: const Color(0xFF121212),
          elevation: 2,
          iconTheme: const IconThemeData(color: Colors.amberAccent),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _secretMessages.length,
                itemBuilder: (context, index) {
                  final msg = _secretMessages[index];
                  final bool isMe = msg["isMe"]!;
                  
                  bool isWelcomeMsg = msg["text"].toString().contains("أهلاً بك في المجموعة السرية الآمنة");

                  if (isWelcomeMsg && !isMe) {
                    return Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.amberAccent.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.amberAccent.withOpacity(0.25)),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.verified_user_rounded, color: Colors.amberAccent, size: 38),
                          const SizedBox(height: 12),
                          Text(
                            msg["text"]!,
                            style: const TextStyle(color: Colors.amberAccent, fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "جميع الرسائل داخل هذه الغرفة مشفرة ومؤمنة بالكامل.",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.amberAccent.withOpacity(0.2) : const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isMe ? Colors.amberAccent : const Color(0xFF00FF66).withOpacity(0.4),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg["sender"]!,
                            style: TextStyle(
                              color: isMe ? Colors.amberAccent : const Color(0xFF00FF66),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            msg["text"]!,
                            style: const TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFF121212),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'اكتب رسالتك السرية...',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _sendSecretMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.amberAccent),
                    onPressed: _sendSecretMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// ==========================================
// 4. إعدادات النظام وشاشات التطبيق
// ==========================================
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            '⚙️ إعدادات النظام',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black87,
          centerTitle: true,
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.folder_special, color: Color(0xFF00FF66)),
              title: const Text('الإعدادات المتغيرة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: const Text('تحكم في الحركة، الصوت، والتشفير التلقائي', style: TextStyle(color: Colors.white54)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DynamicSettingsScreen(),
                  ),
                );
              },
            ),
            const Divider(color: Colors.white24),
            ListTile(
              leading: const Icon(Icons.security, color: Colors.cyanAccent),
              title: const Text('الخصوصية والأمان', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: const Text('الوضع الخفي، قفل التطبيق، وحذف السجل', style: TextStyle(color: Colors.white54)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacySettingsScreen(),
                  ),
                );
              },
            ),
            const Divider(color: Colors.white24),
            ListTile(
              leading: const Icon(Icons.account_circle, color: Colors.amberAccent),
              title: const Text('👤 الحساب والمظهر', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: const Text('الملف الشخصي وتخصيص المظهر والألوان', style: TextStyle(color: Colors.white54)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountAndThemeScreen(),
                  ),
                );
              },
            ),
            const Divider(color: Colors.white24),
            ListTile(
              leading: const Icon(Icons.notifications_active, color: Colors.pinkAccent),
              title: const Text('🔔 الإشعارات والأصوات', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: const Text('تخصيص نغمات التنبيه والاهتزاز', style: TextStyle(color: Colors.white54)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationsScreen(),
                  ),
                );
              },
            ),
            const Divider(color: Colors.white24),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.blueAccent),
              title: const Text('حول التطبيق', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: const Text('Shadow Chat v1.0.0 ومعلومات المبرمج', style: TextStyle(color: Colors.white54)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutAppScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DynamicSettingsScreen extends StatelessWidget {
  const DynamicSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            '🎛️ الإعدادات المتغيرة',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black87,
          centerTitle: true,
        ),
        body: ListView(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: whaleMotionNotifier,
              builder: (context, isMoving, child) {
                return SwitchListTile(
                  secondary: const Icon(Icons.waves, color: Colors.cyanAccent),
                  title: const Text('تحريك خلفية الحوت', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('تفعيل أو إيقاف حركة طفو الحوت في الخلفية', style: TextStyle(color: Colors.white54)),
                  value: isMoving,
                  activeColor: const Color(0xFF00FF66),
                  onChanged: (bool value) {
                    whaleMotionNotifier.value = value;
                  },
                );
              },
            ),
            const Divider(color: Colors.white24),
            ValueListenableBuilder<bool>(
              valueListenable: whaleSoundNotifier,
              builder: (context, isSoundEnabled, child) {
                return SwitchListTile(
                  secondary: const Icon(Icons.volume_up, color: Colors.pinkAccent),
                  title: const Text('صوت ترحيب الحوت', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('تشغيل أو إيقاف المؤثر الصوتي عند فتح الشات', style: TextStyle(color: Colors.white54)),
                  value: isSoundEnabled,
                  activeColor: const Color(0xFF00FF66),
                  onChanged: (bool value) {
                    whaleSoundNotifier.value = value;
                  },
                );
              },
            ),
            const Divider(color: Colors.white24),
            ValueListenableBuilder<bool>(
              valueListenable: autoEncryptNotifier,
              builder: (context, isAutoEncryptEnabled, child) {
                return SwitchListTile(
                  secondary: const Icon(Icons.security, color: Color(0xFF00FF66)),
                  title: const Text('تشفير الرسائل التلقائي', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('تشفير كل رسالة جديدة فور إرسالها تلقائياً', style: TextStyle(color: Colors.white54)),
                  value: isAutoEncryptEnabled,
                  activeColor: const Color(0xFF00FF66),
                  onChanged: (bool value) {
                    autoEncryptNotifier.value = value;
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _appLockEnabled = false;
  bool _ghostModeEnabled = true;
  bool _autoDeleteMessages = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'الخصوصية والأمان',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Icon(Icons.lock, color: Color(0xFF00FF66), size: 20),
            ],
          ),
          backgroundColor: Colors.black87,
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              'حماية التطبيق',
              style: TextStyle(color: Color(0xFF00FF66), fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              secondary: const Icon(Icons.fingerprint, color: Colors.cyanAccent),
              title: const Text('قفل التطبيق بالبصمة / كلمة السر', style: TextStyle(color: Colors.white)),
              subtitle: const Text('طلب التحقق عند فتح Shadow Chat', style: TextStyle(color: Colors.white54)),
              value: _appLockEnabled,
              activeColor: const Color(0xFF00FF66),
              onChanged: (bool value) {
                setState(() {
                  _appLockEnabled = value;
                });
              },
            ),
            const Divider(color: Colors.white24, height: 30),
            const Text(
              'خصوصية المحادثات',
              style: TextStyle(color: Color(0xFF00FF66), fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              secondary: const Icon(Icons.visibility_off, color: Colors.purpleAccent),
              title: const Text('الوضع الخفي (Ghost Mode)', style: TextStyle(color: Colors.white)),
              subtitle: const Text('إخفاء مؤشر "جاري الكتابة" وحالة الاتصال', style: TextStyle(color: Colors.white54)),
              value: _ghostModeEnabled,
              activeColor: const Color(0xFF00FF66),
              onChanged: (bool value) {
                setState(() {
                  _ghostModeEnabled = value;
                });
              },
            ),
            SwitchListTile(
              secondary: const Icon(Icons.timer_off, color: Colors.amberAccent),
              title: const Text('الرسائل ذاتية التدمير', style: TextStyle(color: Colors.white)),
              subtitle: const Text('حذف الرسائل تلقائياً بعد قراءتها', style: TextStyle(color: Colors.white54)),
              value: _autoDeleteMessages,
              activeColor: const Color(0xFF00FF66),
              onChanged: (bool value) {
                setState(() {
                  _autoDeleteMessages = value;
                });
              },
            ),
            const Divider(color: Colors.white24, height: 30),
            const Text(
              'إدارة البيانات',
              style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
              title: const Text('حذف سجل المحادثات بالكامل', style: TextStyle(color: Colors.white)),
              subtitle: const Text('مسح كافة الرسائل المخزنة نهائياً', style: TextStyle(color: Colors.white54)),
              onTap: () {
                _showDeleteConfirmationDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Text('تحذير أمني', style: TextStyle(color: Colors.redAccent)),
            content: const Text(
              'هل أنت متأكد من حذف جميع سجلات الشات نهائياً؟ لا يمكن التراجع عن هذه الخطوة.',
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                child: const Text('إلغاء', style: TextStyle(color: Colors.cyanAccent)),
                onPressed: () => Navigator.of(dialogContext).pop(),
              ),
              TextButton(
                child: const Text('حذف الكل', style: TextStyle(color: Colors.redAccent)),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class AccountAndThemeScreen extends StatefulWidget {
  const AccountAndThemeScreen({super.key});

  @override
  State<AccountAndThemeScreen> createState() => _AccountAndThemeScreenState();
}

class _AccountAndThemeScreenState extends State<AccountAndThemeScreen> {
  String _userName = "Shadow User 🛡️";
  String _userStatus = "متواجد في الظل... 🌑";

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'الحساب والمظهر',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Icon(Icons.account_circle, color: Colors.amberAccent, size: 20),
            ],
          ),
          backgroundColor: Colors.black87,
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              'الملف الشخصي',
              style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 10),
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Color(0xFF00FF66),
                    child: CircleAvatar(
                      radius: 42,
                      backgroundColor: Colors.black,
                      child: Icon(Icons.person, size: 50, color: Color(0xFF00FF66)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF00FF66),
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(Icons.edit, size: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            ListTile(
              leading: const Icon(Icons.badge, color: Colors.cyanAccent),
              title: const Text('اسم المستخدم', style: TextStyle(color: Colors.white54, fontSize: 13)),
              subtitle: Text(_userName, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFF00FF66)),
                onPressed: () => _editProfileField('تعديل اسم المستخدم', _userName, (val) {
                  setState(() => _userName = val);
                }),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.purpleAccent),
              title: const Text('الحالة الشخصية (Bio)', style: TextStyle(color: Colors.white54, fontSize: 13)),
              subtitle: Text(_userStatus, style: const TextStyle(color: Colors.white, fontSize: 15)),
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFF00FF66)),
                onPressed: () => _editProfileField('تعديل الحالة', _userStatus, (val) {
                  setState(() => _userStatus = val);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editProfileField(String title, String initialValue, Function(String) onSaved) {
    final TextEditingController textController = TextEditingController(text: initialValue);
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text(title, style: const TextStyle(color: Color(0xFF00FF66))),
            content: TextField(
              controller: textController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00FF66))),
              ),
            ),
            actions: [
              TextButton(
                child: const Text('إلغاء', style: TextStyle(color: Colors.white54)),
                onPressed: () => Navigator.pop(dialogContext),
              ),
              TextButton(
                child: const Text('حفظ', style: TextStyle(color: Color(0xFF00FF66))),
                onPressed: () {
                  if (textController.text.trim().isNotEmpty) {
                    onSaved(textController.text.trim());
                  }
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _messageSound = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('الإشعارات والأصوات', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black87,
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            SwitchListTile(
              secondary: const Icon(Icons.music_note, color: Color(0xFF00FF66)),
              title: const Text('صوت الرسائل الواردة', style: TextStyle(color: Colors.white)),
              value: _messageSound,
              activeColor: const Color(0xFF00FF66),
              onChanged: (val) => setState(() => _messageSound = val),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('حول التطبيق', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black87,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF00FF66), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00FF66).withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.code,
                  size: 50,
                  color: Color(0xFF00FF66),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.public, color: Colors.cyanAccent, size: 20),
                  SizedBox(width: 8),
                  Text(
                    '✨ 🌑 SHADOW CHAT 🌑 ✨',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.public, color: Colors.cyanAccent, size: 20),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Version v1.0.0',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Divider(color: Colors.white24, thickness: 1),
              ),
              const Text(
                'Lead Developer & Architect:',
                style: TextStyle(
                  color: Color(0xFF00FF66),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Eng. Hatem',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.public, color: Colors.cyanAccent, size: 20),
                  SizedBox(width: 4),
                  Text('✨', style: TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF00FF66).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF00FF66).withOpacity(0.5)),
                ),
                child: const Text(
                  '« Secure Flutter Application »',
                  style: TextStyle(
                    color: Color(0xFF00FF66),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'تطبيق محادثة مشفر وآمن، مصمم بأعلى معايير الأداء والخصوصية في عالم الظل.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ==========================================
// 5. شاشة الشات العادية (بدون AppBar - عائمة في الماء)
// ==========================================
class Message {
  final String originalText;
  final String encryptedData; // هنحفظ هنا النص المتشفر بجد
  bool isEncrypted;
  final bool isMe;

  Message({
    required this.originalText,
    required this.encryptedData,
    required this.isMe,
    this.isEncrypted = false,
  });

  String get displayText {
    if (!isEncrypted) return originalText;
    // الشكل السري الغامض (المربعات) مع الحفاظ على التشفير الحقيقي جواه
    return encryptedData.replaceAll(RegExp(r'[^\s]'), '█');
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<Message> _messages = [
    Message(
      originalText: 'أهلاً بك في نظام shadow chat ✨ 🌑 ✨',
      encryptedData: 'أهلاً بك في نظام shadow chat ✨ 🌑 ✨',
      isMe: false,
    ),
  ];
  final TextEditingController _controller = TextEditingController();
  final AudioPlayer _chatAudioPlayer = AudioPlayer();

  late AnimationController _whaleController;
  late Animation<double> _whaleAnimation;

  late AnimationController _launchController;
  bool _isLaunching = false;

  @override
  void initState() {
    super.initState();
    if (whaleSoundNotifier.value) {
      _chatAudioPlayer.play(AssetSource('audio/whale_sound.mp3'));
    }

    _whaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _whaleAnimation = Tween<double>(begin: -12.0, end: 12.0).animate(
      CurvedAnimation(parent: _whaleController, curve: Curves.easeInOut),
    );

    _launchController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
  }

  @override
  void dispose() {
    _chatAudioPlayer.dispose();
    _whaleController.dispose();
    _launchController.dispose();
    _controller.dispose();
    super.dispose();
  }

  // دالة تشفير حقيقي باستخدام Base64 و XOR بسيط
  String _realEncrypt(String text) {
    if (text.isEmpty) return '';
    List<int> utf8Bytes = utf8.encode(text);
    // مفتاح ثابت أو ممكن تربطه بالغرفة السرية
    List<int> keyBytes = utf8.encode('SHADOW_KEY_2026');
    
    List<int> encryptedBytes = [];
    for (int i = 0; i < utf8Bytes.length; i++) {
      encryptedBytes.add(utf8Bytes[i] ^ keyBytes[i % keyBytes.length]);
    }
    return base64Encode(encryptedBytes);
  }

  // دعم تحويل النصوص العربية والإنجليزية لنيون
  String _toNeonGreenText(String text) {
    const Map<String, String> normalToNeon = {
      // الحروف العربية
      'ا': '𝕒', 'ب': '𝕓', 'ت': '𝕥', 'ث': '𝕥𝕙', 'ج': '𝕛', 'ح': '𝕙', 'خ': '𝕩',
      'د': '𝕕', 'ذ': 'ẕ', 'ر': '𝕣', 'ز': '𝕫', 'س': '𝕤', 'ش': '𝕤𝕙', 'ص': '𝕤',
      'ض': 'ḏ', 'ط': '𝕥', 'ظ': 'ẓ', 'ع': '𝕔', 'غ': 'ǧ', 'ف': '𝕗', 'ق': 'զ',
      'ك': '𝕜', 'ل': '𝕝', 'م': '𝕞', 'ن': '𝕟', 'ه': '𝕙', 'و': '𝕨', 'ي': '𝟪',
      'أ': '𝕒', 'إ': '𝕒', 'آ': '𝕒', 'ة': '𝕥', 'ى': '𝟪', 'ئ': '𝟪', 'ؤ': '𝕨',
      'ء': '𝕩', 'لا': '𝕝𝕒',
      
      // الحروف الإنجليزية الصغيرة
      'a': '𝕒', 'b': '𝕓', 'c': '𝕔', 'd': '𝕕', 'e': '𝕖', 'f': '𝕗', 'g': '𝕘',
      'h': '𝕙', 'i': '𝕚', 'j': '𝕛', 'k': '𝕜', 'l': '𝕝', 'm': '𝕞', 'n': '𝕟',
      'o': '𝕠', 'p': '𝕡', 'q': 'զ', 'r': '𝕣', 's': '𝕤', 't': '𝕥', 'u': '𝕦',
      'v': '𝕧', 'w': '𝕨', 'x': '𝕩', 'y': '𝕪', 'z': '𝕫',

      // الحروف الإنجليزية الكبيرة
      'A': '𝔸', 'B': '𝔹', 'C': 'ℂ', 'D': '𝔻', 'E': '𝔼', 'F': '𝔽', 'G': '𝔾',
      'H': 'ℍ', 'I': '𝕀', 'J': '𝕁', 'K': '𝕂', 'L': '𝔏', 'M': '𝕄', 'N': 'ℕ',
      'O': '𝕆', 'P': 'ℙ', 'Q': 'ℚ', 'R': 'ℝ', 'S': '𝕊', 'T': '𝕋', 'U': '𝕌',
      'V': '𝕍', 'W': '𝕎', 'X': '𝕏', 'Y': '𝕐', 'Z': 'ℤ',

      // الأرقام
      '0': '𝟘', '1': '𝟙', '2': '𝟚', '3': '𝟛', '4': '𝟜', '5': '𝟝', '6': '𝟞',
      '7': '𝟟', '8': '𝟠', '9': '𝟡',
    };

    StringBuffer result = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      result.write(normalToNeon[char] ?? char);
    }
    return result.toString();
  }

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty && !_isLaunching) {
      String userText = _controller.text.trim();
      _controller.clear();

      setState(() {
        _isLaunching = true;
      });

      // تشفير البيانات بجد في الخلفية لو الـ autoEncrypt مفعل
      bool isEncrypted = autoEncryptNotifier.value;
      String processedText = isEncrypted ? _realEncrypt(userText) : userText;

      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _messages.add(Message(
              originalText: userText,
              encryptedData: processedText,
              isMe: true,
              isEncrypted: isEncrypted,
            ));
          });
        }
      });

      _launchController.forward(from: 0.0).then((_) {
        if (mounted) {
          setState(() {
            _isLaunching = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: whaleMotionNotifier,
              builder: (context, isMoving, child) {
                return AnimatedBuilder(
                  animation: _whaleAnimation,
                  builder: (context, child) {
                    return Positioned.fill(
                      child: Transform.translate(
                        offset: isMoving ? Offset(0, _whaleAnimation.value) : Offset.zero,
                        child: Transform.scale(
                          scale: 1.08,
                          child: Image.asset('assets/images/whale.jpg', fit: BoxFit.cover),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Positioned.fill(child: Container(color: Colors.black.withOpacity(0.35))),
            SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      '✨ 🌑 SHADOW CHAT 🌑 ✨',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        return Align(
                          alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: const Color(0xFF00FF66),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF00FF66).withOpacity(0.4),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Text(
                              _toNeonGreenText(msg.displayText),
                              style: TextStyle(
                                color: const Color(0xFF00FF66),
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: const Color(0xFF00FF66).withOpacity(0.8),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            style: const TextStyle(color: Colors.white), // تم تعديلها هنا وصحتها
                            decoration: const InputDecoration(
                              hintText: 'اكتب رسالتك السرية... / Type a message...',
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (_) => _sendMessage(),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send, color: Color(0xFF00FF66)),
                          onPressed: _sendMessage,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}