
![Static Badge](https://img.shields.io/badge/CIS%206003-brightgreen?style=flat&label=Module%20Code)


# MEGA CAB - CAR RENTAL SERVICE

Car Rental Web System that clients can book there vehicles from the system and admin can manage the bookings and the system.


## 01. Features

### 1.1 Admin Features

- Manage Users
- Manage Bookings
- Manage Vehicles
- Session Timeout
- Block Unathorized Access

### 1.2 Client Features

- Client Regsitration
- Client Login
- User Account
- View Bookings
- Print Invoice
- Download booking details
- Prevent Unathorized Access



## 02. Installation

To run this locally you need below requirments
### 2.1 Softwares
- Download [Apache Tomcat](https://tomcat.apache.org/download-11.cgi) and install it on your computer
- Download [Xampp](https://www.apachefriends.org/download.html) for database connection and install it to your computer
- Download [Intelijj Idea Ultimate](https://www.jetbrains.com/idea/download/download-thanks.html?platform=windows) as the IDE for run this program.

### 2.2 Run the project
- Download this project and open in IDE as mern project.
- Then click the "Current File" on the top of the navbar in the IDE and select Edit Configurations
- Press the "+" icon and select the Tomcat Local on the options
- Add suitable name on the name filed and change the port to 8082 or any other number.
- After that don't click ok or apply buttons, then go to the "Deployment" tab and there press "+" mark and select "Artifact" then select "Exploade" option
- Then press Apply and ok.
- Open the Xampp and run the database and create a database table named "megacitycab" and insert the database tables that locate on resources folder on project directory.
- After that go to the IDE and Run the project by clicking the TomCat selection.

### 2.3 Dependencies
If any case you get a error on Dependencies on this project then please copy below Dependencies to your project `porm.xml` file and reload the maven

```bash
  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>3.8.1</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>jakarta.servlet</groupId>
      <artifactId>jakarta.servlet-api</artifactId>
      <version>6.1.0-M1</version>
    </dependency>

    <dependency>
      <groupId>mysql</groupId>
      <artifactId>mysql-connector-java</artifactId>
      <version>8.0.33</version>
    </dependency>

    <dependency>
      <groupId>org.json</groupId>
      <artifactId>json</artifactId>
      <version>20231013</version>
    </dependency>
    <dependency>
      <groupId>org.apache.groovy</groupId>
      <artifactId>groovy-json</artifactId>
      <version>4.0.23</version>
    </dependency>
    <dependency>
      <groupId>com.google.code.gson</groupId>
      <artifactId>gson</artifactId>
      <version>2.10</version>
    </dependency>
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter-api</artifactId>
      <version>5.10.0</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
```
