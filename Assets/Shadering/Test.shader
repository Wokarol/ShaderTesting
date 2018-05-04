// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Shaders101/Basic"
{
	Properties {
		 
		_MainTex("Texture", 2D) = "white" {}
		_CutTex("CutingTex", 2D) = "white" {}
		_Percentage("Percentage", Range(0, 1)) = 1
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
				float4 color : COLOR;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				float4 color : COLOR;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				o.color = v.color;
				return o;
			}

			sampler2D _MainTex;
			sampler2D _CutTex;
			float _Percentage;

			float4 frag(v2f i) : SV_Target
			{
				float4 col = tex2D(_MainTex, i.uv) * i.color;
				float4 cutColor = tex2D(_CutTex, i.uv);
				if(cutColor.r < _Percentage){
					col = float4(0,0,0,0);
				}
				return col;
			}
			ENDCG
		}
	}
}