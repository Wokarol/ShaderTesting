using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class RenderTexResizer : MonoBehaviour {

	public Camera myCamera;

	void Update () {
		if (myCamera.targetTexture != null) {
			myCamera.targetTexture.Release();
		}

		myCamera.targetTexture = new RenderTexture(Screen.width, Screen.height, 24);
	}
}
