//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "TPCi/Boards/Dragon/VFX_Dragon_Wing" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
_ParticleAlphaMask ("Particle Alpha Mask", 2D) = "white" { }
_DissolveTexture ("Dissolve Texture", 2D) = "white" { }
_AddWhite ("Add White", Range(0, 1)) = 0
_AlphaChannel ("Alpha Channel", Range(0, 1)) = 0
_SmoothstepMax ("Smoothstep Max", Float) = 1
_Brightness ("Brightness", Float) = 1
_Alpha_Intensity ("Alpha_Intensity", Float) = 1
_MaskDistortionMap ("Mask Distortion Map", 2D) = "white" { }
_Maskpanspeed ("Mask pan speed", Vector) = (0,-1,0,0)
_Dissolvepanspeed ("Dissolve pan speed", Vector) = (0,-1,0,0)
_MaskDistPower ("Mask Dist Power", Float) = 0.1
_DissolveIntensity ("Dissolve Intensity", Float) = 2.58
_OverallAlphaIntensity ("Overall Alpha Intensity", Float) = 1
_Offset ("Offset", Float) = 0
_DissolveTile ("Dissolve Tile", Vector) = (1,1,0,0)
_texcoord ("", 2D) = "white" { }
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  ColorMask RGB 0
  ZWrite Off
  Cull Off
  GpuProgramID 25735
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Offset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_Offset, _Offset, _Offset)) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	float _Brightness;
uniform 	float _AddWhite;
uniform 	vec2 _Maskpanspeed;
uniform 	float _MaskDistPower;
uniform 	float _AlphaChannel;
uniform 	float _Alpha_Intensity;
uniform 	vec2 _DissolveTile;
uniform 	float _SmoothstepMax;
uniform 	vec2 _Dissolvepanspeed;
uniform 	float _DissolveIntensity;
uniform 	float _OverallAlphaIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MaskDistortionMap;
UNITY_LOCATION(2) uniform mediump sampler2D _ParticleAlphaMask;
UNITY_LOCATION(3) uniform mediump sampler2D _DissolveTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = _Time.yy * _Maskpanspeed.xy + vs_TEXCOORD0.xy;
    u_xlat16_0.x = texture(_MaskDistortionMap, u_xlat0.xy).x;
    u_xlat0.x = u_xlat16_0.x + -1.0;
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD0.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_MaskDistPower, _MaskDistPower)) + vs_TEXCOORD0.xy;
    u_xlat6.xy = vs_TEXCOORD0.xy * vec2(_DissolveTile.x, _DissolveTile.y) + u_xlat0.xy;
    u_xlat16_1 = texture(_ParticleAlphaMask, u_xlat0.xy);
    u_xlat0.xy = _Time.yy * _Dissolvepanspeed.xy + u_xlat6.xy;
    u_xlat16_0.xyz = texture(_DissolveTexture, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_DissolveIntensity, _DissolveIntensity, _DissolveIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat9 = max(vs_TEXCOORD0.z, -1.0);
    u_xlat9 = min(u_xlat9, 1.0);
    u_xlat0.xyz = (-vec3(u_xlat9)) + u_xlat0.xyz;
    u_xlat2.x = u_xlat9 + _SmoothstepMax;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat9) + u_xlat2.x;
    u_xlat9 = float(1.0) / u_xlat9;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat0.xyz * vec3(-2.0, -2.0, -2.0) + vec3(3.0, 3.0, 3.0);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_OverallAlphaIntensity, _OverallAlphaIntensity, _OverallAlphaIntensity));
    u_xlat2.xyz = (-u_xlat16_1.xyz) + u_xlat16_1.www;
    u_xlat1.xyz = vec3(vec3(_AlphaChannel, _AlphaChannel, _AlphaChannel)) * u_xlat2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_Alpha_Intensity);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xyz = min(max(u_xlat1.xyz, 0.0), 1.0);
#else
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyw = u_xlat0.yzx * vs_COLOR0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyw = min(max(u_xlat0.xyw, 0.0), 1.0);
#else
    u_xlat0.xyw = clamp(u_xlat0.xyw, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat16_1.xyz + vec3(vec3(_AddWhite, _AddWhite, _AddWhite));
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xyz = min(max(u_xlat1.xyz, 0.0), 1.0);
#else
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xyz = u_xlat0.wxy * u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Offset;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_Offset, _Offset, _Offset)) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD2.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _MainTex_ST;
uniform 	float _InvFade;
uniform 	float _Brightness;
uniform 	float _AddWhite;
uniform 	vec2 _Maskpanspeed;
uniform 	float _MaskDistPower;
uniform 	float _AlphaChannel;
uniform 	float _Alpha_Intensity;
uniform 	vec2 _DissolveTile;
uniform 	float _SmoothstepMax;
uniform 	vec2 _Dissolvepanspeed;
uniform 	float _DissolveIntensity;
uniform 	float _OverallAlphaIntensity;
UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _MaskDistortionMap;
UNITY_LOCATION(3) uniform mediump sampler2D _ParticleAlphaMask;
UNITY_LOCATION(4) uniform mediump sampler2D _DissolveTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = _Time.yy * _Maskpanspeed.xy + vs_TEXCOORD0.xy;
    u_xlat16_0.x = texture(_MaskDistortionMap, u_xlat0.xy).x;
    u_xlat0.x = u_xlat16_0.x + -1.0;
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD0.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_MaskDistPower, _MaskDistPower)) + vs_TEXCOORD0.xy;
    u_xlat6.xy = vs_TEXCOORD0.xy * vec2(_DissolveTile.x, _DissolveTile.y) + u_xlat0.xy;
    u_xlat16_1 = texture(_ParticleAlphaMask, u_xlat0.xy);
    u_xlat0.xy = _Time.yy * _Dissolvepanspeed.xy + u_xlat6.xy;
    u_xlat16_0.xyz = texture(_DissolveTexture, u_xlat0.xy).xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_DissolveIntensity, _DissolveIntensity, _DissolveIntensity));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat9 = max(vs_TEXCOORD0.z, -1.0);
    u_xlat9 = min(u_xlat9, 1.0);
    u_xlat0.xyz = (-vec3(u_xlat9)) + u_xlat0.xyz;
    u_xlat2.x = u_xlat9 + _SmoothstepMax;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat9) + u_xlat2.x;
    u_xlat9 = float(1.0) / u_xlat9;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat0.xyz * vec3(-2.0, -2.0, -2.0) + vec3(3.0, 3.0, 3.0);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_OverallAlphaIntensity, _OverallAlphaIntensity, _OverallAlphaIntensity));
    u_xlat2.xyz = (-u_xlat16_1.xyz) + u_xlat16_1.www;
    u_xlat1.xyz = vec3(vec3(_AlphaChannel, _AlphaChannel, _AlphaChannel)) * u_xlat2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_Alpha_Intensity);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xyz = min(max(u_xlat1.xyz, 0.0), 1.0);
#else
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat9 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat9 = _ZBufferParams.z * u_xlat9 + _ZBufferParams.w;
    u_xlat9 = float(1.0) / u_xlat9;
    u_xlat9 = u_xlat9 + (-vs_TEXCOORD2.z);
    u_xlat9 = u_xlat9 * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyw = u_xlat0.yzx * vec3(u_xlat9);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyw = min(max(u_xlat0.xyw, 0.0), 1.0);
#else
    u_xlat0.xyw = clamp(u_xlat0.xyw, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat16_1.xyz + vec3(vec3(_AddWhite, _AddWhite, _AddWhite));
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xyz = min(max(u_xlat1.xyz, 0.0), 1.0);
#else
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat0.xyz = u_xlat0.wxy * u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
}
}
}
CustomEditor "ASEMaterialInspector"
}