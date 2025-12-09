import 'package:flutter/material.dart';
import 'package:taskly/config/l10n/app_localizations.dart';
 

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return   Row(
      children:   [
        const Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.grey
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Text(  AppLocalizations.of(context)!.or, style: Theme.of(context).textTheme.bodyMedium,),
        ),
        const Expanded(
          child: Divider(
            thickness: 1,
             color: Colors.grey
          ),
        ),
      ],
    );
  }
}