// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Shaders101/Basic"
{
	Properties {
		_MainTex("Texture", 2D) = "white" {}
		_Tint("Tint", Color) = (1,1,1,1)
	}

	SubShader
	{
		Tags
		{
			"PreviewType" = "Plane"
			"Queue" = "Transparent"
		}
		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			sampler2D _MainTex;
			float4 _Tint;

			float4 frag(v2f i) : SV_Target
			{
				float4 color = tex2D(_MainTex, i.uv);
				float luminance = 0.3f * color.r + 0.59f * color.g + 0.11f * color.b;
				return float4(luminance, luminance, luminance, color.a) * _Tint;
			}
			ENDCG
		}
	}
}