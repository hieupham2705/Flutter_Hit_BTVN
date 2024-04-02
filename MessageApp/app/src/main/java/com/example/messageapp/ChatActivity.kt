package com.example.messageapp

import android.content.Context
import android.icu.util.Calendar
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.example.messageapp.databinding.ActivityChatBinding
import com.example.messageapp.databinding.ChatFromRowBinding
import com.example.messageapp.databinding.ItemSendBinding
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.database.DataSnapshot
import com.google.firebase.database.DatabaseError
import com.google.firebase.database.FirebaseDatabase
import com.google.firebase.database.ValueEventListener
import com.google.firebase.storage.FirebaseStorage

private const val TAG = "ChatActivity"

class ChatActivity : AppCompatActivity() {
    private val binding by lazy { ActivityChatBinding.inflate(layoutInflater) }
    private val adapter by lazy { ChatAdapter(this) }
    private val listChat = mutableListOf<SendMessage>()
    lateinit var toId: String
    lateinit var fromId: String
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(binding.root)
        toId = intent.getStringExtra("idMember").toString()
        fromId = FirebaseAuth.getInstance().uid ?: ""
        binding.recycleview.adapter = adapter
        binding.buttonSend.setOnClickListener {
            sendMessage()
        }
        loadUI()
    }

    private fun sendMessage() {
        val calendar = Calendar.getInstance()
        val date = calendar.get(Calendar.DATE)
        val sendMessage = SendMessage(
            binding.textMessage.text.toString(),
            fromId,
            toId.toString(),
            date.toString()
        )
        val reference =
            FirebaseDatabase.getInstance().getReference("/user-messages/$fromId/$toId").push()
        reference.setValue(sendMessage)
        val toReference =
            FirebaseDatabase.getInstance().getReference("/user-messages/$toId/$fromId").push()
        toReference.setValue(sendMessage)
    }

    private fun loadUI() {
        val idUser = FirebaseAuth.getInstance().uid
        val ref = FirebaseDatabase.getInstance().getReference("/user-messages/$fromId/$toId")
        ref.addListenerForSingleValueEvent(object : ValueEventListener {
            override fun onCancelled(error: DatabaseError) {

            }

            override fun onDataChange(snapshot: DataSnapshot) {
                listChat.clear()
                snapshot.children.forEach {
                    val message = it.getValue(SendMessage::class.java)
                    if (message != null) {
                        listChat.add(message)
                    }
                }
                adapter.setAdapter(listChat)
            }
        })
        ref.addValueEventListener(object : ValueEventListener {
            override fun onCancelled(error: DatabaseError) {

            }

            override fun onDataChange(snapshot: DataSnapshot) {
                listChat.clear()
                snapshot.children.forEach {
                    val message = it.getValue(SendMessage::class.java)
                    if (message != null) {
                        listChat.add(message)
                    }
                }
                Log.e(TAG, "onDataChange: ${listChat.size}")
                adapter.setAdapter(listChat)
                binding.recycleview.scrollToPosition(listChat.size-1)
            }
        })
    }

    class ChatAdapter(private val context: Context) :
        RecyclerView.Adapter<RecyclerView.ViewHolder>() {
        private val listChat = mutableListOf<SendMessage>()
        private val typeSend = 0;
        private val typeReceiver = 1;

        class ViewHolderSendMessage(val binding: ItemSendBinding) :
            RecyclerView.ViewHolder(binding.root) {
        }

        class ViewHolderReceiveMessage(val binding: ChatFromRowBinding) :
            RecyclerView.ViewHolder(binding.root) {

        }

        override fun getItemViewType(position: Int): Int {
            val idUser = FirebaseAuth.getInstance().uid
            return when (listChat[position].fromID) {
                idUser -> typeSend
                else -> typeReceiver
            }
        }

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
            val layoutInflater = LayoutInflater.from(parent.context)
            val bindingSend = ItemSendBinding.inflate(layoutInflater, parent, false)
            val bindingReceive = ChatFromRowBinding.inflate(layoutInflater, parent, false)
            return when (viewType) {
                typeSend -> ViewHolderSendMessage(bindingSend)
                else -> ViewHolderReceiveMessage(bindingReceive)
            }
        }

        override fun getItemCount(): Int = listChat.size

        override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
            if (holder is ViewHolderSendMessage) {
                holder.binding.apply {
                    val sendMessage = listChat[position]
                    Log.e(TAG, "onBindViewHolder: ${sendMessage.toString()}")
                    textviewToRow.text = sendMessage.message
                    toMsgTime.text = sendMessage.date
                    val ref =
                        FirebaseDatabase.getInstance().getReference("user/${sendMessage.fromID}")
                    ref.get().addOnSuccessListener {
                        val user = it.getValue(User::class.java)
                        Glide.with(context).load(user?.profileImageUri).into(imageviewChatToRow)
                    }
                }
            }
            if (holder is ViewHolderReceiveMessage) {
                holder.binding.apply {
                    val sendMessage = listChat[position]
                    Log.e(TAG, "onBindViewHolder: ${sendMessage.toString()}")
                    textviewFromRow.text = sendMessage.message
                    fromMsgTime.text = sendMessage.date
                    val ref =
                        FirebaseDatabase.getInstance().getReference("user/${sendMessage.toID}")
                    ref.get().addOnSuccessListener {
                        val user = it.getValue(User::class.java)
                        Glide.with(context).load(user?.profileImageUri).into(imageviewChatFromRow)
                    }
                }
            }
        }

        fun setAdapter(list: List<SendMessage>) {
            listChat.clear()
            listChat.addAll(list)
            notifyDataSetChanged()
        }
    }
}