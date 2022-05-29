part of 'task_card.dart';

class IconChecked extends StatelessWidget {
  const IconChecked(
    this.checked, {
    Key? key,
    required this.press,
  }) : super(key: key);

  final bool checked;

  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18.w,
      height: 18.h,
      decoration: BoxDecoration(
        border: checked
            ? null
            : Border.all(
                color: AppColors.primary.blue,
                width: 2,
              ),
        shape: BoxShape.circle,
        color: checked ? AppColors.primary.red : null,
      ),
      child: checked
          ? Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 12.w,
              ),
            )
          : null,
    )
        .pad(23)
        .inkTap(
          onTap: press,
          borderRadius: BorderRadius.circular(100),
        )
        .pad(2, 0, 4, 4);
  }
}
