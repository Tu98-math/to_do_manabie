part of 'task_card.dart';

class Description extends StatelessWidget {
  const Description(this.task, {Key? key}) : super(key: key);

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (task.des ?? '')
            .plain()
            .fSize(16)
            .weight(FontWeight.w500)
            .color(
              (task.completed ?? true)
                  ? AppColors.neutral.grey
                  : AppColors.neutral.dark,
            )
            .decoration((task.completed ?? true)
                ? TextDecoration.lineThrough
                : TextDecoration.none)
            .b(),
        SizedBox(height: 4.w),
        toTimeString(
          DateTime.fromMillisecondsSinceEpoch(task.time ?? 0),
        )
            .plain()
            .fSize(16)
            .weight(FontWeight.w500)
            .color(AppColors.neutral.grey)
            .b()
      ],
    ).pad(13.h, 0);
  }

  String toTimeString(DateTime date) {
    String result = '';
    result += (date.hour % 12).toString() + ':' + date.minute.toString();
    if (date.hour > 12) {
      result += ' pm';
    } else {
      result += ' am';
    }
    return result +
        '  ${AppStrings.month[date.month].substring(0, 3)} ${date.day}, ${date.year}';
  }
}
