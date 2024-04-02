package com.example.messageapp

import android.app.Activity
import android.content.Intent
import android.graphics.drawable.BitmapDrawable
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.provider.MediaStore
import android.util.Log
import android.widget.Toast
import com.example.messageapp.databinding.ActivityRegisterBinding
import com.google.firebase.Firebase
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.auth
import com.google.firebase.database.FirebaseDatabase
import com.google.firebase.database.database
import com.google.firebase.firestore.auth.User
import com.google.firebase.storage.FirebaseStorage
import java.util.UUID

private const val TAG = "RegisterActivity"

class RegisterActivity : AppCompatActivity() {
    private val binding by lazy { ActivityRegisterBinding.inflate(layoutInflater) }
    private lateinit var auth: FirebaseAuth
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(binding.root)
        auth = Firebase.auth
        binding.btnSelectPt.setOnClickListener {
            val intent = Intent(Intent.ACTION_PICK)
            intent.type = "image/*"
            startActivityForResult(intent, 0)
        }
        binding.btnRegister.setOnClickListener {
            val accout = Accout(binding.email.text.toString(), binding.password.text.toString())
            registerUser(accout)
        }
        binding.tvLogin.setOnClickListener {
            startActivity(Intent(this, LoginActivity::class.java))
            finish()
        }
    }

    var selectPhotoUri: Uri? = null
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        Log.e(TAG, "onActivityResult: $resultCode")
        if (requestCode == 0 && resultCode == Activity.RESULT_OK && data != null) {
            selectPhotoUri = data?.data
            val bitmap =
                BitmapDrawable(MediaStore.Images.Media.getBitmap(contentResolver, selectPhotoUri))
            binding.btnSelectPt.setImageDrawable(bitmap)
        }
    }

    private fun registerUser(accout: Accout) {
        auth.createUserWithEmailAndPassword(accout.name, accout.password)
            .addOnCompleteListener(this) {
                if (it.isSuccessful) {
                    Toast.makeText(this, "Thanh Cong", Toast.LENGTH_SHORT).show()
                    uploadInamgeToStorage()
                } else {
                    Toast.makeText(
                        baseContext,
                        "Authentication failed.",
                        Toast.LENGTH_SHORT,
                    ).show()
                }
            }
    }

    private fun uploadInamgeToStorage() {
        val fileName = UUID.randomUUID().toString()
        val ref = FirebaseStorage.getInstance().getReference("/image/$fileName")
        ref.putFile(selectPhotoUri!!).addOnSuccessListener {
            Log.e(TAG, "uploadInamgeToStorage: ${it.metadata?.path}")
            val profileImageUri = it
            ref.downloadUrl.addOnSuccessListener {
                Log.e(TAG, ": $it")
                saveUserToFireDataBase(it.toString())
            }
        }
    }

    private fun saveUserToFireDataBase(profileImageUri: String) {
        val uid = FirebaseAuth.getInstance().uid ?: ""
        val myRef = FirebaseDatabase.getInstance().getReference("/user/$uid")
        val user = User(uid, binding.tvUserName.text.toString(), profileImageUri)
        myRef.setValue(user)
            .addOnSuccessListener { Log.e(TAG, "saveUserToFireDataBase: finally....") }
            .addOnFailureListener { Log.e(TAG, "saveUserToFireDataBase: ${it.message}") }
    }


}