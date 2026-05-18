package com.staffmanagement.model;

/**
 * Encapsulation: Staff inherits from BaseEntity.
 * It uses private fields with public getters/setters.
 */
public class Staff extends BaseEntity {
    private String name;
    private String role;
    private String shift;
    private String status;
    private String avatar;
    private String phone;
    private String email;
    private String joinDate;
    private String address;
    private String vehicleNumber;
    private String vehicleType;
    private String username;
    private String password;

    public Staff() {
        super();
    }

    public Staff(Long id, String name, String role, String shift, String status, String avatar, String phone, String email, String joinDate, String address, String vehicleNumber, String vehicleType, String username, String password) {
        super(id);
        this.name = name;
        this.role = role;
        this.shift = shift;
        this.status = status;
        this.avatar = avatar;
        this.phone = phone;
        this.email = email;
        this.joinDate = joinDate;
        this.address = address;
        this.vehicleNumber = vehicleNumber;
        this.vehicleType = vehicleType;
        this.username = username;
        this.password = password;
    }

    // Getters and Setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getShift() { return shift; }
    public void setShift(String shift) { this.shift = shift; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getJoinDate() { return joinDate; }
    public void setJoinDate(String joinDate) { this.joinDate = joinDate; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getVehicleNumber() { return vehicleNumber; }
    public void setVehicleNumber(String vehicleNumber) { this.vehicleNumber = vehicleNumber; }
    public String getVehicleType() { return vehicleType; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    /**
     * Data Transformation: Logic localized within the model for converting to/from CSV.
     */
    public String toCsvRow() {
        return String.join(",", 
            escapeCsv(String.valueOf(getId())),
            escapeCsv(name),
            escapeCsv(role),
            escapeCsv(shift),
            escapeCsv(status),
            escapeCsv(avatar),
            escapeCsv(phone),
            escapeCsv(email),
            escapeCsv(joinDate),
            escapeCsv(address),
            escapeCsv(vehicleNumber),
            escapeCsv(vehicleType),
            escapeCsv(username),
            escapeCsv(password)
        );
    }

    private String escapeCsv(String value) {
        if (value == null) return "";
        if (value.contains(",") || value.contains("\"") || value.contains("\n")) {
            return "\"" + value.replace("\"", "\"\"") + "\"";
        }
        return value;
    }

    public static Staff fromCsvRow(String row) {
        String[] fields = parseCsvRow(row);
        if (fields.length < 14) return null;
        
        Staff staff = new Staff();
        staff.setId(Long.parseLong(fields[0]));
        staff.setName(fields[1]);
        staff.setRole(fields[2]);
        staff.setShift(fields[3]);
        staff.setStatus(fields[4]);
        staff.setAvatar(fields[5]);
        staff.setPhone(fields[6]);
        staff.setEmail(fields[7]);
        staff.setJoinDate(fields[8]);
        staff.setAddress(fields[9]);
        staff.setVehicleNumber(fields[10]);
        staff.setVehicleType(fields[11]);
        staff.setUsername(fields[12]);
        staff.setPassword(fields[13]);
        return staff;
    }

    private static String[] parseCsvRow(String row) {
        java.util.List<String> list = new java.util.ArrayList<>();
        boolean inQuotes = false;
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < row.length(); i++) {
            char c = row.charAt(i);
            if (c == '"') {
                if (inQuotes && i + 1 < row.length() && row.charAt(i + 1) == '"') {
                    sb.append('"');
                    i++;
                } else {
                    inQuotes = !inQuotes;
                }
            } else if (c == ',' && !inQuotes) {
                list.add(sb.toString());
                sb.setLength(0);
            } else {
                sb.append(c);
            }
        }
        list.add(sb.toString());
        return list.toArray(new String[0]);
    }
}
