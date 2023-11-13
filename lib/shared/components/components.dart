import 'package:flutter/material.dart';
import '../../styles/colors.dart';

// Widget buildBoardingItem(BoardingModel model) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Expanded(
//         child: Image(
//           image: AssetImage(model.image),
//         ),
//       ),
//       const SizedBox(
//         height: 30.0,
//       ),
//       Text(
//         model.title,
//         style: const TextStyle(
//           fontSize: 24.0,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       const SizedBox(
//         height: 15,
//       ),
//       Text(
//         model.body,
//         style: const TextStyle(
//           fontSize: 14.0,
//         ),
//       ),
//     ],
//   );
// }

// String? _defileValidator(value, hint) {
//   return value?.isEmpty == true ? "Enter your $hint" : null;
// }

String? Function(String?)? _defileValidator(hint) {
  indfv(value) {
    return value?.isEmpty == true ? "Enter your $hint" : null;
  }

  return indfv;
}

Widget defaultTextFormField({
  required TextEditingController controller,
  required String hint,
  required TextInputType type,
  bool obscureText = false,
  bool autofocus = false,
  bool enable = true,
  bool isCustomValidator = false,
  String? Function(String?)? customValidator,
  String? label,
  IconData? prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  void Function(String)? onFieldSubmitted,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: TextFormField(
      decoration: InputDecoration(
        prefixIconColor: Colors.grey.shade500,
        suffixIconColor: Colors.grey.shade500,
        prefixIcon: prefix != null ? Icon(prefix) : null,
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(
                  suffix,
                  size: 20,
                ),
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: suffixPressed,
              )
            : null,
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[500],
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
      ),
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      enabled: enable,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      keyboardType: type,
      validator: isCustomValidator ? customValidator : _defileValidator(hint),
      obscureText: obscureText,
      autofocus: autofocus,
      cursorColor: primaryColor,
    ),
  );
}

Widget defaultButton({
  double width = double.infinity,
  Color color = primaryColor,
  double radius = 10.0,
  required String text,
  bool isUpperCase = true,
  required VoidCallback onPressed,
}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    ),
    child: MaterialButton(
      onPressed: onPressed,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}

enum ToastState { success, warning, error }

Color _stateColorPicker(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.warning:
      color = Colors.amber;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    default:
      color = Colors.white;
  }
  return color;
}

defaultSnackBar({
  required BuildContext context,
  required String message,
  required ToastState state,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
                offset: Offset(0, 0),
              ),
            ],
            color: _stateColorPicker(state),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              message,
            ),
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 5),
      shape: const StadiumBorder(),
    ),
  );
}
