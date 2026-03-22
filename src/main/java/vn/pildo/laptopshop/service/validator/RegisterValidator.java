package vn.pildo.laptopshop.service.validator;

import org.springframework.beans.factory.annotation.Autowired;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import vn.pildo.laptopshop.domain.dto.RegisterDTO;
import vn.pildo.laptopshop.service.UserService;

public class RegisterValidator implements ConstraintValidator<RegisterChecked, RegisterDTO> {

    @Autowired
    private UserService userService;

    @Override
    public void initialize(RegisterChecked annotation) {
    }

    @Override
    public boolean isValid(RegisterDTO registerDTO, ConstraintValidatorContext context) {
        if (registerDTO == null) {
            return true;
        }

        boolean isValid = true;

        // Check password == confirmPassword
        String password = registerDTO.getPassword();
        String confirmPassword = registerDTO.getConfirmPassword();

        if (password != null && confirmPassword != null && !password.equals(confirmPassword)) {
            context.buildConstraintViolationWithTemplate("Mật khẩu xác nhận không khớp")
                    .addPropertyNode("confirmPassword")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            isValid = false;
        }

        // Check email đã tồn tại chưa
        String email = registerDTO.getEmail();
        if (email != null && !email.isBlank() && userService.isEmailExist(email)) {
            context.buildConstraintViolationWithTemplate("Email đã được sử dụng")
                    .addPropertyNode("email")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            isValid = false;
        }

        return isValid;
    }
}
