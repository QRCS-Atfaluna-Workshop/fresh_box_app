import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pro/custom_text_field.dart';

class Task10 extends StatefulWidget {
  const Task10({super.key});

  @override
  State<Task10> createState() => _Task10State();
}

class _Task10State extends State<Task10> {
  Locale _locale = const Locale('en');

  void _toggleLanguage() {
    setState(() {
      _locale =
          _locale.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo',
        primarySwatch: Colors.blue,
      ),
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      builder: (context, child) {
        return Directionality(
          textDirection: _locale.languageCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: child!,
        );
      },

      home: AuthPage(
        locale: _locale,
        onToggleLanguage: _toggleLanguage,
      ),
    );
  }
}


class AuthPage extends StatefulWidget {
  final VoidCallback onToggleLanguage;
  final Locale locale;

  const AuthPage({
    super.key,
    required this.onToggleLanguage,
    required this.locale,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  String _t(String en, String ar) =>
      widget.locale.languageCode == 'ar' ? ar : en;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _t("Welcome 👋", "مرحباً 👋"),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.language, color: Colors.white),
                      onPressed: widget.onToggleLanguage,
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.blueAccent,
                  isScrollable: false,
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                 
                  tabs: [
                    Tab(text: _t("Login", "دخول")),
                    Tab(text: _t("Sign Up", "حساب")),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      LoginForm(locale: widget.locale),
                      SignUpForm(locale: widget.locale),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class LoginForm extends StatefulWidget {
  final Locale locale;

  const LoginForm({super.key, required this.locale});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String _t(String en, String ar) =>
      widget.locale.languageCode == 'ar' ? ar : en;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(_t("Login successful!", "تم تسجيل الدخول بنجاح")),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            label: _t("Email", "البريد الإلكتروني"),
            hint: _t("Enter your email", "أدخل بريدك الإلكتروني"),
            icon: Icons.email,
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return _t("Email is required", "البريد الإلكتروني مطلوب");
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: _t("Password", "كلمة المرور"),
            hint: _t("Enter your password", "أدخل كلمة المرور"),
            icon: Icons.lock,
            obscureText: true,
            controller: passwordController,
            validator: (value) {
              if (value == null || value.length < 6) {
                return _t("Min 6 characters", "على الأقل 6 أحرف");
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.blueAccent,
            ),
            onPressed: _submit,
            child: Text(_t("Login", "دخول",), style: const TextStyle(fontSize: 20,color: Colors.white),),
          ),
        ],
      ),
    );
  }
}


class SignUpForm extends StatefulWidget {
  final Locale locale;

  const SignUpForm({super.key, required this.locale});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String _t(String en, String ar) =>
      widget.locale.languageCode == 'ar' ? ar : en;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content:
              Text(_t("Account created!", "تم إنشاء الحساب بنجاح")),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            label: _t("Username", "اسم المستخدم"),
            hint: _t("Enter username", "أدخل اسم المستخدم"),
            icon: Icons.person,
            controller: usernameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return _t("Required", "مطلوب");
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: _t("Email", "البريد الإلكتروني"),
            hint: _t("Enter email", "أدخل البريد"),
            icon: Icons.email,
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return _t("Required", "مطلوب");
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: _t("Password", "كلمة المرور"),
            hint: _t("Enter password", "أدخل كلمة المرور"),
            icon: Icons.lock,
            obscureText: true,
            controller: passwordController,
            validator: (value) {
              if (value == null || value.length < 6) {
                return _t("Min 6 characters", "على الأقل 6 أحرف");
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.blueAccent,
            ),
            onPressed: _submit,
            child: Text(_t("Sign Up", "إنشاء حساب"), style: const TextStyle(fontSize: 20,color: Colors.white),),
          ),
        ],
      ),
    );
  }
}