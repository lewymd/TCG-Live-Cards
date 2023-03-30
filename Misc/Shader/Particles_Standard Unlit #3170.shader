//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Particles/Standard Unlit" {
Properties {
_MainTex ("Albedo", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
_BumpScale ("Scale", Float) = 1
_BumpMap ("Normal Map", 2D) = "bump" { }
_EmissionColor ("Color", Color) = (0,0,0,1)
_EmissionMap ("Emission", 2D) = "white" { }
_DistortionStrength ("Strength", Float) = 1
_DistortionBlend ("Blend", Range(0, 1)) = 0.5
_SoftParticlesNearFadeDistance ("Soft Particles Near Fade", Float) = 0
_SoftParticlesFarFadeDistance ("Soft Particles Far Fade", Float) = 1
_CameraNearFadeDistance ("Camera Near Fade", Float) = 1
_CameraFarFadeDistance ("Camera Far Fade", Float) = 2
_Mode ("__mode", Float) = 0
_ColorMode ("__colormode", Float) = 0
_FlipbookMode ("__flipbookmode", Float) = 0
_LightingEnabled ("__lightingenabled", Float) = 0
_DistortionEnabled ("__distortionenabled", Float) = 0
_EmissionEnabled ("__emissionenabled", Float) = 0
_BlendOp ("__blendop", Float) = 0
_SrcBlend ("__src", Float) = 1
_DstBlend ("__dst", Float) = 0
_ZWrite ("__zw", Float) = 1
_Cull ("__cull", Float) = 2
_SoftParticlesEnabled ("__softparticlesenabled", Float) = 0
_CameraFadingEnabled ("__camerafadingenabled", Float) = 0
_SoftParticleFadeParams ("__softparticlefadeparams", Vector) = (0,0,0,0)
_CameraFadeParams ("__camerafadeparams", Vector) = (0,0,0,0)
_ColorAddSubDiff ("__coloraddsubdiff", Vector) = (0,0,0,0)
_DistortionStrengthScaled ("__distortionstrengthscaled", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PerformanceChecks" = "False" "PreviewType" = "Plane" "RenderType" = "Opaque" }
 GrabPass {
  "_GrabTexture"
}
 Pass {
  Name "ShadowCaster"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "SHADOWCASTER" "PerformanceChecks" = "False" "PreviewType" = "Plane" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ColorMask RGB 0
  Cull Off
  GpuProgramID 18548
Program "vp" {
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
Local Keywords { "_ALPHABLEND_ON" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 * vs_TEXCOORD3.w + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
Local Keywords { "_ALPHATEST_ON" "_REQUIRE_UV2" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp float in_TEXCOORD1;
out highp vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.zw;
    vs_TEXCOORD2.z = in_TEXCOORD1;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
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
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD2.xy).w;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat0 = (-u_xlat16_2) + u_xlat16_0;
    u_xlat0 = vs_TEXCOORD2.z * u_xlat0 + u_xlat16_2;
    u_xlat16_1 = u_xlat0 * vs_TEXCOORD3.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
Local Keywords { "_ALPHATEST_ON" "_COLORCOLOR_ON" "_REQUIRE_UV2" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp float in_TEXCOORD1;
out highp vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.zw;
    vs_TEXCOORD2.z = in_TEXCOORD1;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
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
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD2.xy).w;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat0 = (-u_xlat16_2) + u_xlat16_0;
    u_xlat0 = vs_TEXCOORD2.z * u_xlat0 + u_xlat16_2;
    u_xlat16_1 = u_xlat0 * vs_TEXCOORD3.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 * vs_TEXCOORD3.w + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHATEST_ON" "_REQUIRE_UV2" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp float in_TEXCOORD1;
out highp vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.zw;
    vs_TEXCOORD2.z = in_TEXCOORD1;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
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
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD2.xy).w;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat0 = (-u_xlat16_2) + u_xlat16_0;
    u_xlat0 = vs_TEXCOORD2.z * u_xlat0 + u_xlat16_2;
    u_xlat16_1 = u_xlat0 * vs_TEXCOORD3.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHATEST_ON" "_COLORCOLOR_ON" "_REQUIRE_UV2" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp float in_TEXCOORD1;
out highp vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.zw;
    vs_TEXCOORD2.z = in_TEXCOORD1;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
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
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD2.xy).w;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat0 = (-u_xlat16_2) + u_xlat16_0;
    u_xlat0 = vs_TEXCOORD2.z * u_xlat0 + u_xlat16_2;
    u_xlat16_1 = u_xlat0 * vs_TEXCOORD3.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat14 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat14);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat14) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat14;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_CUBE" }
Local Keywords { "_ALPHABLEND_ON" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec2 vs_TEXCOORD1;
layout(location = 1) out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat7.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(52 >> 2) + 0]);
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat14 = u_xlat7.x / unity_ParticleUVShiftData.y;
    u_xlat14 = floor(u_xlat14);
    u_xlat7.x = (-u_xlat14) * unity_ParticleUVShiftData.y + u_xlat7.x;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = u_xlat7.x * unity_ParticleUVShiftData.z;
    u_xlat7.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat14) * unity_ParticleUVShiftData.w + u_xlat7.x;
    u_xlat7.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb21 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat7.xy = (bool(u_xlatb21)) ? u_xlat7.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat7.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec2 vs_TEXCOORD1;
layout(location = 1) in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 * vs_TEXCOORD3.w + -0.5;
    u_xlatb0 = u_xlat16_1<0.0;
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_CUBE" }
Local Keywords { "_ALPHATEST_ON" "_REQUIRE_UV2" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec2 vs_TEXCOORD1;
layout(location = 1) out highp vec3 vs_TEXCOORD2;
layout(location = 2) out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat7.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(52 >> 2) + 0]);
    u_xlat14 = floor(u_xlat7.x);
    u_xlat21 = u_xlat14 / unity_ParticleUVShiftData.y;
    u_xlat21 = floor(u_xlat21);
    u_xlat14 = (-u_xlat21) * unity_ParticleUVShiftData.y + u_xlat14;
    u_xlat14 = floor(u_xlat14);
    u_xlat1.x = u_xlat14 * unity_ParticleUVShiftData.z;
    u_xlat14 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat21) * unity_ParticleUVShiftData.w + u_xlat14;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb21 = unity_ParticleUVShiftData.x!=0.0;
    vs_TEXCOORD1.xy = (bool(u_xlatb21)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    u_xlat1.x = u_xlat7.x + 1.0;
    u_xlat2.z = fract(u_xlat7.x);
    u_xlat7.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat7.x / unity_ParticleUVShiftData.y;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat7.x = (-u_xlat1.x) * unity_ParticleUVShiftData.y + u_xlat7.x;
    u_xlat1.y = (-u_xlat1.x) * unity_ParticleUVShiftData.w + u_xlat14;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = u_xlat7.x * unity_ParticleUVShiftData.z;
    u_xlat2.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = 0.0;
    vs_TEXCOORD2.xyz = (bool(u_xlatb21)) ? u_xlat2.xyz : u_xlat1.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec2 vs_TEXCOORD1;
layout(location = 1) in highp vec3 vs_TEXCOORD2;
layout(location = 2) in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD2.xy).w;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat0 = (-u_xlat16_2) + u_xlat16_0;
    u_xlat0 = vs_TEXCOORD2.z * u_xlat0 + u_xlat16_2;
    u_xlat16_1 = u_xlat0 * vs_TEXCOORD3.w + (-_Cutoff);
    u_xlatb0 = u_xlat16_1<0.0;
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_CUBE" }
Local Keywords { "_ALPHATEST_ON" "_COLORCOLOR_ON" "_REQUIRE_UV2" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec2 vs_TEXCOORD1;
layout(location = 1) out highp vec3 vs_TEXCOORD2;
layout(location = 2) out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat7.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(52 >> 2) + 0]);
    u_xlat14 = floor(u_xlat7.x);
    u_xlat21 = u_xlat14 / unity_ParticleUVShiftData.y;
    u_xlat21 = floor(u_xlat21);
    u_xlat14 = (-u_xlat21) * unity_ParticleUVShiftData.y + u_xlat14;
    u_xlat14 = floor(u_xlat14);
    u_xlat1.x = u_xlat14 * unity_ParticleUVShiftData.z;
    u_xlat14 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat21) * unity_ParticleUVShiftData.w + u_xlat14;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb21 = unity_ParticleUVShiftData.x!=0.0;
    vs_TEXCOORD1.xy = (bool(u_xlatb21)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    u_xlat1.x = u_xlat7.x + 1.0;
    u_xlat2.z = fract(u_xlat7.x);
    u_xlat7.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat7.x / unity_ParticleUVShiftData.y;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat7.x = (-u_xlat1.x) * unity_ParticleUVShiftData.y + u_xlat7.x;
    u_xlat1.y = (-u_xlat1.x) * unity_ParticleUVShiftData.w + u_xlat14;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = u_xlat7.x * unity_ParticleUVShiftData.z;
    u_xlat2.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = 0.0;
    vs_TEXCOORD2.xyz = (bool(u_xlatb21)) ? u_xlat2.xyz : u_xlat1.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec2 vs_TEXCOORD1;
layout(location = 1) in highp vec3 vs_TEXCOORD2;
layout(location = 2) in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD2.xy).w;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat0 = (-u_xlat16_2) + u_xlat16_0;
    u_xlat0 = vs_TEXCOORD2.z * u_xlat0 + u_xlat16_2;
    u_xlat16_1 = u_xlat0 * vs_TEXCOORD3.w + (-_Cutoff);
    u_xlatb0 = u_xlat16_1<0.0;
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec2 vs_TEXCOORD1;
layout(location = 1) out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat7.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(52 >> 2) + 0]);
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat14 = u_xlat7.x / unity_ParticleUVShiftData.y;
    u_xlat14 = floor(u_xlat14);
    u_xlat7.x = (-u_xlat14) * unity_ParticleUVShiftData.y + u_xlat7.x;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = u_xlat7.x * unity_ParticleUVShiftData.z;
    u_xlat7.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat14) * unity_ParticleUVShiftData.w + u_xlat7.x;
    u_xlat7.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb21 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat7.xy = (bool(u_xlatb21)) ? u_xlat7.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat7.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat14 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat14);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat14) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat14;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec2 vs_TEXCOORD1;
layout(location = 1) in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 * vs_TEXCOORD3.w + -0.5;
    u_xlatb0 = u_xlat16_1<0.0;
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHATEST_ON" "_REQUIRE_UV2" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec2 vs_TEXCOORD1;
layout(location = 1) out highp vec3 vs_TEXCOORD2;
layout(location = 2) out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat7.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(52 >> 2) + 0]);
    u_xlat14 = floor(u_xlat7.x);
    u_xlat21 = u_xlat14 / unity_ParticleUVShiftData.y;
    u_xlat21 = floor(u_xlat21);
    u_xlat14 = (-u_xlat21) * unity_ParticleUVShiftData.y + u_xlat14;
    u_xlat14 = floor(u_xlat14);
    u_xlat1.x = u_xlat14 * unity_ParticleUVShiftData.z;
    u_xlat14 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat21) * unity_ParticleUVShiftData.w + u_xlat14;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb21 = unity_ParticleUVShiftData.x!=0.0;
    vs_TEXCOORD1.xy = (bool(u_xlatb21)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    u_xlat1.x = u_xlat7.x + 1.0;
    u_xlat2.z = fract(u_xlat7.x);
    u_xlat7.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat7.x / unity_ParticleUVShiftData.y;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat7.x = (-u_xlat1.x) * unity_ParticleUVShiftData.y + u_xlat7.x;
    u_xlat1.y = (-u_xlat1.x) * unity_ParticleUVShiftData.w + u_xlat14;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = u_xlat7.x * unity_ParticleUVShiftData.z;
    u_xlat2.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = 0.0;
    vs_TEXCOORD2.xyz = (bool(u_xlatb21)) ? u_xlat2.xyz : u_xlat1.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat14 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat14);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat14) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat14;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec2 vs_TEXCOORD1;
layout(location = 1) in highp vec3 vs_TEXCOORD2;
layout(location = 2) in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD2.xy).w;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat0 = (-u_xlat16_2) + u_xlat16_0;
    u_xlat0 = vs_TEXCOORD2.z * u_xlat0 + u_xlat16_2;
    u_xlat16_1 = u_xlat0 * vs_TEXCOORD3.w + (-_Cutoff);
    u_xlatb0 = u_xlat16_1<0.0;
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHATEST_ON" "_COLORCOLOR_ON" "_REQUIRE_UV2" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec2 vs_TEXCOORD1;
layout(location = 1) out highp vec3 vs_TEXCOORD2;
layout(location = 2) out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat7.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(52 >> 2) + 0]);
    u_xlat14 = floor(u_xlat7.x);
    u_xlat21 = u_xlat14 / unity_ParticleUVShiftData.y;
    u_xlat21 = floor(u_xlat21);
    u_xlat14 = (-u_xlat21) * unity_ParticleUVShiftData.y + u_xlat14;
    u_xlat14 = floor(u_xlat14);
    u_xlat1.x = u_xlat14 * unity_ParticleUVShiftData.z;
    u_xlat14 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat21) * unity_ParticleUVShiftData.w + u_xlat14;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb21 = unity_ParticleUVShiftData.x!=0.0;
    vs_TEXCOORD1.xy = (bool(u_xlatb21)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    u_xlat1.x = u_xlat7.x + 1.0;
    u_xlat2.z = fract(u_xlat7.x);
    u_xlat7.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat7.x / unity_ParticleUVShiftData.y;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat7.x = (-u_xlat1.x) * unity_ParticleUVShiftData.y + u_xlat7.x;
    u_xlat1.y = (-u_xlat1.x) * unity_ParticleUVShiftData.w + u_xlat14;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = u_xlat7.x * unity_ParticleUVShiftData.z;
    u_xlat2.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = 0.0;
    vs_TEXCOORD2.xyz = (bool(u_xlatb21)) ? u_xlat2.xyz : u_xlat1.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat14 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat14);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat14) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat14;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec2 vs_TEXCOORD1;
layout(location = 1) in highp vec3 vs_TEXCOORD2;
layout(location = 2) in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD2.xy).w;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat0 = (-u_xlat16_2) + u_xlat16_0;
    u_xlat0 = vs_TEXCOORD2.z * u_xlat0 + u_xlat16_2;
    u_xlat16_1 = u_xlat0 * vs_TEXCOORD3.w + (-_Cutoff);
    u_xlatb0 = u_xlat16_1<0.0;
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
Local Keywords { "_ALPHATEST_ON" "_REQUIRE_UV2" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
Local Keywords { "_ALPHATEST_ON" "_COLORCOLOR_ON" "_REQUIRE_UV2" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHATEST_ON" "_REQUIRE_UV2" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHATEST_ON" "_COLORCOLOR_ON" "_REQUIRE_UV2" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_CUBE" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_CUBE" }
Local Keywords { "_ALPHATEST_ON" "_REQUIRE_UV2" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_CUBE" }
Local Keywords { "_ALPHATEST_ON" "_COLORCOLOR_ON" "_REQUIRE_UV2" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_CUBE" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHATEST_ON" "_REQUIRE_UV2" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHATEST_ON" "_COLORCOLOR_ON" "_REQUIRE_UV2" }
""
}
}
}
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "PreviewType" = "Plane" "RenderType" = "Opaque" }
  Blend Zero Zero, Zero Zero
  ColorMask RGB 0
  ZWrite Off
  Cull Off
  GpuProgramID 253844
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Local Keywords { "_ALPHABLEND_ON" }
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Local Keywords { "_ALPHATEST_ON" "_REQUIRE_UV2" }
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp float in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.zw;
    vs_TEXCOORD2.z = in_TEXCOORD1;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_0 + (-u_xlat16_1);
    u_xlat0 = vs_TEXCOORD2.zzzz * u_xlat0 + u_xlat16_1;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat16_2 = u_xlat16_0.w * vs_COLOR0.w + (-_Cutoff);
    u_xlat1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    u_xlat16_2 = u_xlat16_2 + 9.99999975e-05;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_2<0.0);
#else
    u_xlatb1 = u_xlat16_2<0.0;
#endif
    if(u_xlatb1){discard;}
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Local Keywords { "_ALPHATEST_ON" "_COLORCOLOR_ON" "_REQUIRE_UV2" }
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp float in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.zw;
    vs_TEXCOORD2.z = in_TEXCOORD1;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
bool u_xlatb6;
mediump vec3 u_xlat16_8;
bool u_xlatb12;
mediump float u_xlat16_14;
mediump float u_xlat16_20;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_0 + (-u_xlat16_1);
    u_xlat0 = vs_TEXCOORD2.zzzz * u_xlat0 + u_xlat16_1;
    u_xlat16_1 = u_xlat0 * _Color;
    u_xlat16_2 = u_xlat16_1.w * vs_COLOR0.w + (-_Cutoff);
    u_xlat16_2 = u_xlat16_2 + 9.99999975e-05;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_2<0.0);
#else
    u_xlatb12 = u_xlat16_2<0.0;
#endif
    if(u_xlatb12){discard;}
    u_xlat16_2 = u_xlat0.y * _Color.y + (-u_xlat16_1.z);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat16_1.y>=u_xlat16_1.z);
#else
    u_xlatb6 = u_xlat16_1.y>=u_xlat16_1.z;
#endif
    u_xlat16_8.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_2 = u_xlat16_8.x * u_xlat16_2 + u_xlat16_1.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat16_1.x>=u_xlat16_2);
#else
    u_xlatb6 = u_xlat16_1.x>=u_xlat16_2;
#endif
    u_xlat16_8.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_14 = u_xlat0.x * _Color.x + (-u_xlat16_2);
    u_xlat16_2 = u_xlat16_8.x * u_xlat16_14 + u_xlat16_2;
    u_xlat16_0.w = (-vs_COLOR0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(vs_COLOR0.y>=vs_COLOR0.z);
#else
    u_xlatb3 = vs_COLOR0.y>=vs_COLOR0.z;
#endif
    u_xlat16_1.xy = (-vs_COLOR0.zy) + vs_COLOR0.yz;
    u_xlat16_1.z = float(1.0);
    u_xlat16_1.w = float(-1.0);
    u_xlat16_1 = (bool(u_xlatb3)) ? u_xlat16_1 : vec4(0.0, 0.0, 0.0, -0.0);
    u_xlat16_3.zw = u_xlat16_1.zw + vec2(-1.0, 0.666666687);
    u_xlat16_3.xy = u_xlat16_1.xy + vs_COLOR0.zy;
    u_xlat16_0.xyz = (-u_xlat16_3.xyw);
    u_xlat16_1.yzw = u_xlat16_0.yzw + u_xlat16_3.yzx;
    u_xlat16_1.x = u_xlat16_0.x + vs_COLOR0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vs_COLOR0.x>=u_xlat16_3.x);
#else
    u_xlatb4 = vs_COLOR0.x>=u_xlat16_3.x;
#endif
    u_xlat16_0 = (bool(u_xlatb4)) ? u_xlat16_1 : vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_8.x = u_xlat16_0.w + vs_COLOR0.x;
    u_xlat16_5.xyz = u_xlat16_0.xyz + u_xlat16_3.xyw;
    u_xlat16_14 = min(u_xlat16_8.x, u_xlat16_5.y);
    u_xlat16_8.x = u_xlat16_8.x + (-u_xlat16_5.y);
    u_xlat16_14 = (-u_xlat16_14) + u_xlat16_5.x;
    u_xlat16_20 = u_xlat16_14 * 6.0 + 1.00000001e-10;
    u_xlat16_8.x = u_xlat16_8.x / u_xlat16_20;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_5.z;
    u_xlat16_20 = u_xlat16_5.x + 1.00000001e-10;
    u_xlat16_14 = u_xlat16_14 / u_xlat16_20;
    u_xlat16_5.xyz = abs(u_xlat16_8.xxx) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat16_5.xyz = fract(u_xlat16_5.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat16_5.xyz = abs(u_xlat16_5.xyz) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(u_xlat16_14) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_2);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec2 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6 = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.x = u_xlat6 * unity_ParticleUVShiftData.z;
    u_xlat6 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat6;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec2 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6 = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.x = u_xlat6 * unity_ParticleUVShiftData.z;
    u_xlat6 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat6;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHATEST_ON" "_REQUIRE_UV2" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
layout(location = 2) out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec3 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec2 u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
float u_xlat12;
float u_xlat13;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = floor(u_xlat1.x);
    u_xlat6.x = u_xlat0.x / unity_ParticleUVShiftData.y;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat0.x = (-u_xlat6.x) * unity_ParticleUVShiftData.y + u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.x = u_xlat0.x * unity_ParticleUVShiftData.z;
    u_xlat0.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat2.y = (-u_xlat6.x) * unity_ParticleUVShiftData.w + u_xlat0.x;
    u_xlat6.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat2.xy;
    u_xlatb18 = unity_ParticleUVShiftData.x!=0.0;
    vs_TEXCOORD1.xy = (bool(u_xlatb18)) ? u_xlat6.xy : in_TEXCOORD0.xy;
    u_xlat6.x = u_xlat1.x + 1.0;
    u_xlat1.z = fract(u_xlat1.x);
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat12 = u_xlat6.x / unity_ParticleUVShiftData.y;
    u_xlat12 = floor(u_xlat12);
    u_xlat6.x = (-u_xlat12) * unity_ParticleUVShiftData.y + u_xlat6.x;
    u_xlat2.y = (-u_xlat12) * unity_ParticleUVShiftData.w + u_xlat0.x;
    u_xlat0.x = floor(u_xlat6.x);
    u_xlat2.x = u_xlat0.x * unity_ParticleUVShiftData.z;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat2.xy;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.z = 0.0;
    vs_TEXCOORD2.xyz = (bool(u_xlatb18)) ? u_xlat1.xyz : u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 2) in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_0 + (-u_xlat16_1);
    u_xlat0 = vs_TEXCOORD2.zzzz * u_xlat0 + u_xlat16_1;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat16_2 = u_xlat16_0.w * vs_COLOR0.w + (-_Cutoff);
    u_xlat1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    u_xlat16_2 = u_xlat16_2 + 9.99999975e-05;
    u_xlatb1 = u_xlat16_2<0.0;
    if(u_xlatb1){discard;}
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHATEST_ON" "_COLORCOLOR_ON" "_REQUIRE_UV2" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
layout(location = 2) out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec3 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec2 u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
float u_xlat12;
float u_xlat13;
bool u_xlatb18;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = floor(u_xlat1.x);
    u_xlat6.x = u_xlat0.x / unity_ParticleUVShiftData.y;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat0.x = (-u_xlat6.x) * unity_ParticleUVShiftData.y + u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat2.x = u_xlat0.x * unity_ParticleUVShiftData.z;
    u_xlat0.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat2.y = (-u_xlat6.x) * unity_ParticleUVShiftData.w + u_xlat0.x;
    u_xlat6.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat2.xy;
    u_xlatb18 = unity_ParticleUVShiftData.x!=0.0;
    vs_TEXCOORD1.xy = (bool(u_xlatb18)) ? u_xlat6.xy : in_TEXCOORD0.xy;
    u_xlat6.x = u_xlat1.x + 1.0;
    u_xlat1.z = fract(u_xlat1.x);
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat12 = u_xlat6.x / unity_ParticleUVShiftData.y;
    u_xlat12 = floor(u_xlat12);
    u_xlat6.x = (-u_xlat12) * unity_ParticleUVShiftData.y + u_xlat6.x;
    u_xlat2.y = (-u_xlat12) * unity_ParticleUVShiftData.w + u_xlat0.x;
    u_xlat0.x = floor(u_xlat6.x);
    u_xlat2.x = u_xlat0.x * unity_ParticleUVShiftData.z;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat2.xy;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.z = 0.0;
    vs_TEXCOORD2.xyz = (bool(u_xlatb18)) ? u_xlat1.xyz : u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 2) in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
bool u_xlatb6;
mediump vec3 u_xlat16_8;
bool u_xlatb12;
mediump float u_xlat16_14;
mediump float u_xlat16_20;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_0 + (-u_xlat16_1);
    u_xlat0 = vs_TEXCOORD2.zzzz * u_xlat0 + u_xlat16_1;
    u_xlat16_1 = u_xlat0 * _Color;
    u_xlat16_2 = u_xlat16_1.w * vs_COLOR0.w + (-_Cutoff);
    u_xlat16_2 = u_xlat16_2 + 9.99999975e-05;
    u_xlatb12 = u_xlat16_2<0.0;
    if(u_xlatb12){discard;}
    u_xlat16_2 = u_xlat0.y * _Color.y + (-u_xlat16_1.z);
    u_xlatb6 = u_xlat16_1.y>=u_xlat16_1.z;
    u_xlat16_8.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_2 = u_xlat16_8.x * u_xlat16_2 + u_xlat16_1.z;
    u_xlatb6 = u_xlat16_1.x>=u_xlat16_2;
    u_xlat16_8.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_14 = u_xlat0.x * _Color.x + (-u_xlat16_2);
    u_xlat16_2 = u_xlat16_8.x * u_xlat16_14 + u_xlat16_2;
    u_xlat16_0.w = (-vs_COLOR0.x);
    u_xlatb3 = vs_COLOR0.y>=vs_COLOR0.z;
    u_xlat16_1.xy = (-vs_COLOR0.zy) + vs_COLOR0.yz;
    u_xlat16_1.z = float(1.0);
    u_xlat16_1.w = float(-1.0);
    u_xlat16_1 = (bool(u_xlatb3)) ? u_xlat16_1 : vec4(0.0, 0.0, 0.0, -0.0);
    u_xlat16_3.zw = u_xlat16_1.zw + vec2(-1.0, 0.666666687);
    u_xlat16_3.xy = u_xlat16_1.xy + vs_COLOR0.zy;
    u_xlat16_0.xyz = (-u_xlat16_3.xyw);
    u_xlat16_1.yzw = u_xlat16_0.yzw + u_xlat16_3.yzx;
    u_xlat16_1.x = u_xlat16_0.x + vs_COLOR0.x;
    u_xlatb4 = vs_COLOR0.x>=u_xlat16_3.x;
    u_xlat16_0 = (bool(u_xlatb4)) ? u_xlat16_1 : vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_8.x = u_xlat16_0.w + vs_COLOR0.x;
    u_xlat16_5.xyz = u_xlat16_0.xyz + u_xlat16_3.xyw;
    u_xlat16_14 = min(u_xlat16_8.x, u_xlat16_5.y);
    u_xlat16_8.x = u_xlat16_8.x + (-u_xlat16_5.y);
    u_xlat16_14 = (-u_xlat16_14) + u_xlat16_5.x;
    u_xlat16_20 = u_xlat16_14 * 6.0 + 1.00000001e-10;
    u_xlat16_8.x = u_xlat16_8.x / u_xlat16_20;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_5.z;
    u_xlat16_20 = u_xlat16_5.x + 1.00000001e-10;
    u_xlat16_14 = u_xlat16_14 / u_xlat16_20;
    u_xlat16_5.xyz = abs(u_xlat16_8.xxx) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat16_5.xyz = fract(u_xlat16_5.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat16_5.xyz = abs(u_xlat16_5.xyz) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(u_xlat16_14) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_2);
    SV_Target0.w = 1.0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHATEST_ON" "_REQUIRE_UV2" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp float in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.zw;
    vs_TEXCOORD2.z = in_TEXCOORD1;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_0 + (-u_xlat16_1);
    u_xlat0 = vs_TEXCOORD2.zzzz * u_xlat0 + u_xlat16_1;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat16_2 = u_xlat16_0.w * vs_COLOR0.w + (-_Cutoff);
    u_xlat1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    u_xlat16_2 = u_xlat16_2 + 9.99999975e-05;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_2<0.0);
#else
    u_xlatb1 = u_xlat16_2<0.0;
#endif
    if(u_xlatb1){discard;}
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHATEST_ON" "_COLORCOLOR_ON" "_REQUIRE_UV2" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp float in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD0.zw;
    vs_TEXCOORD2.z = in_TEXCOORD1;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
bool u_xlatb6;
mediump vec3 u_xlat16_8;
bool u_xlatb12;
mediump float u_xlat16_14;
mediump float u_xlat16_20;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_0 + (-u_xlat16_1);
    u_xlat0 = vs_TEXCOORD2.zzzz * u_xlat0 + u_xlat16_1;
    u_xlat16_1 = u_xlat0 * _Color;
    u_xlat16_2 = u_xlat16_1.w * vs_COLOR0.w + (-_Cutoff);
    u_xlat16_2 = u_xlat16_2 + 9.99999975e-05;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_2<0.0);
#else
    u_xlatb12 = u_xlat16_2<0.0;
#endif
    if(u_xlatb12){discard;}
    u_xlat16_2 = u_xlat0.y * _Color.y + (-u_xlat16_1.z);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat16_1.y>=u_xlat16_1.z);
#else
    u_xlatb6 = u_xlat16_1.y>=u_xlat16_1.z;
#endif
    u_xlat16_8.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_2 = u_xlat16_8.x * u_xlat16_2 + u_xlat16_1.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat16_1.x>=u_xlat16_2);
#else
    u_xlatb6 = u_xlat16_1.x>=u_xlat16_2;
#endif
    u_xlat16_8.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_14 = u_xlat0.x * _Color.x + (-u_xlat16_2);
    u_xlat16_2 = u_xlat16_8.x * u_xlat16_14 + u_xlat16_2;
    u_xlat16_0.w = (-vs_COLOR0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(vs_COLOR0.y>=vs_COLOR0.z);
#else
    u_xlatb3 = vs_COLOR0.y>=vs_COLOR0.z;
#endif
    u_xlat16_1.xy = (-vs_COLOR0.zy) + vs_COLOR0.yz;
    u_xlat16_1.z = float(1.0);
    u_xlat16_1.w = float(-1.0);
    u_xlat16_1 = (bool(u_xlatb3)) ? u_xlat16_1 : vec4(0.0, 0.0, 0.0, -0.0);
    u_xlat16_3.zw = u_xlat16_1.zw + vec2(-1.0, 0.666666687);
    u_xlat16_3.xy = u_xlat16_1.xy + vs_COLOR0.zy;
    u_xlat16_0.xyz = (-u_xlat16_3.xyw);
    u_xlat16_1.yzw = u_xlat16_0.yzw + u_xlat16_3.yzx;
    u_xlat16_1.x = u_xlat16_0.x + vs_COLOR0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vs_COLOR0.x>=u_xlat16_3.x);
#else
    u_xlatb4 = vs_COLOR0.x>=u_xlat16_3.x;
#endif
    u_xlat16_0 = (bool(u_xlatb4)) ? u_xlat16_1 : vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_8.x = u_xlat16_0.w + vs_COLOR0.x;
    u_xlat16_5.xyz = u_xlat16_0.xyz + u_xlat16_3.xyw;
    u_xlat16_14 = min(u_xlat16_8.x, u_xlat16_5.y);
    u_xlat16_8.x = u_xlat16_8.x + (-u_xlat16_5.y);
    u_xlat16_14 = (-u_xlat16_14) + u_xlat16_5.x;
    u_xlat16_20 = u_xlat16_14 * 6.0 + 1.00000001e-10;
    u_xlat16_8.x = u_xlat16_8.x / u_xlat16_20;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_5.z;
    u_xlat16_20 = u_xlat16_5.x + 1.00000001e-10;
    u_xlat16_14 = u_xlat16_14 / u_xlat16_20;
    u_xlat16_5.xyz = abs(u_xlat16_8.xxx) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat16_5.xyz = fract(u_xlat16_5.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat16_5.xyz = abs(u_xlat16_5.xyz) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(u_xlat16_14) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_2);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
layout(location = 2) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec2 u_xlatu7;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu12 = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu12);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu12 = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.w = float(u_xlatu12);
    u_xlat3.yz = vec2(u_xlatu7.xy);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat12 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.x = (-u_xlat12) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat13 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat12) * unity_ParticleUVShiftData.w + u_xlat13;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
layout(location = 2) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec2 u_xlatu7;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu12 = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu12);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu12 = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.w = float(u_xlatu12);
    u_xlat3.yz = vec2(u_xlatu7.xy);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat12 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.x = (-u_xlat12) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat13 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat12) * unity_ParticleUVShiftData.w + u_xlat13;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHATEST_ON" "_REQUIRE_UV2" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
layout(location = 2) out highp vec3 vs_TEXCOORD2;
layout(location = 3) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec2 u_xlatu7;
float u_xlat12;
uint u_xlatu12;
float u_xlat13;
bool u_xlatb19;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu12 = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu12);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu12 = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.w = float(u_xlatu12);
    u_xlat3.yz = vec2(u_xlatu7.xy);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat12 = floor(u_xlat1.x);
    u_xlat7.x = u_xlat12 / unity_ParticleUVShiftData.y;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat12 = (-u_xlat7.x) * unity_ParticleUVShiftData.y + u_xlat12;
    u_xlat12 = floor(u_xlat12);
    u_xlat2.x = u_xlat12 * unity_ParticleUVShiftData.z;
    u_xlat12 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat2.y = (-u_xlat7.x) * unity_ParticleUVShiftData.w + u_xlat12;
    u_xlat7.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat2.xy;
    u_xlatb19 = unity_ParticleUVShiftData.x!=0.0;
    vs_TEXCOORD1.xy = (bool(u_xlatb19)) ? u_xlat7.xy : in_TEXCOORD0.xy;
    u_xlat7.x = u_xlat1.x + 1.0;
    u_xlat2.z = fract(u_xlat1.x);
    u_xlat1.x = floor(u_xlat7.x);
    u_xlat7.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = (-u_xlat7.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat3.y = (-u_xlat7.x) * unity_ParticleUVShiftData.w + u_xlat12;
    u_xlat12 = floor(u_xlat1.x);
    u_xlat3.x = u_xlat12 * unity_ParticleUVShiftData.z;
    u_xlat2.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat3.xy;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = 0.0;
    vs_TEXCOORD2.xyz = (bool(u_xlatb19)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 2) in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_0 + (-u_xlat16_1);
    u_xlat0 = vs_TEXCOORD2.zzzz * u_xlat0 + u_xlat16_1;
    u_xlat16_0 = u_xlat0 * _Color;
    u_xlat16_2 = u_xlat16_0.w * vs_COLOR0.w + (-_Cutoff);
    u_xlat1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    u_xlat16_2 = u_xlat16_2 + 9.99999975e-05;
    u_xlatb1 = u_xlat16_2<0.0;
    if(u_xlatb1){discard;}
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHATEST_ON" "_COLORCOLOR_ON" "_REQUIRE_UV2" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
layout(location = 2) out highp vec3 vs_TEXCOORD2;
layout(location = 3) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec2 u_xlatu7;
float u_xlat12;
uint u_xlatu12;
float u_xlat13;
bool u_xlatb19;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu12 = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu12);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu12 = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.w = float(u_xlatu12);
    u_xlat3.yz = vec2(u_xlatu7.xy);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat12 = floor(u_xlat1.x);
    u_xlat7.x = u_xlat12 / unity_ParticleUVShiftData.y;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat12 = (-u_xlat7.x) * unity_ParticleUVShiftData.y + u_xlat12;
    u_xlat12 = floor(u_xlat12);
    u_xlat2.x = u_xlat12 * unity_ParticleUVShiftData.z;
    u_xlat12 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat2.y = (-u_xlat7.x) * unity_ParticleUVShiftData.w + u_xlat12;
    u_xlat7.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat2.xy;
    u_xlatb19 = unity_ParticleUVShiftData.x!=0.0;
    vs_TEXCOORD1.xy = (bool(u_xlatb19)) ? u_xlat7.xy : in_TEXCOORD0.xy;
    u_xlat7.x = u_xlat1.x + 1.0;
    u_xlat2.z = fract(u_xlat1.x);
    u_xlat1.x = floor(u_xlat7.x);
    u_xlat7.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = (-u_xlat7.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat3.y = (-u_xlat7.x) * unity_ParticleUVShiftData.w + u_xlat12;
    u_xlat12 = floor(u_xlat1.x);
    u_xlat3.x = u_xlat12 * unity_ParticleUVShiftData.z;
    u_xlat2.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat3.xy;
    u_xlat1.xy = in_TEXCOORD0.xy;
    u_xlat1.z = 0.0;
    vs_TEXCOORD2.xyz = (bool(u_xlatb19)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 2) in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
bool u_xlatb6;
mediump vec3 u_xlat16_8;
bool u_xlatb12;
mediump float u_xlat16_14;
mediump float u_xlat16_20;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_0 + (-u_xlat16_1);
    u_xlat0 = vs_TEXCOORD2.zzzz * u_xlat0 + u_xlat16_1;
    u_xlat16_1 = u_xlat0 * _Color;
    u_xlat16_2 = u_xlat16_1.w * vs_COLOR0.w + (-_Cutoff);
    u_xlat16_2 = u_xlat16_2 + 9.99999975e-05;
    u_xlatb12 = u_xlat16_2<0.0;
    if(u_xlatb12){discard;}
    u_xlat16_2 = u_xlat0.y * _Color.y + (-u_xlat16_1.z);
    u_xlatb6 = u_xlat16_1.y>=u_xlat16_1.z;
    u_xlat16_8.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_2 = u_xlat16_8.x * u_xlat16_2 + u_xlat16_1.z;
    u_xlatb6 = u_xlat16_1.x>=u_xlat16_2;
    u_xlat16_8.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_14 = u_xlat0.x * _Color.x + (-u_xlat16_2);
    u_xlat16_2 = u_xlat16_8.x * u_xlat16_14 + u_xlat16_2;
    u_xlat16_0.w = (-vs_COLOR0.x);
    u_xlatb3 = vs_COLOR0.y>=vs_COLOR0.z;
    u_xlat16_1.xy = (-vs_COLOR0.zy) + vs_COLOR0.yz;
    u_xlat16_1.z = float(1.0);
    u_xlat16_1.w = float(-1.0);
    u_xlat16_1 = (bool(u_xlatb3)) ? u_xlat16_1 : vec4(0.0, 0.0, 0.0, -0.0);
    u_xlat16_3.zw = u_xlat16_1.zw + vec2(-1.0, 0.666666687);
    u_xlat16_3.xy = u_xlat16_1.xy + vs_COLOR0.zy;
    u_xlat16_0.xyz = (-u_xlat16_3.xyw);
    u_xlat16_1.yzw = u_xlat16_0.yzw + u_xlat16_3.yzx;
    u_xlat16_1.x = u_xlat16_0.x + vs_COLOR0.x;
    u_xlatb4 = vs_COLOR0.x>=u_xlat16_3.x;
    u_xlat16_0 = (bool(u_xlatb4)) ? u_xlat16_1 : vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_8.x = u_xlat16_0.w + vs_COLOR0.x;
    u_xlat16_5.xyz = u_xlat16_0.xyz + u_xlat16_3.xyw;
    u_xlat16_14 = min(u_xlat16_8.x, u_xlat16_5.y);
    u_xlat16_8.x = u_xlat16_8.x + (-u_xlat16_5.y);
    u_xlat16_14 = (-u_xlat16_14) + u_xlat16_5.x;
    u_xlat16_20 = u_xlat16_14 * 6.0 + 1.00000001e-10;
    u_xlat16_8.x = u_xlat16_8.x / u_xlat16_20;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_5.z;
    u_xlat16_20 = u_xlat16_5.x + 1.00000001e-10;
    u_xlat16_14 = u_xlat16_14 / u_xlat16_20;
    u_xlat16_5.xyz = abs(u_xlat16_8.xxx) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat16_5.xyz = fract(u_xlat16_5.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat16_5.xyz = abs(u_xlat16_5.xyz) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(u_xlat16_14) * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_2);
    SV_Target0.w = 1.0;
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
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Local Keywords { "_ALPHATEST_ON" "_REQUIRE_UV2" }
""
}
SubProgram "gles3 " {
Local Keywords { "_ALPHATEST_ON" "_COLORCOLOR_ON" "_REQUIRE_UV2" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHATEST_ON" "_REQUIRE_UV2" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHATEST_ON" "_COLORCOLOR_ON" "_REQUIRE_UV2" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHATEST_ON" "_REQUIRE_UV2" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHATEST_ON" "_COLORCOLOR_ON" "_REQUIRE_UV2" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHATEST_ON" "_REQUIRE_UV2" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHATEST_ON" "_COLORCOLOR_ON" "_REQUIRE_UV2" }
""
}
}
}
}
Fallback "VertexLit"
CustomEditor "StandardParticlesShaderGUI"
}