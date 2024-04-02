package com.example.messageapp

data class SendMessage(
    val message: String,
    val fromID: String,
    val toID: String,
    val date: String
) {
    constructor() : this("", "", "", "")
}