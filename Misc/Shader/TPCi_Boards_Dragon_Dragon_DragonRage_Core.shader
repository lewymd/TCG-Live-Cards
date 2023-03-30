//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "TPCi/Boards/Dragon/Dragon_DragonRage_Core" {
Properties {
_T_VFX_Dragon_DragonRage_Tiling ("T_VFX_Dragon_DragonRage_Tiling", 2D) = "white" { }
_panning ("panning", Vector) = (0,1,0,0)
_BaseColor ("Base Color", Color) = (0.2882414,0.07320219,0.4433962,0)
_tiling ("tiling", Vector) = (1,1,0,0)
_offset ("offset", Vector) = (0,0,0,0)
_T_VFX_Shared_Distortion_RenderClouds_RG ("T_VFX_Shared_Distortion_RenderClouds_RG", 2D) = "white" { }
_distortion ("distortion", Float) = 0.05
_DistortionPanner ("Distortion Panner", Vector) = (0,0.5,0,0)
_T_VFX_Shared_RenderClouds_Minimize ("T_VFX_Shared_RenderClouds_Minimize", 2D) = "white" { }
_innerfirePanning ("inner fire Panning", Vector) = (0,0,0,0)
_innerfiretiling ("inner fire tiling", Vector) = (1,0.5,0,0)
_BitsColor ("Bits Color", Color) = (1,0.2877358,0.9879264,0)
_innerfireOffset ("inner fire Offset", Vector) = (0,0,0,0)
_overallemission ("overall emission", Float) = 1
_BitsEmission ("Bits Emission", Float) = 1
_T_VFX_Dragon_DragonRage_Head ("T_VFX_Dragon_DragonRage_Head", 2D) = "white" { }
_HeadMaskOffset ("Head Mask Offset", Vector) = (0,0.45,0,0)
_HeeadMaskMult ("Heead Mask Mult", Float) = 1.5
_EdgeDissolveTexture ("Edge Dissolve Texture", 2D) = "white" { }
_EdgeDissolve1Tiling ("Edge Dissolve 1 Tiling", Vector) = (0.5,1,0,0)
_EdgeDissolve1Offset ("Edge Dissolve 1 Offset", Vector) = (0,0,0,0)
_EdgeDissolve2Panning ("Edge Dissolve 2 Panning", Vector) = (0.4,0.8,0,0)
_EdgeDissolve2Tiling ("Edge Dissolve 2 Tiling", Vector) = (1.5,1,0,0)
_EdgeDissolve2Offset ("Edge Dissolve 2 Offset", Vector) = (0.25,0.25,0,0)
_EdgeDissolveLerp ("Edge Dissolve Lerp", Float) = 0
_HeadMaskOffsetParticle ("Head Mask Offset Particle?", Float) = 0
_CoreColor ("Core Color", Color) = (0,0,0,0)
_CoreColorBrightness ("Core Color Brightness", Float) = 1
_CoreColorMult ("Core Color Mult", Float) = 1
_CoreColorPower ("Core Color Power", Float) = 1
_texcoord ("", 2D) = "white" { }
_tex4coord ("", 2D) = "white" { }
__dirty ("", Float) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask RGB 0
  ZWrite Off
  Cull Off
  GpuProgramID 4994
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _tex4coord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec4 _BaseColor;
uniform 	float _CoreColorBrightness;
uniform 	vec4 _CoreColor;
uniform 	float _CoreColorMult;
uniform 	float _CoreColorPower;
uniform 	vec4 _BitsColor;
uniform 	float _BitsEmission;
uniform 	vec2 _EdgeDissolve1Tiling;
uniform 	vec2 _EdgeDissolve1Offset;
uniform 	vec2 _EdgeDissolve2Panning;
uniform 	vec2 _EdgeDissolve2Tiling;
uniform 	vec2 _EdgeDissolve2Offset;
uniform 	vec2 _innerfirePanning;
uniform 	vec2 _innerfiretiling;
uniform 	vec2 _innerfireOffset;
uniform 	float _overallemission;
uniform 	float _HeeadMaskMult;
uniform 	vec2 _HeadMaskOffset;
uniform 	float _HeadMaskOffsetParticle;
uniform 	vec2 _panning;
uniform 	float _distortion;
uniform 	vec2 _DistortionPanner;
uniform 	vec2 _tiling;
uniform 	vec2 _offset;
uniform 	float _EdgeDissolveLerp;
UNITY_LOCATION(0) uniform mediump sampler2D _EdgeDissolveTexture;
UNITY_LOCATION(1) uniform mediump sampler2D _T_VFX_Shared_RenderClouds_Minimize;
UNITY_LOCATION(2) uniform mediump sampler2D _T_VFX_Dragon_DragonRage_Head;
UNITY_LOCATION(3) uniform mediump sampler2D _T_VFX_Shared_Distortion_RenderClouds_RG;
UNITY_LOCATION(4) uniform mediump sampler2D _T_VFX_Dragon_DragonRage_Tiling;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
float u_xlat10;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.y * _innerfiretiling.xxxy.w;
    u_xlat0.y = _innerfireOffset.y * vs_TEXCOORD1.w + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD0.x * _innerfiretiling.xxxy.z + _innerfireOffset.x;
    u_xlat0.xy = _Time.yy * _innerfirePanning.xy + u_xlat0.xy;
    u_xlat16_0 = texture(_T_VFX_Shared_RenderClouds_Minimize, u_xlat0.xy).x;
    u_xlat0.x = u_xlat16_0 + -0.319999993;
    u_xlat0.x = u_xlat0.x * 2.49999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD0.x;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 2.55999994;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 15.0;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _CoreColorPower;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _CoreColorMult;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(_CoreColorBrightness) * _CoreColor.xyz + (-_BaseColor.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz + _BaseColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(_EdgeDissolve1Tiling.x, _EdgeDissolve1Tiling.y) + _EdgeDissolve1Offset.xy;
    u_xlat1.xy = _Time.yy * vec2(0.25, 0.600000024) + u_xlat1.xy;
    u_xlat16_1.xyz = texture(_EdgeDissolveTexture, u_xlat1.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _EdgeDissolve2Tiling.xy + vec2(_EdgeDissolve2Offset.x, _EdgeDissolve2Offset.y);
    u_xlat2.xy = _Time.yy * vec2(_EdgeDissolve2Panning.x, _EdgeDissolve2Panning.y) + u_xlat2.xy;
    u_xlat16_2.xyz = texture(_EdgeDissolveTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = (-u_xlat16_1.xyz) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10 = vs_TEXCOORD0.y + 1.11000001;
    u_xlat1.xyz = (-u_xlat1.xyz) + vec3(u_xlat10);
    u_xlat1.xyz = log2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.79999995, 1.79999995, 1.79999995);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz + vec3(-0.289999992, -0.289999992, -0.289999992);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.53846157, 1.53846157, 1.53846157);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xyz = min(max(u_xlat1.xyz, 0.0), 1.0);
#else
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.xyz * vec3(-2.0, -2.0, -2.0) + vec3(3.0, 3.0, 3.0);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat4.xyz = u_xlat1.xyz * vec3(_BitsEmission);
    u_xlat4.xyz = _BitsColor.xyz * u_xlat4.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_overallemission, _overallemission, _overallemission));
    u_xlat2.y = vs_TEXCOORD1.z * _HeadMaskOffset.y;
    u_xlat2.x = _HeadMaskOffset.x;
    u_xlat4.xy = u_xlat2.xy + (-_HeadMaskOffset.xy);
    u_xlat4.xy = vec2(vec2(_HeadMaskOffsetParticle, _HeadMaskOffsetParticle)) * u_xlat4.xy + _HeadMaskOffset.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 0.150000006) + u_xlat4.xy;
    u_xlat16_4 = texture(_T_VFX_Dragon_DragonRage_Head, u_xlat4.xy).x;
    u_xlat4.x = u_xlat16_4 * _HeeadMaskMult;
    u_xlat7.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat7.x * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 0.25);
    u_xlat7.xy = _Time.yy * _DistortionPanner.xy + u_xlat7.xy;
    u_xlat16_7.xy = texture(_T_VFX_Shared_Distortion_RenderClouds_RG, u_xlat7.xy).xy;
    u_xlat2.x = vs_TEXCOORD0.y * _tiling.xxxy.w;
    u_xlat2.y = _offset.y * vs_TEXCOORD1.w + u_xlat2.x;
    u_xlat2.x = vs_TEXCOORD0.x * _tiling.xxxy.z + _offset.x;
    u_xlat7.xy = vec2(vec2(_distortion, _distortion)) * u_xlat16_7.xy + u_xlat2.xy;
    u_xlat7.xy = _Time.yy * _panning.xy + u_xlat7.xy;
    u_xlat16_7.x = texture(_T_VFX_Dragon_DragonRage_Tiling, u_xlat7.xy).x;
    u_xlat4.x = u_xlat16_7.x * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * 6.25;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat7.x * u_xlat1.x + (-u_xlat4.x);
    u_xlat0.w = _EdgeDissolveLerp * u_xlat1.x + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
uniform 	vec4 _tex4coord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _tex4coord_ST.xy + _tex4coord_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec4 _BaseColor;
uniform 	float _CoreColorBrightness;
uniform 	vec4 _CoreColor;
uniform 	float _CoreColorMult;
uniform 	float _CoreColorPower;
uniform 	vec4 _BitsColor;
uniform 	float _BitsEmission;
uniform 	vec2 _EdgeDissolve1Tiling;
uniform 	vec2 _EdgeDissolve1Offset;
uniform 	vec2 _EdgeDissolve2Panning;
uniform 	vec2 _EdgeDissolve2Tiling;
uniform 	vec2 _EdgeDissolve2Offset;
uniform 	vec2 _innerfirePanning;
uniform 	vec2 _innerfiretiling;
uniform 	vec2 _innerfireOffset;
uniform 	float _overallemission;
uniform 	float _HeeadMaskMult;
uniform 	vec2 _HeadMaskOffset;
uniform 	float _HeadMaskOffsetParticle;
uniform 	vec2 _panning;
uniform 	float _distortion;
uniform 	vec2 _DistortionPanner;
uniform 	vec2 _tiling;
uniform 	vec2 _offset;
uniform 	float _EdgeDissolveLerp;
UNITY_LOCATION(0) uniform mediump sampler2D _EdgeDissolveTexture;
UNITY_LOCATION(1) uniform mediump sampler2D _T_VFX_Shared_RenderClouds_Minimize;
UNITY_LOCATION(2) uniform mediump sampler2D _T_VFX_Dragon_DragonRage_Head;
UNITY_LOCATION(3) uniform mediump sampler2D _T_VFX_Shared_Distortion_RenderClouds_RG;
UNITY_LOCATION(4) uniform mediump sampler2D _T_VFX_Dragon_DragonRage_Tiling;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
vec2 u_xlat7;
mediump vec2 u_xlat16_7;
float u_xlat10;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.y * _innerfiretiling.xxxy.w;
    u_xlat0.y = _innerfireOffset.y * vs_TEXCOORD1.w + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD0.x * _innerfiretiling.xxxy.z + _innerfireOffset.x;
    u_xlat0.xy = _Time.yy * _innerfirePanning.xy + u_xlat0.xy;
    u_xlat16_0 = texture(_T_VFX_Shared_RenderClouds_Minimize, u_xlat0.xy).x;
    u_xlat0.x = u_xlat16_0 + -0.319999993;
    u_xlat0.x = u_xlat0.x * 2.49999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD0.x;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 2.55999994;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 15.0;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _CoreColorPower;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _CoreColorMult;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(_CoreColorBrightness) * _CoreColor.xyz + (-_BaseColor.xyz);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz + _BaseColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(_EdgeDissolve1Tiling.x, _EdgeDissolve1Tiling.y) + _EdgeDissolve1Offset.xy;
    u_xlat1.xy = _Time.yy * vec2(0.25, 0.600000024) + u_xlat1.xy;
    u_xlat16_1.xyz = texture(_EdgeDissolveTexture, u_xlat1.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _EdgeDissolve2Tiling.xy + vec2(_EdgeDissolve2Offset.x, _EdgeDissolve2Offset.y);
    u_xlat2.xy = _Time.yy * vec2(_EdgeDissolve2Panning.x, _EdgeDissolve2Panning.y) + u_xlat2.xy;
    u_xlat16_2.xyz = texture(_EdgeDissolveTexture, u_xlat2.xy).xyz;
    u_xlat1.xyz = (-u_xlat16_1.xyz) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10 = vs_TEXCOORD0.y + 1.11000001;
    u_xlat1.xyz = (-u_xlat1.xyz) + vec3(u_xlat10);
    u_xlat1.xyz = log2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.79999995, 1.79999995, 1.79999995);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz + vec3(-0.289999992, -0.289999992, -0.289999992);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.53846157, 1.53846157, 1.53846157);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xyz = min(max(u_xlat1.xyz, 0.0), 1.0);
#else
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.xyz * vec3(-2.0, -2.0, -2.0) + vec3(3.0, 3.0, 3.0);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat4.xyz = u_xlat1.xyz * vec3(_BitsEmission);
    u_xlat4.xyz = _BitsColor.xyz * u_xlat4.xyz + (-u_xlat3.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_overallemission, _overallemission, _overallemission));
    u_xlat2.y = vs_TEXCOORD1.z * _HeadMaskOffset.y;
    u_xlat2.x = _HeadMaskOffset.x;
    u_xlat4.xy = u_xlat2.xy + (-_HeadMaskOffset.xy);
    u_xlat4.xy = vec2(vec2(_HeadMaskOffsetParticle, _HeadMaskOffsetParticle)) * u_xlat4.xy + _HeadMaskOffset.xy;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 0.150000006) + u_xlat4.xy;
    u_xlat16_4 = texture(_T_VFX_Dragon_DragonRage_Head, u_xlat4.xy).x;
    u_xlat4.x = u_xlat16_4 * _HeeadMaskMult;
    u_xlat7.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat7.x * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat7.xy = vs_TEXCOORD0.xy * vec2(1.0, 0.25);
    u_xlat7.xy = _Time.yy * _DistortionPanner.xy + u_xlat7.xy;
    u_xlat16_7.xy = texture(_T_VFX_Shared_Distortion_RenderClouds_RG, u_xlat7.xy).xy;
    u_xlat2.x = vs_TEXCOORD0.y * _tiling.xxxy.w;
    u_xlat2.y = _offset.y * vs_TEXCOORD1.w + u_xlat2.x;
    u_xlat2.x = vs_TEXCOORD0.x * _tiling.xxxy.z + _offset.x;
    u_xlat7.xy = vec2(vec2(_distortion, _distortion)) * u_xlat16_7.xy + u_xlat2.xy;
    u_xlat7.xy = _Time.yy * _panning.xy + u_xlat7.xy;
    u_xlat16_7.x = texture(_T_VFX_Dragon_DragonRage_Tiling, u_xlat7.xy).x;
    u_xlat4.x = u_xlat16_7.x * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * 6.25;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat7.x * u_xlat1.x + (-u_xlat4.x);
    u_xlat0.w = _EdgeDissolveLerp * u_xlat1.x + u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
}
}
}
CustomEditor "ASEMaterialInspector"
}