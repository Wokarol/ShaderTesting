Shader "Hidden/CameraBlending"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_SecTex ("Second texture", 2D) = "white" {}
		_CutTex ("Cutoff texture", 2D) = "white" {}
		_Percentage("Percentage", Range(0,1)) = 1
		_FlashColor("Flash color", Color) = (1,1,1,1)
		_FlashTime("Percentage", Float) = 1
		[Toggle] _ReverseFlashing("Direction", Int) = 1
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
			sampler2D _CutTex;
			sampler2D _SecTex;
			float _Percentage;
			int _ReverseFlashing;
			fixed4 _FlashColor;
			float _FlashTime;

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 primCol = tex2D(_MainTex, i.uv);
				fixed4 secCol = tex2D(_SecTex, i.uv);
				float primPrior = _Percentage == 0;
				float secPrior = _Percentage == 1;
				fixed4 cutoffCol = tex2D(_CutTex, i.uv);
				fixed4 colToShow;

				float primOrSec = step(_Percentage, cutoffCol.r);
				colToShow = primCol * primOrSec + secCol * (1- primOrSec);


				float a = 1 - ((_Percentage - cutoffCol.r) * 10 / (_FlashTime+0.000001)) * (1-(2*_ReverseFlashing));
				a *= (1- step(a, 0) - step(1, a));

				colToShow = _FlashColor*a + colToShow*(1-a);
				colToShow = colToShow * (1-(secPrior+primPrior)) + primCol * primPrior + secCol * secPrior;
				

				return colToShow;
			}
			ENDCG
		}
	}
}
