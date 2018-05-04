using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Camera))]
[ExecuteInEditMode]
public class SecCamera : MonoBehaviour {
	public Vector3 offset;
	public Camera target;
	public Camera me;

	private void Start () {
		me = GetComponent<Camera>();
	}

	void LateUpdate () {
		if(target == null || me == null) {
			return;
		}
		transform.position = target.transform.position + offset;
		transform.rotation = target.transform.rotation;
		me.orthographicSize = target.orthographicSize;
	}
}
