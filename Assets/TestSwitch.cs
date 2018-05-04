using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class TestSwitch : MonoBehaviour {

	public Animator animator;
	public float speed;

	void Update () {
		if (Input.GetKey(KeyCode.Space)) {
			animator.SetTrigger("Change");
		}
	}
}
