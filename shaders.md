## Shaders

### Shader 编程
* 并行地计算每一个像素点，没有行列遍历的 for 循环
* 每个 pipe 对其它 pipe 是**不可见**的，并且也是**无记忆**的。
* 编写 shader 相当于编写**针对每个不同位置的通用函数**，故开发调试难度均较大。

### GLSL

GLSL (OpenGL Shader Language) Hello World:

``` glsl
#ifdef GL_ES
precision mediump float;
#endif

void main() {
    gl_FragColor = vec4(1.0, 0.0, 1.0, 0.0);
}
```

* SL 有单独的 `main` 函数。
* 最终像素颜色赋值给 `gl_FragColor`。
* 支持内建*变量*、*函数*和*类型*。
* `vec4` 类型参数被*归一化*了（范围由 `0.0` 到 `1.0`）。
* 预处理器宏，预编译时收集所有 `#define`，再检查 `#ifdef` 与 `#ifndef` 条件之间代码是否执行。在移动设备与浏览器上编译时 `GL_ES` 一般适用。
* 浮点类型对 shader 非常重要，我们需要关注*精度*。为平衡精度和渲染速度，可以选择不同 precision。
* GLSL 没有自动类型转换，`vec3(0, 0, 0)` 输入整型会报错。

### Uniforms
由 CPU 传入给各 thread 的输入数据，由于给每个 thread 的值均相同，故称之为 uniform。该值为只读。

约定在变量名中使用形如 `u_mouse` 的前缀以表明其类型（类似匈牙利命名法）。

常用的 uniform 包括屏幕分辨率、当前时间、鼠标位置等。它们类似于绘制新画面的基本 seed，例如我们可以通过时间因子加快或减慢动画速度。

`gl_FragCoord` 让我们定位到某一个点。`gl_FragCoord.xy / u_resolution` 可得到归一化后的 xy 坐标（原点在左下角，与 canvas 不同）。由于其取值在每个点均不同，其类型为 *varing* 而非 uniform。
