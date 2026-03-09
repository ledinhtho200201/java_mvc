package vn.pildo.laptopshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.pildo.laptopshop.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    @SuppressWarnings("unchecked")
    User save(User pildo);
    List<User> findByEmailAndAddress(String email, String address);
    List<User> findByEmail(String email);
    User findOneByEmail(String email);
    boolean existsByEmail(String email);
    List<User> findAll();
}

