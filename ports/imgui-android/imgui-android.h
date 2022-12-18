#ifndef IMGUI_ANDROID_H
#define IMGUI_ANDROID_H

#define IM_PI      3.14159265358979323846F
#define IM_PI_X2   6.283185307179586F
#define IM_DEG2RAD 0.017453292519943295F
#define IM_RAD2DEG 57.29577951308232F
#ifndef IMGUI_IMPL_OPENGL_ES3
#define IMGUI_IMPL_OPENGL_ES3
#endif

#ifdef IMGUI_ANDROID_USE_FREETYPE
#define IMGUI_ENABLE_FREETYPE
#endif

#include "imgui-android/imgui.h"
#include "imgui-android/imgui_internal.h"
#include "imgui-android/imgui_impl_android.h"
#include "imgui-android/imgui_impl_opengl3.h"

#ifdef IMGUI_ANDROID_USE_FREETYPE
#include "imgui-android/imgui_freetype.h"
#endif

#include <EGL/egl.h>
#include <GLES3/gl3.h>
#include <string>
#include <jni.h>
#include <android/native_window_jni.h>
#include <android/asset_manager_jni.h>
#include <android/input.h>
#include <cmath>

// Math Helper Functions
namespace ImMath {
    inline float  ImCsc(float x) { return 1 / sin(x); }
    inline double ImCsc(double x) { return 1 / sin(x); }
    inline float  ImSec(float x) { return 1 / cos(x); }
    inline double ImSec(double x) { return 1 / cos(x); }
    inline float  ImCot(float x) { return 1 / tan(x); }
    inline double ImCot(double x) { return 1 / tan(x); }

    inline float circumFerence(float r) { return IM_PI_X2 * r; }
    // Turn degrees into Radians, necessary for circle math
    inline float degreesToRadians(float a) { return a * IM_DEG2RAD; }
    // Turn Radians into Degrees, necessary for circle math
    inline float radiansToDegrees(float a) { return a * IM_RAD2DEG; }
    // Returns the angle from two points
    inline float angleFromPoints(const ImVec2 &a, const ImVec2 &b) { return atan2f(b.y - a.y, b.x - a.x); }
    // Returns the angle from two points
    inline float angleFromPoints(float x1, float y1, float x2, float y2) { return atan2f(y2 - y1, x2 - x1); }
    // Will return the angle opposite of the B side
    inline float angleFromSides(float a, float b, float c) { return acos(acos((c * c + a * a - b * b) / (2 * c * a))); }
    // This function is basic ratio math. curries a ratio and then multiplies that by another number
    inline float ratio(float n, float min, float max) { return n * min / max; }
    // Nudge a number a certain percentage of a distance using a starting offset
    inline float nudge(float s, float p, float d) { return p * d + s; }
    // Make sure a number does not passbelow a min or above a max
    inline float clamp(float n, float min, float max) { return n > max ? max : n < min ? min
                                                                                              : n; }
    // Given a curried max value, attempts to bring negative numbers to positive range of loop
    inline float trueNumber(float max, float n) { return n < 0 ? n + max : n; }
    inline float trueRadian(float n) { return trueNumber(IM_PI_X2, n); }
    inline float trueHalfRadian(float n) { return trueNumber(IM_PI, n); }
    inline float trueDegree(float n) { return trueNumber(360, n); }
    // Given a curried max value, attempts to wrap a number over half into a negative number of loop
    inline float signNumber(float max, float n) { return n > max * 0.5 ? fmodf(n, max) - max : n; }
    inline float signRadian(float n) { return signNumber(IM_PI_X2, n); }
    inline float signHalfRadian(float n) { return signNumber(IM_PI, n); }
    inline float signDegree(float n) { return signNumber(360, n); }
    // The distance between two points
    inline float pointDistance(const ImVec2 &a, const ImVec2 &b) { return std::hypot(a.x - b.x, a.y - b.y); }
    // The distance between two points
    inline float pointDistance(float x1, float y1, float x2, float y2) { return std::hypot(x1 - x2, y1 - y2); }
    // The distance between two points
    inline float pointDistance(const ImVec3 &a, const ImVec3 &b) { return std::hypot(a.x - b.x, a.y - b.y, a.z - b.z); }
    // The distance between two points
    inline float pointDistance(float x1, float y1, float z1, float x2, float y2, float z2) { return std::hypot(x1 - x2, y1 - y2, z1 - z2); }
} // namespace ImMath

namespace ImGui {
    inline void GetNativeWindowSize(EGLNativeWindowType window, ImRect &output) { output.set(0, 0, (float)ANativeWindow_getWidth(window), (float)ANativeWindow_getHeight(window)); }
    inline void GetNativeWindowSize(EGLNativeWindowType window, ImVec2 &output) { output.set((float)ANativeWindow_getWidth(window), (float)ANativeWindow_getHeight(window)); }
} // namespace ImGui

#endif // IMGUI_ANDROID_H
