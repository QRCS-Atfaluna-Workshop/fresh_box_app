import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class MasbahaScreen extends StatefulWidget {
  const MasbahaScreen({super.key});
  @override
  State<MasbahaScreen> createState() => _MasbahaScreenState();
}

class _MasbahaScreenState extends State<MasbahaScreen> {
  int _count = 0;

  final List<String> _adhkar = [
    'استغفر الله الذي لا إله إلا\nهو الحي القيوم',
    'سبحان الله وبحمده\nسبحان الله العظيم',
  ];

  int _selectedIndex = 0;

  String get _currentZikr => _adhkar[_selectedIndex];

  void _increment() {
    HapticFeedback.lightImpact();
    setState(() => _count++);
  }

  void _reset() {
    setState(() => _count = 0);
  }

  void _changeZikr(int index) {
    setState(() {
      _selectedIndex = index;
      _count = 0; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F3),
      body: SafeArea(
        child: GestureDetector(
          onTap: _increment,
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PopupMenuButton<int>(
                      icon: const Icon(Icons.tune, color: Colors.black54),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      onSelected: _changeZikr,
                      itemBuilder: (_) => List.generate(
                        _adhkar.length,
                        (i) => PopupMenuItem(
                          value: i,
                          child: Row(
                            children: [
                              Icon(
                                i == _selectedIndex
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_off,
                                color: const Color(0xFF3EC6A8),
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _adhkar[i].replaceAll('\n', ' '),
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Arial'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        Text(
                          'مَسْبَحَة',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3EC6A8),
                            fontFamily: 'Arial',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3EC6A8),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.bolt,
                              color: Colors.white, size: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'الذكر الحالي',
                          style: TextStyle(
                              fontSize: 13, color: Colors.black54),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        _currentZikr,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 14),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.auto_awesome,
                              color: Colors.pinkAccent, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'نور لقلبك وضياء ليومك',
                            style: TextStyle(
                                color: Colors.black38, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3EC6A8).withOpacity(0.25),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _increment,
                    child: Container(
                      width: 190,
                      height: 190,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF3EC6A8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$_count',
                            style: const TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'تسبيحة',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: GestureDetector(
                  onTap: _reset,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.refresh, color: Colors.black54, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'إعادة الضبط',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
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