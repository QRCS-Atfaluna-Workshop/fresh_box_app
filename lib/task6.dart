import 'package:flutter/material.dart';




class MenuItem {
  final String label;
  final IconData icon;
  final Color color;

  const MenuItem({
    required this.label,
    required this.icon,
    required this.color,
  });
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with TickerProviderStateMixin {
  MenuItem? _selectedItem;
  bool _isAnimating = false;

  late AnimationController _colorCtrl;
  late Animation<Color?> _colorAnim;
  Color _currentColor = const Color(0xFF6C63FF);
  Color _targetColor  = const Color(0xFF6C63FF);

  static const _menuItems = [
    MenuItem(label: 'الإعدادات',    icon: Icons.settings_rounded,    color: Color(0xFF6C63FF)),
    MenuItem(label: 'الملف الشخصي', icon: Icons.person_rounded,       color: Color(0xFF00B4A0)),
    MenuItem(label: 'المفضلة',      icon: Icons.favorite_rounded,     color: Color(0xFFFF4081)),
    MenuItem(label: 'المشاركة',     icon: Icons.share_rounded,        color: Color(0xFFFF9800)),
    MenuItem(label: 'تسجيل الخروج', icon: Icons.logout_rounded,       color: Color(0xFFE53935)),
  ];

  @override
  void initState() {
    super.initState();
    _colorCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _colorAnim = ColorTween(
      begin: _currentColor,
      end: _targetColor,
    ).animate(CurvedAnimation(parent: _colorCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _colorCtrl.dispose();
    super.dispose();
  }

  void _animateToColor(Color next) {
    _colorAnim = ColorTween(
      begin: _currentColor,
      end: next,
    ).animate(CurvedAnimation(parent: _colorCtrl, curve: Curves.easeInOut));
    _colorCtrl.forward(from: 0).then((_) {
      setState(() => _currentColor = next);
    });
    _targetColor = next;
  }

  void _onItemSelected(MenuItem item) {
    setState(() {
      _selectedItem = item;
      _isAnimating  = true;
    });
    _animateToColor(item.color);
    Future.delayed(const Duration(milliseconds: 300),
        () => setState(() => _isAnimating = false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor:Colors.grey.shade100,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'القائمة المنسدلة',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF1A1A2E),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade100),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _colorCtrl,
                builder: (_, __) {
                  final color = _colorAnim.value ?? _currentColor;
                  return _ColorCard(
                    color: color,
                    item: _selectedItem,
                    isAnimating: _isAnimating,
                  );
                },
              ),

              const SizedBox(height: 32),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: anim,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(anim),
                    child: child,
                  ),
                ),
                child: _selectedItem == null
                    ? Text(
                        'اختر من القائمة',
                        key: const ValueKey('placeholder'),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Row(
                        key: ValueKey(_selectedItem!.label),
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(_selectedItem!.icon,
                            color: _selectedItem!.color, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            _selectedItem!.label,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _selectedItem!.color,
                            ),
                          ),
                        ],
                      ),
              ),

              const SizedBox(height: 32),

              _MenuButton(
                items: _menuItems,
                selectedItem: _selectedItem,
                onSelected: _onItemSelected,
              ),

              const SizedBox(height: 48),

              if (_selectedItem != null)
                TextButton.icon(
                  onPressed: () {
                    setState(() => _selectedItem = null);
                    _animateToColor(const Color(0xFF6C63FF));
                  },
                  icon: const Icon(Icons.refresh_rounded, size: 16),
                  label: const Text('إعادة تعيين'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey.shade500,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorCard extends StatelessWidget {
  final Color color;
  final MenuItem? item;
  final bool isAnimating;

  const _ColorCard({
    required this.color,
    required this.item,
    required this.isAnimating,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 24,
            spreadRadius: 4,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: item == null
              ? Icon(
                  Icons.touch_app_rounded,
                  key: const ValueKey('default'),
                  color: Colors.white.withOpacity(0.6),
                  size: 48,
                )
              : Icon(
                  item!.icon,
                  key: ValueKey(item!.label),
                  color: Colors.white,
                  size: 56,
                ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final List<MenuItem> items;
  final MenuItem? selectedItem;
  final void Function(MenuItem) onSelected;

  const _MenuButton({
    required this.items,
    required this.selectedItem,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      tooltip: 'افتح القائمة',
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      offset: const Offset(0, -8),
      onSelected: onSelected,
      itemBuilder: (_) => items
          .map(
            (item) => PopupMenuItem<MenuItem>(
              value: item,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: _MenuItemTile(
                item: item,
                isSelected: selectedItem?.label == item.label,
              ),
            ),
          )
          .toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              selectedItem?.color ?? const Color(0xFF6C63FF),
              (selectedItem?.color ?? const Color(0xFF6C63FF)).withOpacity(0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: (selectedItem?.color ?? const Color(0xFF6C63FF))
                  .withOpacity(0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.menu_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            const Text(
              'اختر خياراً',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_down_rounded,
                color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}

class _MenuItemTile extends StatelessWidget {
  final MenuItem item;
  final bool isSelected;

  const _MenuItemTile({required this.item, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? item.color.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(item.icon, color: item.color, size: 18),
          ),
          const SizedBox(width: 12),
          Text(
            item.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? item.color : const Color(0xFF1A1A2E),
            ),
          ),
          const Spacer(),
          if (isSelected)
            Icon(Icons.check_circle_rounded, color: item.color, size: 18),
        ],
      ),
    );
  }
}