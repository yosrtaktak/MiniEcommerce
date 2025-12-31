package com.example.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class User implements Serializable {

  private Long id;
  private String email;
  private String password;
  private String fullname;
  private Role role;
  private Timestamp createdAt;

  public User() {
  }

  public User(String email, String password, String fullname, Role role) {
    this.email = email;
    this.password = password;
    this.fullname = fullname;
    this.role = role;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public String getFullname() {
    return fullname;
  }

  public void setFullname(String fullname) {
    this.fullname = fullname;
  }

  public Role getRole() {
    return role;
  }

  public void setRole(Role role) {
    this.role = role;
  }

  public Timestamp getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(Timestamp createdAt) {
    this.createdAt = createdAt;
  }
}
