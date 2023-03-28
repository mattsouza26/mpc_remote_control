import 'package:flutter/material.dart';

class DiscoverLoading extends StatelessWidget {
  const DiscoverLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
          ),
          // Icon(Icons.monitor_rounded, size: MediaQuery.of(context).size.height * 0.2),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Theme.of(context).textTheme.headlineSmall?.color ?? Colors.white,
              BlendMode.srcIn,
            ),
            child: const Image(
              height: 100,
              image: AssetImage("lib/app/core/assets/images/manage-servers/searching_servers.png"),
              fit: BoxFit.none,
            ),
          ),
          const SizedBox(height: 30),

          FittedBox(
            child: Column(
              children: [
                Text(
                  "Searching...",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Please ensure your MPC is running and Web Interface is switched on.",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500],
                      ),
                ),
                Text(
                  "This may take a few moments.",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
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
