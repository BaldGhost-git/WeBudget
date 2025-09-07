import 'package:flutter/material.dart';
import 'package:we_budget/features/transactions/controller/amount_text.dart';

class CalculatorPads extends StatelessWidget {
  const CalculatorPads({super.key, required this.controller});

  final AmountText controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    /// Either child or text needs to be provided
    /// Both can't exist together
    Widget buttonPads({
      Color? color,
      Widget? child,
      String? text,
      Function()? onTap,
    }) {
      return InkWell(
        onTap: onTap,
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color ?? theme.colorScheme.primaryContainer,
            ),
            child:
                child ??
                Text(
                  text ?? "",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Flexible(
          flex: 9,
          child: Row(
            children: [
              Flexible(
                flex: 3,
                child: GridView.count(
                  mainAxisSpacing: 9,
                  crossAxisSpacing: 6,
                  padding: EdgeInsets.zero,
                  crossAxisCount: 4,
                  children: [
                    buttonPads(text: '1', onTap: () => controller.add("1")),
                    buttonPads(text: '2', onTap: () => controller.add("2")),
                    buttonPads(text: '3', onTap: () => controller.add("3")),
                    buttonPads(
                      text: "+",
                      color: theme.colorScheme.tertiaryContainer,
                      onTap: () => controller.add("+"),
                    ),
                    buttonPads(text: '4', onTap: () => controller.add("4")),
                    buttonPads(text: '5', onTap: () => controller.add("5")),
                    buttonPads(text: '6', onTap: () => controller.add("6")),
                    buttonPads(
                      text: "-",
                      color: theme.colorScheme.tertiaryContainer,
                      onTap: () => controller.add("-"),
                    ),
                    buttonPads(text: '7', onTap: () => controller.add("7")),
                    buttonPads(text: '8', onTap: () => controller.add("8")),
                    buttonPads(text: '9', onTap: () => controller.add("9")),
                    buttonPads(
                      text: "x",
                      color: theme.colorScheme.tertiaryContainer,
                      onTap: () => controller.add("x"),
                    ),
                    buttonPads(
                      text: 'C',
                      color: theme.colorScheme.tertiaryContainer,
                      onTap: () => controller.zero(),
                    ),
                    buttonPads(text: '0', onTap: () => controller.add("0")),
                    buttonPads(
                      child: Icon(Icons.backspace, size: 35),
                      color: theme.colorScheme.tertiaryContainer,
                      onTap: () => controller.delete(),
                    ),
                    buttonPads(
                      text: "/",
                      color: theme.colorScheme.tertiaryContainer,
                      onTap: () => controller.add("/"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
