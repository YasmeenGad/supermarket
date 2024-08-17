import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_quantity_icon.dart';
import 'package:supermarket/features/Home/presentation/bloc/update_quantity/update_quantity_bloc.dart';

class QuantityCartSection extends StatefulWidget {
  const QuantityCartSection({
    Key? key,
    required this.initialQuantity,
    required this.productId,
  }) : super(key: key);

  final int initialQuantity;
  final String productId;

  @override
  State<QuantityCartSection> createState() => _QuantityCartSectionState();
}

class _QuantityCartSectionState extends State<QuantityCartSection> {
  late int _quantity;
  late int _lastValidQuantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
    _lastValidQuantity = widget.initialQuantity;
  }

  void _updateQuantity(int newQuantity) {
    setState(() {
      _quantity = newQuantity;
    });
  }

  void _revertQuantity() {
    setState(() {
      _quantity = _lastValidQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateQuantityBloc, UpdateQuantityState>(
      listener: (context, state) {
        if (state is UpdateQuantityError) {
          final snackBar = SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 10),
                Text(state.message),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          _revertQuantity(); // Revert the quantity on error
        } else if (state is UpdateQuantitySuccess) {
          _lastValidQuantity = state.product.quantity; // Update last valid quantity on success
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomQuantityIcon(
            icon: Icons.remove,
            iconColor: const Color(0xffB3B3B3),
            onTap: () {
              if (_quantity > 1) {
                final newQuantity = _quantity - 1;
                _updateQuantity(newQuantity);
                context.read<UpdateQuantityBloc>().add(
                      UpdateQuantity(
                        id: widget.productId,
                        quantity: newQuantity,
                      ),
                    );
              }
            },
          ),
          const SizedBox(width: 8),
          Text(
            '$_quantity',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          CustomQuantityIcon(
            icon: Icons.add,
            iconColor: primaryColor,
            onTap: () {
              final newQuantity = _quantity + 1;
              _updateQuantity(newQuantity);
              context.read<UpdateQuantityBloc>().add(
                    UpdateQuantity(
                      id: widget.productId,
                      quantity: newQuantity,
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}
