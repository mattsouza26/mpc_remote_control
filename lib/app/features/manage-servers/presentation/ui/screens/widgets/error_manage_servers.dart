import 'package:flutter/material.dart';

class ErrorManageServers extends StatelessWidget {
  const ErrorManageServers({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.075,
            width: MediaQuery.of(context).size.width,
          ),
          // Icon(Icons.monitor_rounded, size: MediaQuery.of(context).size.height * 0.2),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Theme.of(context).textTheme.headlineSmall?.color?.withOpacity(0.8) ?? Colors.white,
              BlendMode.srcIn,
            ),
            child: const Image(
              height: 230,
              image: AssetImage("lib/app/core/assets/images/manage-servers/error_servers.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(height: 30),

          FittedBox(
            child: Column(
              children: [
                Text(
                  "Oops! Something went wrong",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Unable to find the MPC server try again or adding one.",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
