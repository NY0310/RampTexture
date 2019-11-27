Shader "Hidden/VaryingColor"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_RampTex("RampTexture", 2D) = "white"{}
		_Speed ("Speed", Range(1, 10)) = 1
	}
	SubShader
	{
		// No culling or dept

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
			sampler2D _RampTex;
			float _Speed;

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				return tex2D(_RampTex,fixed2(col.r + _Time.x * _Speed,0.5));
			}
			ENDCG
		}
	}
}
