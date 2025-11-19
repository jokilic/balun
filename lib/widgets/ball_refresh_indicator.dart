import 'dart:math' as math;

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../theme/icons.dart';
import 'balun_image.dart';

extension GetRandomFromList<T> on List<T> {
  T get random => this[math.Random().nextInt(length)];
}

class ShakeState {
  final bool isInitial;
  final Offset shift;

  ShakeState({
    required this.shift,
    required this.isInitial,
  });
}

class BallRefreshIndicator extends StatefulWidget {
  final Widget child;
  final AsyncCallback onRefresh;
  final double acceleration;
  final double ballRadius;
  final double shakeOffset;
  final List<Color> ballColors;
  final double strokeWidth;
  final IndicatorController? controller;
  final Color backgroundColor;
  final Color ballBorderColor;
  final Color arrowColor;

  const BallRefreshIndicator({
    required this.child,
    required this.onRefresh,
    required this.backgroundColor,
    required this.ballBorderColor,
    required this.arrowColor,
    this.acceleration = 1.2,
    this.ballRadius = 25.0,
    this.strokeWidth = 3.0,
    this.shakeOffset = 4.0,
    this.ballColors = const [Colors.blue],
    this.controller,
    super.key,
  }) : assert(
         ballColors.length > 0,
         'ballColors cannot be empty.',
       );

  @override
  State<BallRefreshIndicator> createState() => _BallRefreshIndicatorState();
}

class _BallRefreshIndicatorState extends State<BallRefreshIndicator> with TickerProviderStateMixin {
  IndicatorController? internalIndicatorController;
  IndicatorController get controller => widget.controller ?? (internalIndicatorController ??= IndicatorController());

  late final Ticker ticker;
  final ballPosition = ValueNotifier<Offset>(Offset.zero);

  Offset direction = Offset.zero;
  double lastAngle = 0;
  Size rectSize = Size.zero;
  late Color ballColor;

  late final shakeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 50),
  );
  late final arrowOpacityController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );
  late final centerController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  ShakeState shakeState = ShakeState(shift: Offset.zero, isInitial: true);

  @override
  void initState() {
    ballColor = widget.ballColors.length > 1 ? widget.ballColors.random : widget.ballColors.first;

    ticker = createTicker(onTick);
    shakeController.addStatusListener(onShakeStatusChanged);
    centerController.addListener(onCenterChanged);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant BallRefreshIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller && widget.controller != null) {
      internalIndicatorController?.dispose();
      internalIndicatorController = null;
    }

    assert(
      widget.controller == null || (widget.controller != null && internalIndicatorController == null),
      'An internal indicator should not exist when an external indicator is provided.',
    );
  }

  void onShakeStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed && shakeState.isInitial) {
      shakeState = ShakeState(shift: shakeState.shift, isInitial: false);
      shakeController.reverse(from: 1);
    }
  }

  void onCenterChanged() {
    ballPosition.value = centerTween.transform(centerController.value);
  }

  void onHitBorder(Offset direction) {
    setState(() {
      shakeState = ShakeState(
        shift: direction * widget.shakeOffset,
        isInitial: true,
      );

      // Update ball color
      if (widget.ballColors.length > 1) {
        final colors = widget.ballColors.where((color) => color != ballColor).toList();
        ballColor = colors.random;
      }

      shakeController.forward(from: 0);
      HapticFeedback.lightImpact().ignore();
    });
  }

  Duration prevTickerDuration = Duration.zero;
  void onTick(Duration time) {
    final delta = time - prevTickerDuration;
    prevTickerDuration = time;

    var ballPosition = this.ballPosition.value + direction * delta.inMilliseconds.toDouble() * widget.acceleration;

    final ballSafeSpace = Size(rectSize.width - widget.ballRadius * 2, rectSize.height - widget.ballRadius * 2);

    if (ballPosition.dx < 0) {
      onHitBorder(direction);

      direction = Offset(-direction.dx, direction.dy);
      ballPosition = Offset(-ballPosition.dx, ballPosition.dy);
    } else if (ballPosition.dx > ballSafeSpace.width) {
      onHitBorder(direction);

      direction = Offset(-direction.dx, direction.dy);
      ballPosition = Offset(
        ballPosition.dx - (ballPosition.dx - ballSafeSpace.width),
        ballPosition.dy,
      );
    }

    if (ballPosition.dy < 0) {
      onHitBorder(direction);

      direction = Offset(direction.dx, -direction.dy);
      ballPosition = Offset(ballPosition.dx, -ballPosition.dy);
    } else if (ballPosition.dy > ballSafeSpace.height) {
      onHitBorder(direction);

      direction = Offset(direction.dx, -direction.dy);
      ballPosition = Offset(
        ballPosition.dx,
        ballPosition.dy - (ballPosition.dy - ballSafeSpace.height),
      );
    }

    this.ballPosition.value = ballPosition;
  }

  double calculateAngle({
    required Offset origin,
    required Offset point,
  }) {
    final angle = math.atan2(point.dy - origin.dy, point.dx - origin.dx) - (math.pi / 2);

    final normalizedAngle = (angle + math.pi) % (2 * math.pi) - math.pi;
    return normalizedAngle;
  }

  final centerTween = Tween<Offset>(
    begin: Offset.zero,
    end: Offset.zero,
  );

  @override
  Widget build(BuildContext context) {
    final ballRadius = widget.ballRadius;
    final ballSize = ballRadius * 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        rectSize = constraints.biggest;

        const arrowRadius = 100.0;

        final center = Offset(
          constraints.maxWidth / 2,
          constraints.maxHeight * 0.25 + arrowRadius,
        );

        return CustomRefreshIndicator(
          controller: controller,
          trailingScrollIndicatorVisible: false,
          onRefresh: widget.onRefresh,
          durations: const RefreshIndicatorDurations(
            completeDuration: Duration(seconds: 1),
          ),
          autoRebuild: false,
          onStateChanged: (change) {
            if (change.didChange(to: IndicatorState.settling)) {
              final angle = lastAngle;

              const scale = 1.0;

              final target = Offset(
                center.dx + scale * math.sin(angle),
                center.dy - scale * math.cos(angle),
              );
              ballPosition.value = Offset(
                center.dx - ballRadius,
                center.dy - ballRadius,
              );
              direction = target - center;
              ticker.start();
            }
            if (change.didChange(to: IndicatorState.complete)) {
              prevTickerDuration = Duration.zero;
              direction = Offset.zero;
              ticker.stop();

              centerTween
                ..end = Offset(center.dx - ballRadius, center.dy - ballRadius)
                ..begin = ballPosition.value;
              centerController.forward(from: 0);
            }

            if (change.didChange(to: IndicatorState.armed)) {
              arrowOpacityController.forward(from: 0);
              HapticFeedback.selectionClick().ignore();
            } else if (change.didChange(from: IndicatorState.armed)) {
              arrowOpacityController.reverse(from: 1);
              HapticFeedback.selectionClick().ignore();
            }
          },
          builder: (context, child, controller) {
            final ball = AnimatedContainer(
              duration: const Duration(milliseconds: 60),
              curve: Curves.easeIn,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                shape: BoxShape.circle,
                border: controller.isArmed
                    ? Border.all(
                        color: widget.ballBorderColor,
                        width: widget.strokeWidth,
                      )
                    : null,
              ),
              width: ballSize,
              height: ballSize,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: controller.isComplete || controller.isFinalizing
                    ? BalunImage(
                        imageUrl: BalunIcons.ballNavigation,
                        height: 32,
                        width: 32,
                        color: ballColor,
                      )
                    : BalunImage(
                        imageUrl: BalunIcons.ballNavigation,
                        height: 32,
                        width: 32,
                        color: ballColor,
                      ),
              ),
            );

            final clamped = controller.clamp(0, 1);

            return Stack(
              children: [
                PositionedTransition(
                  rect: RelativeRectTween(
                    begin: RelativeRect.fill,
                    end: RelativeRect.fill.shift(shakeState.shift),
                  ).animate(shakeController),
                  child: child,
                ),
                if (!controller.isIdle)
                  AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      final event = controller.dragDetails;

                      final double angle;
                      if (event != null) {
                        lastAngle = angle = calculateAngle(
                          origin: center,
                          point: event.localPosition,
                        );
                      } else {
                        angle = lastAngle;
                      }

                      return Positioned(
                        left: center.dx - arrowRadius,
                        top: center.dy - arrowRadius,
                        child: FadeTransition(
                          opacity: CurvedAnimation(
                            parent: arrowOpacityController,
                            curve: Curves.easeIn,
                          ),
                          child: Arrow(
                            radius: arrowRadius,
                            angle: angle,
                            strokeWidth: widget.strokeWidth,
                            distanceFromCenter: ballSize * 0.75,
                            color: widget.arrowColor,
                          ),
                        ),
                      );
                    },
                  ),
                if (controller.isLoading || controller.isSettling || controller.isComplete)
                  Align(
                    alignment: Alignment.topLeft,
                    child: AnimatedBuilder(
                      animation: ballPosition,
                      builder: (context, _) => Transform.translate(
                        offset: ballPosition.value,
                        child: ball,
                      ),
                    ),
                  ),
                if (controller.isDragging || controller.isArmed || controller.isCanceling || controller.isFinalizing)
                  PositionedTransition(
                    rect: RelativeRectTween(
                      begin: RelativeRect.fromRect(
                        Rect.fromLTRB(
                          center.dx - ballRadius,
                          -ballRadius,
                          center.dx + ballRadius,
                          0,
                        ),
                        Offset.zero & constraints.biggest,
                      ),
                      end: RelativeRect.fromRect(
                        Rect.fromLTRB(
                          center.dx - ballRadius,
                          center.dy - ballRadius,
                          center.dx + ballRadius,
                          center.dy + ballRadius,
                        ),
                        Offset.zero & constraints.biggest,
                      ),
                    ).animate(clamped),
                    child: ball,
                  ),
              ],
            );
          },
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    ticker.dispose();
    ballPosition.dispose();
    shakeController.dispose();
    arrowOpacityController.dispose();
    centerController.dispose();
    internalIndicatorController?.dispose();

    super.dispose();
  }
}

class Arrow extends StatelessWidget {
  final double angle;
  final Color color;
  final double strokeWidth;
  final double radius;

  /// How far from the center point the arrow should be drawn. It must be smaller than the radius.
  final double distanceFromCenter;

  const Arrow({
    required this.angle,
    required this.radius,
    required this.color,
    required this.strokeWidth,
    this.distanceFromCenter = 0.0,
    super.key,
  }) : assert(
         radius > distanceFromCenter,
         'Distance from center needs to be smaller than radius',
       ),
       assert(
         distanceFromCenter >= 0,
         'The distance from the center must be greater than or equal to 0',
       ),
       assert(
         radius >= 0,
         'The radius must be greater than or equal to 0',
       );

  @override
  Widget build(BuildContext context) => CustomPaint(
    size: Size.square(radius * 2),
    painter: ArrowPainter(
      angle: angle,
      color: color,
      strokeWidth: strokeWidth,
      radius: radius,
      distanceFromCenter: distanceFromCenter,
    ),
  );
}

class ArrowPainter extends CustomPainter {
  final double angle;
  final Color color;
  final double strokeWidth;
  final double radius;
  final double distanceFromCenter;

  ArrowPainter({
    required this.color,
    required this.angle,
    required this.strokeWidth,
    required this.radius,
    required this.distanceFromCenter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final start = Offset(size.width * 0.5, size.height * 0.5);
    final distance = radius; // Distance from start to end initially

    final end = Offset(
      start.dx + distance * math.sin(angle),
      start.dy - distance * math.cos(angle),
    );

    /// Calculate the vector from A to B
    final direction = end - start;
    // Calculate the magnitude of the direction vector
    final magnitude = math.sqrt(direction.dx * direction.dx + direction.dy * direction.dy);

    /// Normalize the vector
    final unitVector = Offset(direction.dx / magnitude, direction.dy / magnitude);

    /// Scale the unit vector by 50 to get the new point offset
    final startFrom = start + unitVector * distanceFromCenter;

    canvas.drawLine(startFrom, end, paint);

    /// Arrowhead settings
    const double arrowLength = 20; // Length of the arrow lines
    const arrowAngle = math.pi / 6; // Angle of the arrow lines from the main line

    /// Calculating arrowhead lines
    final arrowEnd1 = Offset(end.dx - arrowLength * math.sin(angle - arrowAngle), end.dy + arrowLength * math.cos(angle - arrowAngle));
    final arrowEnd2 = Offset(end.dx - arrowLength * math.sin(angle + arrowAngle), end.dy + arrowLength * math.cos(angle + arrowAngle));

    final path = Path()
      ..moveTo(arrowEnd1.dx, arrowEnd1.dy)
      ..lineTo(end.dx, end.dy)
      ..lineTo(arrowEnd2.dx, arrowEnd2.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ArrowPainter oldDelegate) =>
      oldDelegate.angle != angle ||
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.distanceFromCenter != distanceFromCenter ||
      oldDelegate.radius != radius;
}
