import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class CustomSearchTextField extends StatefulWidget {
    const CustomSearchTextField({super.key, required this.hintTexts,  this.controller , this.onChanged});

  final List<String> hintTexts;
 final TextEditingController? controller ;
   final ValueChanged<String>? onChanged;

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  late TextEditingController _controller;

  bool get _isTyping => _controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() {
      setState(() {}); 
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();  
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1.2,
            ),
          ),
          child: TextField(
            controller: _controller,
            textAlign: Directionality.of(context) == TextDirection.rtl
                ? TextAlign.right
                : TextAlign.left,
            decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
            ),
            style: const TextStyle(color: Colors.black, fontSize: 16),
            onChanged: widget.onChanged,
          ),

        ),

        if (!_isTyping)
          Positioned.fill(
            left: Directionality.of(context) == TextDirection.ltr ? 48 : 0,
            right: Directionality.of(context) == TextDirection.rtl ? 48 : 0,
            child: Align(
              alignment: Directionality.of(context) == TextDirection.rtl
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: IgnorePointer(
                ignoring: true,
                child: AnimatedTextKit(
                  repeatForever: true,
                  pause: const Duration(milliseconds: 1000),
                  animatedTexts: widget.hintTexts
                      .map(
                        (text) => TypewriterAnimatedText(
                      text,
                      textStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  )
                      .toList(),
                ),
              ),
            ),
          ),


      ],
    );
  }
}
