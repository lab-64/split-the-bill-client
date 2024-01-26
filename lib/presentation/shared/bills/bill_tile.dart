import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/bill.dart';

class BillTile extends StatelessWidget {
  const BillTile({
    super.key,
    required this.bill,
    required this.showGroup,
    required this.onTap,
  });

  final Bill bill;
  final bool showGroup;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: Sizes.p4),
          child: Text(
            "18.01", // TODO: grouping should happen heere
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.only(bottom: Sizes.p16),
          elevation: 0,
          child: _buildListTile(),
        ),
      ],
    );
  }

  Widget _buildListTile() {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Sizes.p16,
        vertical: Sizes.p4,
      ),
      leading: _buildLeadingIcon(),
      title: _buildBillName(),
      subtitle: _buildSubtitle(),
      trailing: _buildTrailingAmount(),
    );
  }

  Widget _buildLeadingIcon() {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.green.shade300, Colors.green.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Icon(
        Icons.attach_money,
        color: Colors.white,
      ),
    );
  }

  Widget _buildBillName() {
    return Text(
      bill.name,
      style: const TextStyle(
        fontSize: 16.0,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOwnerRow(),
        Visibility(
          visible: showGroup,
          child: _buildGroupRow(),
        ),
      ],
    );
  }

  Widget _buildOwnerRow() {
    return const Row(
      children: [
        CircleAvatar(
          radius: 8.0,
          backgroundImage: AssetImage('assets/avatar.jpg'),
        ),
        SizedBox(width: Sizes.p4),
        Text(
          "Felix", //TODO
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildGroupRow() {
    return Row(
      children: [
        Container(
          width: 16.0,
          height: 16.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.purple.shade300, Colors.purple.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(
            Icons.home,
            size: 10,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: Sizes.p4),
        const Text(
          "Some Group", // TODO
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildTrailingAmount() {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "235,53 €", // TODO
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.green, // TODO
          ),
        ),
      ],
    );
  }
}
