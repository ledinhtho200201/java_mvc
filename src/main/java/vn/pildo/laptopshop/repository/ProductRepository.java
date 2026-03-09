package vn.pildo.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.pildo.laptopshop.domain.Product;

public interface ProductRepository extends JpaRepository<Product, Long> {

}
