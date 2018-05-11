Shader "Hidden/CameraBlending"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_DistTex ("Distortion texture", 2D) = "white" {}
		_Strenght ("Strenght", Range(0,1)) = 1
		_Speed("Speed", Range(0,2)) = 1
		_SinForce("Sinforce", Range(0,8)) = 1
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
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
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			sampler2D _DistTex;
			float _Strenght;
			float _Speed;
			float _SinForce;

			fixed4 frag (v2f i) : SV_Target
			{
				float2 offset = float2(_Time.y,_Time.y)*_Speed;
				fixed4 distColor = tex2D(_DistTex, i.uv + offset);
				float2 uvOffset;
				uvOffset.x = (distColor.r-0.5) * _Strenght * (sin(_Time.y * _SinForce)+1.8) ;
				uvOffset.y = (distColor.g - 0.5) * _Strenght * (sin(_Time.y * _SinForce) + 1.8);;

				return tex2D(_MainTex, i.uv + uvOffset);
			}
			ENDCG
		}
	}
}
