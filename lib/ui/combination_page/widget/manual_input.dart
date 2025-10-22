import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/ingredients_provider.dart';

class ManualInputWidget extends StatefulWidget {
  final VoidCallback? onCameraPressed;

  const ManualInputWidget({super.key, this.onCameraPressed});

  @override
  State<ManualInputWidget> createState() => _ManualInputWidgetState();
}

class _ManualInputWidgetState extends State<ManualInputWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _isFocused = false;

  void _addIngredient() {
    if (_controller.text.trim().isEmpty) return;

    final provider = context.read<IngredientsProvider>();
    provider.addIngredient(_controller.text);
    _controller.clear();

    // Hilangkan fokus setelah menambah
    FocusScope.of(context).unfocus();
    setState(() {
      _isFocused = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isFocused ? const Color(0xff3B82F6) : Colors.transparent,
          width: 2,
        ),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: const Color(0xff3B82F6).withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            maxLines: null,
            minLines: 2,
            textInputAction: TextInputAction.done,
            onTap: () {
              setState(() {
                _isFocused = true;
              });
            },
            onSubmitted: (value) {
              _addIngredient();
            },
            onTapOutside: (_) {
              setState(() {
                _isFocused = false;
              });
            },
            decoration: InputDecoration(
              hintText:
                  "Masukkan Kandungan Skincare kamu secara manual di sini!",
              hintStyle: const TextStyle(
                color: Color(0xff9CA3AF),
                fontSize: 14,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Tombol Kamera
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xff3B82F6), width: 2),
                ),
                child: IconButton(
                  onPressed: widget.onCameraPressed,
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: Color(0xff3B82F6),
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Tombol Tambah
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xff3B82F6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: IconButton(
                  onPressed: _addIngredient,
                  icon: const Icon(Icons.add, color: Colors.white, size: 28),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
