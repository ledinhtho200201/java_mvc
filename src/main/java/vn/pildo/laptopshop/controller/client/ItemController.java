package vn.pildo.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import vn.pildo.laptopshop.domain.Product;
import vn.pildo.laptopshop.domain.Review;
import vn.pildo.laptopshop.service.ProductService;
import vn.pildo.laptopshop.service.ReviewService;

import java.util.List;

@Controller
public class ItemController {
  private final ProductService productService;
  private final ReviewService reviewService;

  public ItemController(ProductService productService, ReviewService reviewService) {
    this.productService = productService;
    this.reviewService = reviewService;
  }

  @GetMapping("/product/{id}")
  public String getProductDetail(Model model, @PathVariable Long id) {
      Product product = this.productService.getProductById(id);
      
      // Get reviews for this product
      List<Review> reviews = this.reviewService.getReviewsByProduct(product);
      
      // Calculate average rating
      double averageRating = 0;
      if (reviews != null && !reviews.isEmpty()) {
          int sum = reviews.stream().mapToInt(Review::getRating).sum();
          averageRating = (double) sum / reviews.size();
      }

      model.addAttribute("product", product);
      model.addAttribute("reviews", reviews);
      model.addAttribute("averageRating", averageRating);
      
      return "client/product-detail";
  }
}
