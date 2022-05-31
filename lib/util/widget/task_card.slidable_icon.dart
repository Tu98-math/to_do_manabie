part of 'task_card.dart';

class SlidableIcon extends StatelessWidget {
  const SlidableIcon(this.icon, {Key? key, required this.press})
      : super(key: key);

  final IconData icon;

  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral.light,
            offset: const Offset(5, 5),
            blurRadius: 9,
          )
        ],
      ),
      child: Icon(
        icon,
        color: AppColors.primary.red,
        size: 24.w,
      ).center(),
    ).inkTap(
      onTap: press,
    );
  }
}
