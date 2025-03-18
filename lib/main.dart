import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(const UniverseOracleApp());
}

class UniverseOracleApp extends StatelessWidget {
  const UniverseOracleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UniversePage(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FFDD),
          secondary: Color(0xFFA353FF),
          tertiary: Color(0xFFFF3D81),
          background: Colors.black,
        ),
        useMaterial3: true,
      ),
    );
  }
}

class UniversePage extends StatefulWidget {
  @override
  State<UniversePage> createState() => _UniversePageState();
}

class _UniversePageState extends State<UniversePage> with SingleTickerProviderStateMixin {
  late AnimationController _backgroundController;
  bool _hasInteracted = false;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        children: [
          // Universe background
          UniverseBackground(controller: _backgroundController),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Title with futuristic design
                AnimatedOpacity(
                  opacity: _hasInteracted ? 0.0 : 1.0,
                  duration: 800.ms,
                  child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        Text(
                          "UNIVERSE",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 12,
                            color: Theme.of(context).colorScheme.primary,
                            shadows: [
                              Shadow(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                                blurRadius: 30,
                              ),
                            ],
                          ),
                        ).animate().fadeIn(duration: 1200.ms, curve: Curves.easeOutQuint),

                        const SizedBox(height: 8),

                        Text(
                          "ORACLE",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 24,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ).animate().fadeIn(duration: 1200.ms, delay: 400.ms, curve: Curves.easeOutQuint),
                      ],
                    ),
                  ),
                ),

                // Main oracle
                Expanded(
                  child: OracleCore(
                    onInteractionStart: () {
                      setState(() {
                        _hasInteracted = true;
                      });
                    },
                    onInteractionEnd: () {
                      setState(() {
                        _hasInteracted = false;
                      });
                    },
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

class UniverseBackground extends StatelessWidget {
  final AnimationController controller;

  const UniverseBackground({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base black background
        Container(color: Colors.black),

        // Deep space nebula effect
        AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return CustomPaint(
              painter: NebulaPainter(controller.value),
              size: Size.infinite,
            );
          },
        ),

        // Distant stars
        AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return CustomPaint(
              painter: StarsBackgroundPainter(controller.value),
              size: Size.infinite,
            );
          },
        ),

        // Light glow from center
        Center(
          child: Container(
            width: 600,
            height: 600,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.3, 1.0],
              ),
            ),
          ),
        ),

        // Overlay gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.7),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}

class OracleCore extends StatefulWidget {
  final VoidCallback onInteractionStart;
  final VoidCallback onInteractionEnd;

  const OracleCore({
    super.key,
    required this.onInteractionStart,
    required this.onInteractionEnd,
  });

  @override
  State<OracleCore> createState() => _OracleCoreState();
}

class _OracleCoreState extends State<OracleCore> with TickerProviderStateMixin {
  late AnimationController _coreAnimationController;
  late AnimationController _pulseController;
  late AnimationController _orbitController;
  late AnimationController _interactionController;

  bool _isExpanded = false;
  bool _isThinking = false;
  String _currentPrediction = "";

  final List<String> _predictions = [
    "Les étoiles s'alignent en votre faveur",
    "Le destin vous sourit aujourd'hui",
    "Attendez-vous à l'inattendu",
    "L'avenir est brillant et prometteur",
    "Une opportunité unique se présente à vous",
    "Vous êtes sur le point de faire une découverte",
    "Le succès est à portée de main",
    "Les choix d'aujourd'hui façonnent demain",
    "Votre créativité atteindra de nouveaux sommets",
    "Le moment est venu de prendre des risques",
    "L'univers travaille en votre faveur",
    "Regardez au-delà des apparences",
    "Vos efforts seront bientôt récompensés",
    "Un changement positif est imminent",
    "Faites confiance à votre intuition",
    "Une rencontre va changer votre perspective",
    "Une vérité cachée sera bientôt révélée",
    "Le chemin s'éclaircit devant vous",
    "Un nouveau cycle commence",
    "L'énergie cosmique vous entoure",
  ];

  @override
  void initState() {
    super.initState();
    _coreAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    _interactionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
  }

  @override
  void dispose() {
    _coreAnimationController.dispose();
    _pulseController.dispose();
    _orbitController.dispose();
    _interactionController.dispose();
    super.dispose();
  }

  void _startInteraction() async {
    widget.onInteractionStart();

    setState(() {
      _isThinking = true;
    });

    // Reset interaction animation
    _interactionController.reset();

    // Start intense animation
    _interactionController.forward();

    // Simulate "thinking" time
    await Future.delayed(const Duration(milliseconds: 2000));

    // Generate prediction
    setState(() {
      _currentPrediction = _predictions[Random().nextInt(_predictions.length)];
      _isExpanded = true;
      _isThinking = false;
    });

    // Auto-hide prediction after some time
    await Future.delayed(const Duration(seconds: 5));

    setState(() {
      _isExpanded = false;
    });

    await Future.delayed(const Duration(milliseconds: 800));

    widget.onInteractionEnd();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isThinking ? null : _startInteraction,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ambient particles
          AnimatedBuilder(
            animation: _coreAnimationController,
            builder: (context, child) {
              return CustomPaint(
                painter: AmbientParticlesPainter(
                  time: _coreAnimationController.value,
                  intensity: _interactionController.value,
                ),
                size: Size.infinite,
              );
            },
          ),

          // Energy rings
          ...List.generate(3, (index) {
            return AnimatedBuilder(
              animation: Listenable.merge([_pulseController, _interactionController]),
              builder: (context, child) {
                final interactionBoost = _interactionController.value * 40;
                final rotationAngle = _interactionController.value * pi * (index + 1) * 2;

                final baseSize = 300.0 + (index * 40) + (_pulseController.value * 30) + interactionBoost;
                final opacity = min(1.0, max(0.0, (0.3 - (index * 0.08)) * (1 + _interactionController.value)));

                return Transform.rotate(
                  angle: rotationAngle,
                  child: Container(
                    width: baseSize,
                    height: baseSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: HSLColor.fromAHSL(
                          opacity,
                          (220 + index * 40) % 360,
                          0.8,
                          0.6,
                        ).toColor(),
                        width: 1.5 + (_interactionController.value * 1.5),
                      ),
                    ),
                  ),
                );
              },
            );
          }),

          // Orbiting elements
          AnimatedBuilder(
            animation: Listenable.merge([_orbitController, _interactionController]),
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: List.generate(12, (index) {
                  final baseAngle = (_orbitController.value * 2 * pi) + (index * (2 * pi / 12));
                  final interactionSpeed = 1.0 + (_interactionController.value * 5);
                  final angle = baseAngle * interactionSpeed;

                  final distance = 180.0 + (_interactionController.value * 20);
                  final x = cos(angle) * distance;
                  final y = sin(angle) * distance;

                  final baseSize = 4.0 + (index % 3) * 2.0;
                  final sizeBoost = _interactionController.value * 4;

                  return Transform.translate(
                    offset: Offset(x, y),
                    child: Container(
                      width: baseSize + sizeBoost,
                      height: baseSize + sizeBoost,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: HSLColor.fromAHSL(
                          0.9,
                          (index * 30) % 360,
                          0.8,
                          0.6,
                        ).toColor(),
                        boxShadow: [
                          BoxShadow(
                            color: HSLColor.fromAHSL(
                              min(0.8, max(0.0, 0.8)),
                              (index * 30) % 360,
                              0.8,
                              0.6,
                            ).toColor().withOpacity(min(0.8, max(0.0, 0.8))),
                            blurRadius: 10 + (_interactionController.value * 10),
                            spreadRadius: 2 + (_interactionController.value * 4),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            },
          ),

          // Core sphere
          AnimatedBuilder(
            animation: Listenable.merge([_pulseController, _interactionController]),
            builder: (context, child) {
              final baseScale = 1.0 + (_pulseController.value * 0.05);
              final interactionScale = 1.0 + (_interactionController.value * 0.3);

              return Transform.scale(
                scale: baseScale * interactionScale,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(min(1.0, max(0.0, 0.5 + (_interactionController.value * 0.5)))),
                        blurRadius: 40 + (_interactionController.value * 60),
                        spreadRadius: 5 + (_interactionController.value * 15),
                      ),
                    ],
                    gradient: RadialGradient(
                      colors: [
                        HSLColor.fromColor(Theme.of(context).colorScheme.primary)
                            .withLightness(min(1.0, max(0.0, 0.7 + (_interactionController.value * 0.3))))
                            .toColor()
                            .withOpacity(0.9),
                        HSLColor.fromColor(Theme.of(context).colorScheme.secondary)
                            .withLightness(min(1.0, max(0.0, 0.5 + (_interactionController.value * 0.2))))
                            .toColor()
                            .withOpacity(0.6),
                        Colors.black.withOpacity(min(0.8, max(0.0, 0.8 - (_interactionController.value * 0.3)))),
                      ],
                      stops: const [0.0, 0.4, 1.0],
                      radius: 0.8,
                    ),
                  ),
                  child: Center(
                    child: _buildCoreSymbol(),
                  ),
                ),
              );
            },
          ),

          // Prediction panel that slides up from bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: 800.ms,
              curve: Curves.easeOutExpo,
              height: _isExpanded ? 160 : 0,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 0.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    blurRadius: 30,
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: Center(
                child: _isExpanded
                    ? Text(
                  _currentPrediction,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    letterSpacing: 1.2,
                    height: 1.4,
                    shadows: [
                      Shadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 800.ms).slide()
                    : const SizedBox(),
              ),
            ),
          ),

          // Touch instruction
          if (!_isThinking && !_isExpanded)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "TOUCHEZ L'ORACLE",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 8,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .fadeIn(duration: 1000.ms)
                    .then()
                    .fadeOut(duration: 1000.ms),
              ),
            ),

          // Thinking indicator
          if (_isThinking)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    _buildThinkingIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      "ANALYSE EN COURS...",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 4,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCoreSymbol() {
    return AnimatedBuilder(
      animation: Listenable.merge([_coreAnimationController, _interactionController]),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Inner glowing circle
            Container(
              width: 100 + (_interactionController.value * 20),
              height: 100 + (_interactionController.value * 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(min(1.0, 0.8 * (1 + _interactionController.value))),
                    Colors.white.withOpacity(min(1.0, 0.1 * (1 + _interactionController.value))),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.2, 1.0],
                ),
              ),
            ),

            // Cosmic symbol
            CustomPaint(
              painter: CosmicSymbolPainter(
                time: _coreAnimationController.value,
                intensity: _interactionController.value,
              ),
              size: const Size(120, 120),
            ),

            // Energy points
            ...List.generate(8, (index) {
              final angle = (index / 8) * 2 * pi;
              final distance = 40.0 + (_interactionController.value * 10);
              final x = cos(angle) * distance;
              final y = sin(angle) * distance;

              final baseOpacity = 0.7;
              final interactionOpacity = _interactionController.value * 0.3;
              final finalOpacity = min(1.0, max(0.0, baseOpacity + interactionOpacity));

              return Positioned(
                left: 60 + x - (5 / 2),
                top: 60 + y - (5 / 2),
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(finalOpacity),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(min(0.8, max(0.0, 0.8))),
                        blurRadius: 10 + (_interactionController.value * 10),
                        spreadRadius: 2 + (_interactionController.value * 3),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildThinkingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
          ).animate(
            onPlay: (controller) => controller.repeat(),
          ).scaleY(
            begin: 0.5,
            end: 1.5,
            duration: 600.ms,
            delay: (index * 100).ms,
            curve: Curves.easeInOut,
          ).then().scaleY(
            begin: 1.5,
            end: 0.5,
            duration: 600.ms,
            curve: Curves.easeInOut,
          ),
        );
      }),
    );
  }
}

class StarsBackgroundPainter extends CustomPainter {
  final double time;
  final Random random = Random(42);
  final List<Star> stars = [];

  StarsBackgroundPainter(this.time) {
    if (stars.isEmpty) {
      for (int i = 0; i < 200; i++) {
        stars.add(Star(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: random.nextDouble() * 1.5 + 0.5,
          blinkSpeed: random.nextDouble() * 2 + 0.5,
          color: HSLColor.fromAHSL(
            1.0,
            random.nextDouble() * 360,
            random.nextDouble() * 0.5,
            random.nextDouble() * 0.3 + 0.7,
          ).toColor(),
        ));
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in stars) {
      final blinkFactor = min(1.0, max(0.0, (sin(time * star.blinkSpeed * 2 * pi) * 0.5) + 0.5));
      final starPaint = Paint()
        ..color = star.color.withOpacity(blinkFactor)
        ..style = PaintingStyle.fill;

      // Add slight glow for larger stars
      if (star.size > 1.0) {
        final glowPaint = Paint()
          ..color = star.color.withOpacity(min(1.0, max(0.0, blinkFactor * 0.5)))
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

        canvas.drawCircle(
          Offset(star.x * size.width, star.y * size.height),
          star.size * 2,
          glowPaint,
        );
      }

      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.size,
        starPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant StarsBackgroundPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}

class NebulaPainter extends CustomPainter {
  final double time;
  final Random random = Random(42);
  final List<NebulaCloud> clouds = [];

  NebulaPainter(this.time) {
    if (clouds.isEmpty) {
      for (int i = 0; i < 5; i++) {
        clouds.add(NebulaCloud(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: random.nextDouble() * 0.5 + 0.5,
          speed: random.nextDouble() * 0.005,
          hue: random.nextDouble() * 120 + 180, // Blues to purples
        ));
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final cloud in clouds) {
      final x = (cloud.x + time * cloud.speed) % 1.0;
      final y = cloud.y;
      final cloudSize = cloud.size * min(size.width, size.height) * 0.8;

      final gradient = RadialGradient(
        center: Alignment.center,
        radius: 1.0,
        colors: [
          HSLColor.fromAHSL(min(1.0, 0.2), cloud.hue, 0.8, 0.5).toColor(),
          HSLColor.fromAHSL(min(1.0, 0.05), cloud.hue, 0.8, 0.5).toColor(),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(
        center: Offset(x * size.width, y * size.height),
        radius: cloudSize,
      ));

      final cloudPaint = Paint()
        ..shader = gradient
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(x * size.width, y * size.height),
        cloudSize,
        cloudPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant NebulaPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}

class AmbientParticlesPainter extends CustomPainter {
  final double time;
  final double intensity;
  final Random random = Random(42);
  final List<Particle> particles = [];

  AmbientParticlesPainter({required this.time, required this.intensity}) {
    if (particles.isEmpty) {
      for (int i = 0; i < 100; i++) {
        particles.add(Particle(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: random.nextDouble() * 2 + 1,
          speed: random.nextDouble() * 0.01 + 0.005,
          color: HSLColor.fromAHSL(
            min(1.0, random.nextDouble() * 0.5 + 0.2),
            random.nextDouble() * 60 + 200, // Blues and cyans
            0.8,
            0.6,
          ).toColor(),
        ));
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Center point of the canvas
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    for (final particle in particles) {
      // Calculate moving position with time
      final angle = time * 2 * pi * particle.speed;
      final radius = 0.3 + (intensity * 0.1); // Expand radius during interaction

      // Swirl particles around center
      final swirl = intensity * 3; // More swirl during interaction
      final spiralX = particle.x + (sin(angle * particle.speed * 10) * radius * 0.1);
      final spiralY = particle.y + (cos(angle * particle.speed * 10) * radius * 0.1);

      // Attract particles toward center during interaction
      final attractX = centerX - (centerX * spiralX);
      final attractY = centerY - (centerY * spiralY);

      final x = spiralX * size.width + (attractX * intensity * 0.1);
      final y = spiralY * size.height + (attractY * intensity * 0.1);

      // Increase size and opacity with interaction intensity
      final sizeMultiplier = 1.0 + (intensity * 2.0);
      final opacityMultiplier = 1.0 + (intensity * 0.5);

      final particlePaint = Paint()
        ..color = particle.color.withOpacity(
            min(1.0, max(0.0, particle.color.opacity * opacityMultiplier))
        )
        ..style = PaintingStyle.fill;

      // Add glow effect
      if (intensity > 0.1) {
        final glowPaint = Paint()
          ..color = particle.color.withOpacity(min(1.0, max(0.0, intensity * 0.3)))
          ..style = PaintingStyle.fill
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5 * intensity);

        canvas.drawCircle(
          Offset(x, y),
          particle.size * sizeMultiplier * 3,
          glowPaint,
        );
      }

      canvas.drawCircle(
        Offset(x, y),
        particle.size * sizeMultiplier,
        particlePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant AmbientParticlesPainter oldDelegate) {
    return oldDelegate.time != time || oldDelegate.intensity != intensity;
  }
}

class CosmicSymbolPainter extends CustomPainter {
  final double time;
  final double intensity;

  CosmicSymbolPainter({required this.time, required this.intensity});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = size.width * 0.3;

    // Create path for cosmic symbol (sacred geometry)
    final path = Path();

    // Parameters adjusted by intensity
    final rings = 3;
    final pointsPerRing = 8;
    final radiusStep = baseRadius / rings;

    for (int ring = 1; ring <= rings; ring++) {
      final radius = radiusStep * ring;
      final rotationOffset = time * pi * 2 + (intensity * pi);

      for (int point = 0; point < pointsPerRing; point++) {
        final angle = (point / pointsPerRing * pi * 2) + rotationOffset;
        final x = center.dx + cos(angle) * radius;
        final y = center.dy + sin(angle) * radius;

        final nextPoint = (point + 1) % pointsPerRing;
        final nextAngle = (nextPoint / pointsPerRing * pi * 2) + rotationOffset;
        final nextX = center.dx + cos(nextAngle) * radius;
        final nextY = center.dy + sin(nextAngle) * radius;

        // Connect points within the same ring
        path.moveTo(x, y);
        path.lineTo(nextX, nextY);

        // Connect to inner ring
        if (ring > 1) {
          final innerRadius = radiusStep * (ring - 1);
          final innerX = center.dx + cos(angle) * innerRadius;
          final innerY = center.dy + sin(angle) * innerRadius;

          path.moveTo(x, y);
          path.lineTo(innerX, innerY);
        }

        // Add points as small circles
        final pointRadius = 2.0 + (intensity * 2.0);
        canvas.drawCircle(
          Offset(x, y),
          pointRadius,
          Paint()
            ..color = Colors.white.withOpacity(min(1.0, max(0.0, 0.8 + (intensity * 0.2))))
            ..style = PaintingStyle.fill,
        );
      }
    }

    // Draw the connecting lines
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white.withOpacity(min(1.0, max(0.0, 0.3 + (intensity * 0.4))))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5 + (intensity * 1.5),
    );

    // Add central circle
    canvas.drawCircle(
      center,
      10 + (intensity * 5),
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );

    // Add glow to center
    if (intensity > 0.1) {
      canvas.drawCircle(
        center,
        15 + (intensity * 15),
        Paint()
          ..color = Colors.white.withOpacity(min(1.0, max(0.0, intensity * 0.8)))
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CosmicSymbolPainter oldDelegate) {
    return oldDelegate.time != time || oldDelegate.intensity != intensity;
  }
}

class Star {
  final double x;
  final double y;
  final double size;
  final double blinkSpeed;
  final Color color;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.blinkSpeed,
    required this.color,
  });
}

class NebulaCloud {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double hue;

  NebulaCloud({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.hue,
  });
}

class Particle {
  final double x;
  final double y;
  final double size;
  final double speed;
  final Color color;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.color,
  });
}