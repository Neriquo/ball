import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const ModernOracleApp());
}

class ModernOracleApp extends StatelessWidget {
  const ModernOracleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OraclePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6C63FF),
          secondary: Color(0xFF00F5FF),
          tertiary: Color(0xFFFF4081),
          background: Colors.black,
        ),
        useMaterial3: true,
      ),
    );
  }
}

class OraclePage extends StatefulWidget {
  @override
  State<OraclePage> createState() => _OraclePageState();
}

class _OraclePageState extends State<OraclePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF101010),
              Color(0xFF000000),
            ],
          ),
        ),
        child: const SafeArea(
          child: ModernOracle(),
        ),
      ),
    );
  }
}

class ModernOracle extends StatefulWidget {
  const ModernOracle({super.key});

  @override
  State<ModernOracle> createState() => _ModernOracleState();
}

class _ModernOracleState extends State<ModernOracle> with TickerProviderStateMixin {
  int responseIndex = 1;
  bool isAnimating = false;
  bool isExpanded = false;
  final List<String> responses = [
    "C'est certain",
    "Sans aucun doute",
    "Oui définitivement",
    "Vous pouvez compter dessus",
    "Très probablement",
    "Les perspectives sont bonnes",
    "Les signes indiquent que oui",
    "Réponse floue, essayez à nouveau",
    "Redemandez plus tard",
    "Mieux vaut ne pas vous le dire",
    "Impossible de prédire maintenant",
    "Concentrez-vous et redemandez",
    "N'y comptez pas",
    "Ma réponse est non",
    "Mes sources disent non",
    "Les perspectives ne sont pas bonnes",
    "Très peu probable"
  ];
  late AnimationController _pulseController;
  late AnimationController _rotateController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 100),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  void generateResponse() {
    setState(() {
      isAnimating = true;
      isExpanded = true;
      responseIndex = Random().nextInt(responses.length);
    });

    Future.delayed(800.ms, () {
      setState(() {
        isAnimating = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ORACLE",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 8,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ).animate().fadeIn(duration: 800.ms).then().slide(),
            ],
          ),
        ),

        // Main content
        Expanded(
          child: GestureDetector(
            onTap: generateResponse,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Particle background
                  AnimatedBuilder(
                    animation: _rotateController,
                    builder: (context, child) {
                      return CustomPaint(
                        size: Size(MediaQuery.of(context).size.width, 400),
                        painter: ParticlePainter(_rotateController.value),
                      );
                    },
                  ),

                  // Animated rings
                  ...List.generate(3, (index) {
                    return AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        final size = 300.0 + (index * 40) + (_pulseController.value * 30);
                        final opacity = 0.3 - (index * 0.08);
                        return Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary.withOpacity(opacity),
                              width: 1.5,
                            ),
                          ),
                        );
                      },
                    );
                  }),

                  // Main oracle sphere
                  AnimatedContainer(
                    duration: 800.ms,
                    curve: Curves.easeOutBack,
                    width: isAnimating ? 220 : 200,
                    height: isAnimating ? 220 : 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                          blurRadius: 40,
                          spreadRadius: 5,
                        ),
                      ],
                      gradient: RadialGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary.withOpacity(0.9),
                          Theme.of(context).colorScheme.primary.withOpacity(0.6),
                          Colors.black.withOpacity(0.8),
                        ],
                        stops: const [0.0, 0.4, 1.0],
                        radius: 0.8,
                      ),
                    ),
                    child: AnimatedScale(
                      scale: isAnimating ? 1.3 : 1.0,
                      duration: 400.ms,
                      curve: Curves.easeOutBack,
                      child: Center(
                        child: _buildInnerContent(),
                      ),
                    ),
                  ).animate(target: isAnimating ? 1 : 0)
                      .shimmer(duration: 1000.ms, delay: 200.ms, color: Colors.white.withOpacity(0.8))
                      .then()
                      .rotate(begin: 0, end: 0.05, duration: 100.ms)
                      .then()
                      .rotate(begin: 0.05, end: -0.05, duration: 200.ms)
                      .then()
                      .rotate(begin: -0.05, end: 0, duration: 100.ms),
                ],
              ),
            ),
          ),
        ),

        // Response display
        AnimatedContainer(
          duration: 500.ms,
          curve: Curves.easeOutQuint,
          height: isExpanded ? 180 : 0,
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.4),
                Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: -5,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Divider with interactive shape
              Container(
                width: 60,
                height: 5,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),

              // Response text
              if (isExpanded)
                Text(
                  responses[responseIndex],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1,
                    height: 1.4,
                    shadows: [
                      Shadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slide(begin: const Offset(0, 0.2), end: const Offset(0, 0)),
            ],
          ),
        ),

        // Interactive hint
        if (!isExpanded)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              "TOUCHEZ L'ORACLE POUR RÉVÉLER",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 2,
                color: Colors.white.withOpacity(0.6),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                .fadeIn(duration: 1000.ms)
                .then()
                .fadeOut(duration: 1000.ms),
          ),
      ],
    );
  }

  Widget _buildInnerContent() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Inner circle
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.9),
              ],
            ),
          ),
        ),

        // Animated icon
        Icon(
          Icons.question_mark_rounded,
          size: 60,
          color: Colors.white.withOpacity(0.7),
        ).animate(target: isAnimating ? 1 : 0, onPlay: (controller) => controller.repeat(reverse: true, period: 3.seconds))
            .fadeIn(duration: 1000.ms)
            .then()
            .fadeOut(duration: 1000.ms, curve: Curves.easeIn),

        // Glowing circles
        ...List.generate(8, (index) {
          final angle = (index / 8) * 2 * pi;
          final distance = 70.0;
          final x = cos(angle) * distance;
          final y = sin(angle) * distance;

          return Positioned(
            left: 65 + x,
            top: 65 + y,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                final delayed = (_pulseController.value + (index / 8)) % 1.0;
                final size = 4 + (delayed * 4);

                return Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: HSLColor.fromAHSL(
                      0.8,
                      (index * 30) % 360,
                      0.8,
                      0.6,
                    ).toColor(),
                    boxShadow: [
                      BoxShadow(
                        color: HSLColor.fromAHSL(
                          0.8,
                          (index * 30) % 360,
                          0.8,
                          0.6,
                        ).toColor().withOpacity(0.8),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}

// Custom painter to draw animated particles
class ParticlePainter extends CustomPainter {
  final double time;
  final Random random = Random(42);
  final List<Particle> particles = [];

  ParticlePainter(this.time) {
    if (particles.isEmpty) {
      for (int i = 0; i < 80; i++) {
        particles.add(Particle(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: random.nextDouble() * 3 + 1,
          color: HSLColor.fromAHSL(
            random.nextDouble() * 0.5 + 0.3,
            random.nextDouble() * 60 + 200, // Mostly blues and purples
            random.nextDouble() * 0.5 + 0.5,
            random.nextDouble() * 0.5 + 0.5,
          ).toColor(),
          speed: random.nextDouble() * 0.02 + 0.005,
        ));
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final x = (particle.x + time * particle.speed) % 1.0;
      final y = particle.y;

      final paint = Paint()
        ..color = particle.color.withOpacity((sin(time * 2 * pi * particle.speed * 5) * 0.3) + 0.7)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(x * size.width, y * size.height),
        particle.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) {
    return oldDelegate.time != time;
  }
}

class Particle {
  final double x;
  final double y;
  final double size;
  final Color color;
  final double speed;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.color,
    required this.speed,
  });
}