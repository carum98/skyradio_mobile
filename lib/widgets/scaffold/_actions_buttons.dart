part of 'sk_scaffold.dart';

class _ActionsButtons extends StatelessWidget {
  final void Function() onPressed;
  final IconData icon;

  const _ActionsButtons({
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        padding: const EdgeInsets.all(0),
        minimumSize: const Size(45, 45),
      ),
      child: Icon(
        icon,
        color: Theme.of(context).textTheme.bodySmall!.color,
      ),
    );
  }
}
