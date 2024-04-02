package com.example.messageapp

import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import com.example.messageapp.databinding.ActivityLoginBinding
import com.google.firebase.Firebase
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.auth
import com.google.firebase.firestore.FirebaseFirestore

class LoginActivity : AppCompatActivity() {
    private lateinit var auth: FirebaseAuth
    private val biding by lazy { ActivityLoginBinding.inflate(layoutInflater) }
    private lateinit var sharedPreferences : SharedPreferences
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        auth = Firebase.auth
        sharedPreferences = getSharedPreferences("User", Context.MODE_PRIVATE)
        setContentView(biding.root)
        biding.signIn.setOnClickListener {
            loginUser(Accout(biding.email.text.toString(), biding.password.text.toString()))
        }
        biding.tvRegister.setOnClickListener {
            startActivity(
                Intent(
                    this,
                    RegisterActivity::class.java
                )
            )
        }
    }

    private fun loginUser(accout: Accout) {

        auth.signInWithEmailAndPassword(accout.name, accout.password)
            .addOnCompleteListener(this) {
                if (it.isSuccessful) {
                    Toast.makeText(this, "Thanh Cong", Toast.LENGTH_SHORT).show()
                    val user = auth.currentUser
                    if(biding.rememberMe.isChecked){
                        val editor = sharedPreferences.edit()
                        editor.putString("Accout",accout.name)
                        editor.putString("Password",accout.password)
                        editor.apply()
                    }
                    startActivity(Intent(this, MainActivity::class.java))
                } else {
                    Toast.makeText(
                        baseContext,
                        "Authentication failed.",
                        Toast.LENGTH_SHORT,
                    ).show()
                }
            }
    }
}