import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/features/Home/presentation/bloc/update_quantity/update_quantity_bloc.dart';

class CustomQuantityItem extends StatefulWidget {
  final int initialQuantity;
  final String productId;

  const CustomQuantityItem({
    Key? key,
    required this.initialQuantity,
    required this.productId,
  }) : super(key: key);

  @override
  _CustomQuantityItemState createState() => _CustomQuantityItemState();
}

class _CustomQuantityItemState extends State<CustomQuantityItem> {
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
          _lastValidQuantity = state
              .product.quantity; // Update the last valid quantity on success
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
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
            icon: const Icon(
              Icons.remove,
              color: Color(0xffB3B3B3),
            ),
          ),
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: borderColor),
            ),
            child: Center(
              child: Text('$_quantity'),
            ),
          ),
          IconButton(
            onPressed: () {
              final newQuantity = _quantity + 1;
              _updateQuantity(newQuantity);
              context.read<UpdateQuantityBloc>().add(
                    UpdateQuantity(
                      id: widget.productId,
                      quantity: newQuantity,
                    ),
                  );
            },
            icon: Icon(
              Icons.add,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
