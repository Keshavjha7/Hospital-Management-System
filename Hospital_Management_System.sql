
-- Step 1: Create the Database
CREATE DATABASE HospitalManagementSystem;
USE HospitalManagementSystem;

-- Step 2: Create Tables

-- Doctors Table
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Specialization VARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(50)
);

-- Patients Table
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Gender ENUM('Male', 'Female', 'Other'),
    DateOfBirth DATE NOT NULL,
    PhoneNumber VARCHAR(15),
    Address TEXT
);

-- Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    Symptoms TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    HeadDoctorID INT,
    FOREIGN KEY (HeadDoctorID) REFERENCES Doctors(DoctorID)
);

-- Medicines Table
CREATE TABLE Medicines (
    MedicineID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Manufacturer VARCHAR(100),
    ExpiryDate DATE,
    Quantity INT NOT NULL
);

-- Step 3: Insert Sample Data

-- Insert Departments
INSERT INTO Departments (Name) VALUES
('Cardiology'),
('Neurology'),
('Orthopedics'),
('Pediatrics');

-- Insert Doctors
INSERT INTO Doctors (Name, Specialization, DepartmentID, PhoneNumber, Email) VALUES
('Dr. John Doe', 'Cardiologist', 1, '1234567890', 'johndoe@hospital.com'),
('Dr. Jane Smith', 'Neurologist', 2, '9876543210', 'janesmith@hospital.com'),
('Dr. Robert Brown', 'Orthopedic', 3, '4567891230', 'robertbrown@hospital.com');

-- Insert Patients
INSERT INTO Patients (Name, Gender, DateOfBirth, PhoneNumber, Address) VALUES
('Alice Johnson', 'Female', '1995-05-12', '9876543211', '123 Main St'),
('Bob Williams', 'Male', '1987-11-23', '8765432199', '456 Elm St');

-- Insert Appointments
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, AppointmentTime, Symptoms) VALUES
(1, 1, '2024-11-25', '10:00:00', 'Chest Pain'),
(2, 3, '2024-11-26', '11:30:00', 'Back Pain');

-- Insert Medicines
INSERT INTO Medicines (Name, Manufacturer, ExpiryDate, Quantity) VALUES
('Aspirin', 'PharmaCorp', '2025-06-30', 100),
('Paracetamol', 'MediLife', '2024-12-31', 200);

-- Step 4: Sample Queries

-- 1. Get all doctors and their specializations
SELECT DoctorID, Name, Specialization FROM Doctors;

-- 2. List all patients with upcoming appointments
SELECT p.Name AS PatientName, d.Name AS DoctorName, a.AppointmentDate, a.AppointmentTime
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID
WHERE a.AppointmentDate >= CURDATE();

-- 3. Find the total number of appointments per doctor
SELECT d.Name AS DoctorName, COUNT(a.AppointmentID) AS TotalAppointments
FROM Doctors d
LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID;

-- 4. Check stock of medicines
SELECT Name AS MedicineName, Quantity
FROM Medicines
WHERE Quantity < 50;

-- 5. Get patient details who visited a specific doctor
SELECT p.Name, p.PhoneNumber, p.Address
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
WHERE a.DoctorID = 1;
