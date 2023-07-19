
package com.blog.entities;

import java.sql.*;

public class User {
       private int id;
       private String name;
       private String email;
       private String password;
       private Timestamp registration_date;
       private String profilePic;

       public User(int id, String name, String email, String password, Timestamp registration_date, String profilePic) {
              this.id = id;
              this.name = name;
              this.email = email;
              this.password = password;
              this.registration_date = registration_date;
              this.profilePic = profilePic;
       }

       public User() {
       }

       public User(String name, String email, String password, String profilePic) {
              this.name = name;
              this.email = email;
              this.password = password; 
              this.profilePic = profilePic;
       }

       public User(String name, String email, String password) {
              this.name = name;
              this.email = email;
              this.password = password;
       }

       
       public int getId() {
              return id;
       }

       public void setId(int id) {
              this.id = id;
       }

       public String getName() {
              return name;
       }

       public void setName(String name) {
              this.name = name;
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

       public Timestamp getRegistration_date() {
              return registration_date;
       }

       public void setRegistration_date(Timestamp registration_date) {
              this.registration_date = registration_date;
       }

       public String getProfilePic() {
              return profilePic;
       }

       public void setProfilePic(String profilePic) {
              this.profilePic = profilePic;
       }
       
}
