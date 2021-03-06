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

### 运行书中 shader
* 通过封装后 glslCanvas 打开。
* 使用 The Book of Shaders 在线编辑器。
* Three.js、Processing 与 openFrameworks 均支持直接运行 `.frag` 文件（需要若干胶水代码提供 `u_time` 等 uniform）。

### 造型函数
* `y = st.x` 相当于线性插值。
* `pow(st.x, 5.0)` 对应指数形式。
* `step(threshold, x)` 对阈值以下返回 0.0，阈值以上返回 1.0。
* `smoothstop` 对应的中间插值较平滑。
* `sin` 和 `cos` 三角函数可模拟 bouncing 效果（取 abs 后，不准确）。
* 二次与三次贝塞尔曲线非常有用，但需自行编码。
* 可以用 macOS 上的 Grapher 观察曲线形态。

### 颜色
* 作为语法糖，我们可以通过 `.xyzw` / `.rgba` / `.stpq` 访问 vec4 的各分量。vec3 同理。
* HSB 色相、饱和度、亮度模型表达力同样强，但需要形如 `hsb2rgb` 的转换。
* 可在极坐标下得到类似 cone 的取色锥效果。极坐标换算：通过 vec 相减获得距离 `(0.5, 0.5)` 长度，再通过 `atan` 获得极坐标下的角度。

### 常见形状
可不通过 Vertex Buffer，直接通过 Fragment Shader 绘制常见形状。

* 通过 left 与 bottom 的 `step` 可以区分矩形的边框。使用 left * bottom 模拟 `&&`。
* 使用 `distance` / `length` / `sqrt` 可计算两点距离，而后叠加造型函数以绘制形状。注意 `sqrt` 是高耗操作。
* 获得 distance field 后，有多种方式可绘制平滑边缘或轮廓，故而在字体渲染中常用。
* 通过极坐标转换可更容易地绘制曲线路径。
* 结合该手法可绘制正多边形。
