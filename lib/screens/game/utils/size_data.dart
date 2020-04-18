import 'dart:math' as Math;

import 'package:flutter/material.dart';

const _data = {
  360: {
    4: {
      'padding': 3.0,
      'border': 4.0,
      'size': 52.0,
      'font': 18.0,
      'cPadding': 5.0,
    },
    5: {
      'padding': 2.5,
      'border': 3.5,
      'size': 45.0,
      'font': 18.0,
      'cPadding': 5.0,
    },
    6: {
      'padding': 1.8,
      'border': 2.5,
      'size': 39.0,
      'font': 17.0,
      'cPadding': 9.0,
    },
    7: {
      'padding': 1.5,
      'border': 2.0,
      'size': 35.0,
      'font': 16.0,
      'cPadding': 17.0,
    },
    8: {
      'padding': 1.5,
      'border': 1.0,
      'size': 31.0,
      'font': 13.0,
      'cPadding': 18.0,
    },
  },
  414: {
    4: {
      'padding': 4.0,
      'border': 5.0,
      'size': 55.0,
      'font': 18.0,
      'cPadding': 5.0,
    },
    5: {
      'padding': 3.0,
      'border': 4.0,
      'size': 48.0,
      'font': 18.0,
      'cPadding': 5.0,
    },
    6: {
      'padding': 2.5,
      'border': 3.0,
      'size': 45.0,
      'font': 17.0,
      'cPadding': 9.0,
    },
    7: {
      'padding': 2.0,
      'border': 2.5,
      'size': 40.0,
      'font': 16.0,
      'cPadding': 11.0,
    },
    8: {
      'padding': 1.5,
      'border': 2.0,
      'size': 37.0,
      'font': 15.0,
      'cPadding': 13.0,
    },
  },
};

const _minScreenWidth = 360.0;
const _maxScreenWidth = 414.0;

double _size(String property, int length, double width) {
  final min = _data[_minScreenWidth][length][property];
  final max = _data[_maxScreenWidth][length][property];
  final widthInterpolator = _Interpolator.fromDataPoints(
    p1: Math.Point(_minScreenWidth, min),
    p2: Math.Point(_maxScreenWidth, max),
    min: min,
    max: max,
  );

  return widthInterpolator.y(x: width);
}

class SizeData {
  factory SizeData.create({
    @required int length,
    @required double width,
  }) {
    return SizeData._(
      _size('padding', length, width),
      _size('border', length, width),
      _size('size', length, width),
      _size('font', length, width),
      _size('cPadding', length, width),
    );
  }

  SizeData._(
    this.padding,
    this.border,
    this.size,
    this.font,
    this.cPadding,
  );
  final double padding;
  final double border;
  final double size;
  final double font;
  final double cPadding;

  static const double maxScreenWidth = _maxScreenWidth;
}

/// Calculator that finds y for a given value x based on two linear data points.
///
/// This class can typically be used to calculate different dimensions for
/// widgets based on the screen size.
class _Interpolator {
  factory _Interpolator.fromDataPoints({
    Math.Point p1,
    Math.Point p2,
    double min = double.negativeInfinity,
    double max = double.infinity,
  }) {
    double a = (p1.y - p2.y) / (p1.x - p2.x);
    double b = p1.y - (a * p1.x);

    return _Interpolator._(a, b, min, max);
  }

  const _Interpolator._(
    this._a,
    this._b,
    this._min,
    this._max,
  );

  final double _a;
  final double _b;
  final double _min;
  final double _max;

  /// Calculates the value for y
  double y({double x}) => Math.max(Math.min(_a * x + _b, _max), _min);
}
