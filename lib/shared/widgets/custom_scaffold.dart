// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomScaffold extends ConsumerStatefulWidget {
  final bool isBusy;
  final Widget? body;
  final Widget? bottomBar;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final bool safeAreaBottom;
  final bool safeAreaTop;
  const CustomScaffold({
    super.key,
    this.isBusy = false,
    this.body,
    this.bottomBar,
    this.floatingActionButton,
    this.appBar,
    this.safeAreaBottom = true,
    this.safeAreaTop = true,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends ConsumerState<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: widget.appBar,
      body: SafeArea(
        child: widget.body ?? const SizedBox(),
      ),
      bottomNavigationBar: widget.bottomBar,
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
