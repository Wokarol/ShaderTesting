using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(SpriteRenderer))]
public class AlphaCutOff : MonoBehaviour {
	public Texture CutTex;
	[Range(0,1)]
	public float Percentage;

	public SpriteRenderer sprite;

	private void Start () {
		sprite = GetComponent<SpriteRenderer>();
	}

	public void Update() {
		sprite.material.SetFloat("_Percentage", Percentage);
	}

}
