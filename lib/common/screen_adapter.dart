import 'dart:ui';

import 'package:flutter/material.dart';

enum Aspect {
  /// 宽适配
  aspectWidth,

  /// 高适配
  aspectHeight
}

class ScreenAdapter {
  ScreenAdapter._internal();

  //保存单例
  static ScreenAdapter _singleton = ScreenAdapter._internal();

  //工厂方法
  factory ScreenAdapter() => _singleton;

  /// 设计稿的宽
  int _designWidth;

  /// 设计稿的高
  int _designHeight;

  /// 设计稿的像素密度
  double _designDevicePixelRatio;

  init(
    BuildContext context, {
    int designWidth,
    int designHeight,
    double designDevicePixelRatio = 1.0,
  }) {
    final mq = MediaQuery.of(context);
    this._designWidth = designWidth;
    this._designHeight = designHeight;
    this._designDevicePixelRatio = designDevicePixelRatio;
  }

  /// 将设计稿的px转换为dp
  double pxToDp(int px, [Aspect aspect = Aspect.aspectWidth]) {
    double ratioW = window.physicalSize.width / (_designWidth ?? 1);
    if (aspect == Aspect.aspectWidth) {
      return px * ratioW / window.devicePixelRatio;
    } else {
      double ratioH = window.physicalSize.height / (_designHeight ?? 1);
      return px * ratioH / window.devicePixelRatio;
    }
  }

  /// 将如果设计稿是dp的话，那么就直接传dp，但前提要设置对像素密度
  double dpToDp(double dp, [Aspect aspect = Aspect.aspectWidth]) {
    if (aspect == Aspect.aspectWidth) {
      double ratioW = window.physicalSize.width / (_designWidth ?? 1);
      return (dp * _designDevicePixelRatio) * ratioW / window.devicePixelRatio;
    } else {
      double ratioH = window.physicalSize.height / (_designHeight ?? 1);
      return (dp * _designDevicePixelRatio) * ratioH / window.devicePixelRatio;
    }
  }
}

final ScreenAdapter screenAdapter = ScreenAdapter();
