using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class CustomEffectCam : MonoBehaviour {

	public Material EffectMaterial;
	[Range(0, 1)]
	public float percentage;
	public Texture cutTex;
	public Color flashColor = Color.white;
	[Range(0, 5)]public float flashTime = 1;
	public bool reverseFlashing;

	[Space]
	public Camera secTexCamera;


	public void OnRenderImage (RenderTexture source, RenderTexture destination) {
		if(EffectMaterial != null) {
			EffectMaterial.SetFloat("_Percentage", percentage);
			EffectMaterial.SetInt("_ReverseFlashing", (reverseFlashing)?1:0);
			EffectMaterial.SetTexture("_SecTex", secTexCamera.targetTexture);
			EffectMaterial.SetTexture("_CutTex", cutTex);
			EffectMaterial.SetColor("_FlashColor", flashColor);
			EffectMaterial.SetFloat("_FlashTime", flashTime);
			Graphics.Blit(source, destination, EffectMaterial);
		}

	}

}
