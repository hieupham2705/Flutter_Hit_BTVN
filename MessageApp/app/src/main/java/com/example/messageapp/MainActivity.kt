package com.example.messageapp

import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.example.messageapp.databinding.ActivityMainBinding
import com.example.messageapp.databinding.ItemMemberBinding
import com.google.firebase.Firebase
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.auth
import com.google.firebase.database.DataSnapshot
import com.google.firebase.database.DatabaseError
import com.google.firebase.database.FirebaseDatabase
import com.google.firebase.database.ValueEventListener

private const val TAG = "MainActivity"

class MainActivity : AppCompatActivity() {
    private val listAdapter = mutableListOf<User>()
    private val binding by lazy { ActivityMainBinding.inflate(layoutInflater) }
    private val adapter by lazy {
        MemberAdapter(applicationContext, ::startChat)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(binding.root)
        binding.recyclerview.adapter = adapter
        loadUI()
    }

    private fun loadUI() {
        val ref = FirebaseDatabase.getInstance().getReference("/user")
        ref.addListenerForSingleValueEvent(object : ValueEventListener {
            override fun onCancelled(error: DatabaseError) {

            }

            override fun onDataChange(snapshot: DataSnapshot) {
                listAdapter.clear()
                snapshot.children.forEach {
                    val user = it.getValue(User::class.java)
                    if (user != null) {
                        listAdapter.add(user)
                    }
                }
                adapter.setAdapter(listAdapter)
            }
        })
        ref.addValueEventListener(object : ValueEventListener {
            override fun onCancelled(error: DatabaseError) {

            }

            override fun onDataChange(snapshot: DataSnapshot) {
                listAdapter.clear()
                snapshot.children.forEach {
                    val user = it.getValue(User::class.java)
                    if (user != null) {
                        listAdapter.add(user)
                    }
                }
                Log.e(TAG, "onDataChange: ${listAdapter.size}", )
                adapter.setAdapter(listAdapter)
            }
        })
    }
    private fun startChat(idMember:String){
        var intent = Intent(this,ChatActivity::class.java)
        intent.putExtra("idMember",idMember)
        startActivity(intent)
    }

    class MemberAdapter(private val context: Context, private val startChat: (idMember:String) -> Unit) :
        RecyclerView.Adapter<MemberAdapter.ViewHolder>() {

        private val listAdapter = mutableListOf<User>()

        class ViewHolder(val binding: ItemMemberBinding) : RecyclerView.ViewHolder(binding.root) {

        }

        override fun onCreateViewHolder(
            parent: ViewGroup,
            viewType: Int
        ): MemberAdapter.ViewHolder {
            return ViewHolder(
                ItemMemberBinding.inflate(
                    LayoutInflater.from(parent.context),
                    parent,
                    false
                )
            )
        }

        override fun onBindViewHolder(holder: MemberAdapter.ViewHolder, position: Int) {
            holder.binding.apply {
                Glide.with(
                    context
                )
                    .load(listAdapter[position].profileImageUri)
                    .into(imvAvt);
                tvName.text = listAdapter[position].userName
                root.setOnClickListener {
                    startChat.invoke(listAdapter[position].uid)
                }
            }
        }

        override fun getItemCount(): Int = listAdapter.size
        fun setAdapter(list: List<User>) {
            listAdapter.clear()
            listAdapter.addAll(list)
            notifyDataSetChanged()
        }
    }


}