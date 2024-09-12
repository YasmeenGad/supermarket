import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/models/custom_text_field_model.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/core/utils/validator.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_event.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_auth_text_section.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_text_auth.dart';
import 'package:supermarket/features/auth/presentation/widgets/custom_text_field.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPassword = true;
  bool isEmailValid = false;
  void validateEmail(String value) {
    final email = value;
    if (Validators.validateEmail(email) == null) {
      setState(() {
        isEmailValid = true;
      });
    } else {
      setState(() {
        isEmailValid = false;
      });
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Image.asset(Assets.imagesSingin),
          _buildContainer(screenSize, context),
        ],
      ),
    );
  }

  Widget _buildContainer(Size screenSize, context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 223),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomAuthTextSection(
              title: 'Sign Up',
              subtitle: 'Enter your credentials to continue',
            ),
          ),
          const SizedBox(height: 46),
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  validator: (value) {
                    return Validators.validateUsername(value);
                  },
                  controller: usernameController,
                  textFieldModel: CustomTextFieldModel(
                    text: 'Username',
                    hintText: 'username',
                  ),
                ),
                CustomTextField(
                  onChanged: validateEmail,
                  validator: (value) {
                    return Validators.validateEmail(value);
                  },
                  controller: emailController,
                  textFieldModel: CustomTextFieldModel(
                    text: 'Email',
                    hintText: 'email',
                    suffixIcon:
                        isEmailValid ? Image.asset(Assets.imagesVector) : null,
                  ),
                ),
                CustomTextField(
                  isPassword: isPassword,
                  validator: (value) {
                    return Validators.validatePassword(value);
                  },
                  controller: passwordController,
                  textFieldModel: CustomTextFieldModel(
                    text: 'Password',
                    hintText: '****',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      icon: isPassword
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is CustomerLoaded) {
                // Customer creation successful, navigate to login screen
                Navigator.pushReplacementNamed(context, AppRoutes.loginRoute,
                    arguments: state.customer);
              } else if (state is AuthFailure || state is CustomerError) {
                // Show error message
                String errorMessage;
                if (state is AuthFailure) {
                  errorMessage = state.error;
                } else if (state is CustomerError) {
                  errorMessage = state.message;
                } else {
                  errorMessage = 'An unexpected error occurred';
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(errorMessage)),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading || state is CustomerLoading) {
                return const CircularProgressIndicator(
                  color: primaryColor,
                );
              }
              return GestureDetector(
                onTap: () {
                  if (formKey.currentState?.validate() ?? false) {
                    final userName = usernameController.text.trim();
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    context.read<AuthBloc>().add(RegisterEvent(
                        userName: userName, email: email, password: password));
                    context
                        .read<AuthBloc>()
                        .add(CreateCustomerEvent(name: userName));
                  }
                },
                child: CustomButton(
                  text: 'Sign Up',
                ),
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),

          CustomTextAuth(
              text: 'Already have an account?',
              textAuth: 'Login',
              route: AppRoutes.loginRoute),
          // SizedBox(height: 16,),
        ],
      ),
    );
  }
}







// final snackBar = SnackBar(
//                   content: Row(
//                     children: [
//                       const Icon(Icons.check_circle, color: Colors.white),
//                       const SizedBox(width: 10),
//                       Text('${state.message}'),
//                     ],
//                   ),
//                   backgroundColor: Colors.green,
//                   behavior: SnackBarBehavior.floating,
//                   duration: const Duration(seconds: 3),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20)),
//                   action: SnackBarAction(
//                     label: 'OK',
//                     textColor: Colors.white,
//                     onPressed: () {},
//                   ),
//                 );
//                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                 Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);












// import 'package:flutter/material.dart';

// class SignUpScreen extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();

//   SignUpScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: LayoutBuilder(builder: (context, constraints) {
//           return SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               children: [
//                 SizedBox(height: constraints.maxHeight * 0.08),
//                 Image.network(
//                   "https://i.postimg.cc/nz0YBQcH/Logo-light.png",
//                   height: 100,
//                 ),
//                 SizedBox(height: constraints.maxHeight * 0.08),
//                 Text(
//                   "Sign Up",
//                   style: Theme.of(context)
//                       .textTheme
//                       .headlineSmall!
//                       .copyWith(fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: constraints.maxHeight * 0.05),
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           hintText: 'Full name',
//                           filled: true,
//                           fillColor: Color(0xFFF5FCF9),
//                           contentPadding: EdgeInsets.symmetric(
//                               horizontal: 16.0 * 1.5, vertical: 16.0),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.all(Radius.circular(50)),
//                           ),
//                         ),
//                         onSaved: (name) {
//                           // Save it
//                         },
//                       ),
//                       const SizedBox(height: 16.0),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           hintText: 'Phone',
//                           filled: true,
//                           fillColor: Color(0xFFF5FCF9),
//                           contentPadding: EdgeInsets.symmetric(
//                               horizontal: 16.0 * 1.5, vertical: 16.0),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.all(Radius.circular(50)),
//                           ),
//                         ),
//                         keyboardType: TextInputType.phone,
//                         onSaved: (phone) {
//                           // Save it
//                         },
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 16.0),
//                         child: TextFormField(
//                           decoration: const InputDecoration(
//                             hintText: 'Password',
//                             filled: true,
//                             fillColor: Color(0xFFF5FCF9),
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 16.0 * 1.5, vertical: 16.0),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide.none,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(50)),
//                             ),
//                           ),
//                           obscureText: true,
//                           onSaved: (passaword) {
//                             // Save it
//                           },
//                         ),
//                       ),
//                       DropdownButtonFormField(
//                         items: countries,
//                         icon: const Icon(Icons.expand_more),
//                         onSaved: (country) {
//                           // save it
//                         },
//                         onChanged: (value) {},
//                         decoration: const InputDecoration(
//                           hintText: 'Country',
//                           filled: true,
//                           fillColor: Color(0xFFF5FCF9),
//                           contentPadding: EdgeInsets.symmetric(
//                               horizontal: 16.0 * 1.5, vertical: 16.0),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.all(Radius.circular(50)),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 16.0),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               _formKey.currentState!.save();
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             elevation: 0,
//                             backgroundColor: const Color(0xFF00BF6D),
//                             foregroundColor: Colors.white,
//                             minimumSize: const Size(double.infinity, 48),
//                             shape: const StadiumBorder(),
//                           ),
//                           child: const Text("Sign Up"),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: Text.rich(
//                           const TextSpan(
//                             text: "Already have an account? ",
//                             children: [
//                               TextSpan(
//                                 text: "Sign in",
//                                 style: TextStyle(color: Color(0xFF00BF6D)),
//                               ),
//                             ],
//                           ),
//                           style:
//                               Theme.of(context).textTheme.bodyMedium!.copyWith(
//                                     color: Theme.of(context)
//                                         .textTheme
//                                         .bodyLarge!
//                                         .color!
//                                         .withOpacity(0.64),
//                                   ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

// // only for demo
// List<DropdownMenuItem<String>>? countries = [
//   "Bangladesh",
//   "Switzerland",
//   'Canada',
//   'Japan',
//   'Germany',
//   'Australia',
//   'Sweden',
// ].map<DropdownMenuItem<String>>((String value) {
//   return DropdownMenuItem<String>(value: value, child: Text(value));
// }).toList();
