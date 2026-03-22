package vn.pildo.laptopshop.domain.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import vn.pildo.laptopshop.service.validator.RegisterChecked;
import vn.pildo.laptopshop.service.validator.StrongPassword;

@RegisterChecked
public class RegisterDTO {

    @NotEmpty(message = "Họ không được để trống")
    private String firstName;

    @NotEmpty(message = "Tên không được để trống")
    private String lastName;

    @NotEmpty(message = "Email không được để trống")
    @Email(message = "Email không hợp lệ")
    private String email;

    @NotEmpty(message = "Mật khẩu không được để trống")
    @StrongPassword
    private String password;

    @NotEmpty(message = "Vui lòng xác nhận mật khẩu")
    private String confirmPassword;

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getConfirmPassword() { return confirmPassword; }
    public void setConfirmPassword(String confirmPassword) { this.confirmPassword = confirmPassword; }
}
