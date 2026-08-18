import 'package:flutter/material.dart';

class Experiment3Screen extends StatelessWidget {
  const Experiment3Screen({super.key});

  // ------------------------------------------------------------
  // Breakpoint
  // Mobile  : < 600 dp
  // Tablet/Web : >= 600 dp
  // ------------------------------------------------------------
  static const double tabletBreakpoint = 600;

  @override
  Widget build(BuildContext context) {
    // ----------------------------------------------------------
    // MediaQuery
    // ----------------------------------------------------------
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(title: const Text('Experiment 3 - Responsive FocusFlow')),

      body: Column(
        children: [
          // ----------------------------------------------------
          // STACK
          // ----------------------------------------------------
          _buildScreenInfoBanner(screenWidth, screenHeight, orientation),

          // ----------------------------------------------------
          // LAYOUT BUILDER
          // ----------------------------------------------------
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= tabletBreakpoint) {
                  return _buildTabletLayout();
                } else {
                  return _buildMobileLayout();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STACK BANNER
  // ============================================================

  Widget _buildScreenInfoBanner(
    double width,
    double height,
    Orientation orientation,
  ) {
    return SizedBox(
      height: 115,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.indigo],
              ),
            ),
          ),

          // Title
          const Positioned(
            left: 18,
            top: 15,
            child: Text(
              'FocusFlow Responsive UI',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Screen information
          Positioned(
            left: 18,
            bottom: 15,
            child: Text(
              'Width: ${width.toStringAsFixed(0)} dp   •   '
              'Height: ${height.toStringAsFixed(0)} dp   •   '
              '${orientation.name}',
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MOBILE LAYOUT
  // Column
  // ============================================================

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          const Text(
            'Mobile Layout',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          // ----------------------------------------------------
          // Card 1
          // ----------------------------------------------------
          _buildInfoCard(
            icon: Icons.task_alt,
            title: 'Tasks',
            value: '12 Tasks',
            description: 'Manage your daily tasks',
            color: Colors.blue,
          ),

          const SizedBox(height: 12),

          // ----------------------------------------------------
          // Card 2
          // ----------------------------------------------------
          _buildInfoCard(
            icon: Icons.track_changes,
            title: 'Habits',
            value: '5 Habits',
            description: 'Track your daily habits',
            color: Colors.green,
          ),

          const SizedBox(height: 12),

          // ----------------------------------------------------
          // Card 3
          // ----------------------------------------------------
          _buildInfoCard(
            icon: Icons.timer,
            title: 'Focus Sessions',
            value: '8 Sessions',
            description: 'Improve your productivity',
            color: Colors.deepPurple,
          ),

          const SizedBox(height: 24),

          // WRAP
          _buildWrapSection(),

          const SizedBox(height: 24),

          // ORIENTATION BUILDER
          _buildOrientationGrid(),
        ],
      ),
    );
  }

  // ============================================================
  // TABLET / WEB LAYOUT
  // Row + Expanded
  // ============================================================

  Widget _buildTabletLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            'Tablet / Web Layout',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          // ----------------------------------------------------
          // ROW + EXPANDED
          // ----------------------------------------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Expanded(
                child: _buildInfoCard(
                  icon: Icons.task_alt,
                  title: 'Tasks',
                  value: '12 Tasks',
                  description: 'Manage your daily tasks',
                  color: Colors.blue,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: _buildInfoCard(
                  icon: Icons.track_changes,
                  title: 'Habits',
                  value: '5 Habits',
                  description: 'Track your daily habits',
                  color: Colors.green,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: _buildInfoCard(
                  icon: Icons.timer,
                  title: 'Focus Sessions',
                  value: '8 Sessions',
                  description: 'Improve your productivity',
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // WRAP
          _buildWrapSection(),

          const SizedBox(height: 28),

          // ORIENTATION BUILDER
          _buildOrientationGrid(),
        ],
      ),
    );
  }

  // ============================================================
  // INFO CARD
  // ============================================================

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required String description,
    required Color color,
  }) {
    return Card(
      elevation: 4,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      child: Container(
        constraints: const BoxConstraints(minHeight: 150),

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: color.withOpacity(0.08),

          borderRadius: BorderRadius.circular(16),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          mainAxisSize: MainAxisSize.min,

          children: [
            // Icon
            Icon(icon, size: 34, color: color),

            const SizedBox(height: 10),

            // Title
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            // Value
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 6),

            // ------------------------------------------------
            // FIX:
            // Do NOT use Flexible here.
            // The card is inside SingleChildScrollView.
            // ------------------------------------------------
            Text(
              description,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // WRAP
  // ============================================================

  Widget _buildWrapSection() {
    const categories = [
      'Flutter',
      'Dart',
      'Tasks',
      'Habits',
      'Focus',
      'Productivity',
      'Responsive',
      'Adaptive',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          'Technologies & Features',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 10),

        // ----------------------------------------------------
        // WRAP
        // Automatically moves chips to next line
        // ----------------------------------------------------
        Wrap(
          spacing: 8,
          runSpacing: 8,

          children: categories.map((category) {
            return Chip(
              label: Text(category),
              avatar: const Icon(Icons.check_circle_outline, size: 18),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ============================================================
  // ORIENTATION BUILDER
  //
  // Portrait  -> 2 columns
  // Landscape -> 4 columns
  // ============================================================

  Widget _buildOrientationGrid() {
    return OrientationBuilder(
      builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'Orientation Grid',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              isPortrait ? 'Portrait: 2 columns' : 'Landscape: 4 columns',
              style: TextStyle(color: Colors.grey.shade600),
            ),

            const SizedBox(height: 12),

            // ------------------------------------------------
            // GRID
            // ------------------------------------------------
            GridView.builder(
              shrinkWrap: true,

              physics: const NeverScrollableScrollPhysics(),

              itemCount: 8,

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isPortrait ? 2 : 4,

                crossAxisSpacing: 10,

                mainAxisSpacing: 10,

                childAspectRatio: 1.6,
              ),

              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,

                    borderRadius: BorderRadius.circular(12),

                    border: Border.all(color: Colors.deepPurple.shade100),
                  ),

                  alignment: Alignment.center,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      const Icon(Icons.dashboard, color: Colors.deepPurple),

                      const SizedBox(height: 5),

                      Text(
                        'Item ${index + 1}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
