package vn.pildo.laptopshop.controller.admin;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import vn.pildo.laptopshop.domain.Product;
import vn.pildo.laptopshop.service.ProductService;

@Controller
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/admin/product")
    public String getProductPage(Model model) {
        List<Product> products = this.productService.getAllProducts();
        model.addAttribute("listProduct", products);
        model.addAttribute("productCount", products.size());
        model.addAttribute("newProduct", new Product());
        return "admin/product/product-table";
    }

    @PostMapping("/admin/product/create")
    public String createProduct(
            Model model,
            @Valid @ModelAttribute("newProduct") Product newProduct,
            BindingResult bindingResult,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile) {

        if (bindingResult.hasErrors()) {
            List<Product> products = this.productService.getAllProducts();
            model.addAttribute("listProduct", products);
            model.addAttribute("productCount", products.size());
            model.addAttribute("showModal", true);
            return "admin/product/product-table";
        }

        try {
            String uploadDir = "src/main/resources/static/images/product";
            String imageName = this.productService.handleUploadFile(imageFile, uploadDir);
            if (imageName != null) {
                newProduct.setImage(imageName);
            }
        } catch (Exception e) {
            // ignore upload error
        }

        this.productService.saveProduct(newProduct);
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/update/{id}")
    public String getUpdateProductPage(Model model, @PathVariable Long id) {
        Product product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String updateProduct(
            @ModelAttribute Product product,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile) {
        try {
            if (imageFile != null && !imageFile.isEmpty()) {
                String uploadDir = "src/main/resources/static/images/product";
                String imageName = this.productService.handleUploadFile(imageFile, uploadDir);
                if (imageName != null) {
                    product.setImage(imageName);
                }
            }
        } catch (Exception ignored) {}
        this.productService.updateProduct(product);
        return "redirect:/admin/product";
    }

    @DeleteMapping("/admin/product/delete/{id}")
    @ResponseBody
    public ResponseEntity<String> deleteProduct(@PathVariable Long id) {
        try {
            this.productService.deleteProduct(id);
            return ResponseEntity.ok("Deleted");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error: " + e.getMessage());
        }
    }
}
