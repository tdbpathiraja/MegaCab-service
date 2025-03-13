package com.megacabproject.models;

public class User {
    private int id;
    private String regNumber;
    private String username;
    private String fullName;
    private String address;
    private String telephone;
    private String nic;
    private String email;
    private String password;

    // Constructor
    public User(int id, String regNumber, String username, String fullName, String address,
                String telephone, String nic, String email, String password) {
        this.id = id;
        this.regNumber = regNumber;
        this.username = username;
        this.fullName = fullName;
        this.address = address;
        this.telephone = telephone;
        this.nic = nic;
        this.email = email;
        this.password = password;
    }

    // Getters & Setters
    public int getId() { return id; }
    public String getRegNumber() { return regNumber; }
    public String getUsername() { return username; }
    public String getFullName() { return fullName; }
    public String getAddress() { return address; }
    public String getTelephone() { return telephone; }
    public String getNic() { return nic; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }

    public void setPassword(String password) { this.password = password; }
}