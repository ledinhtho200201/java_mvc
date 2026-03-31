package vn.pildo.laptopshop.controller.client;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import vn.pildo.laptopshop.domain.Product;
import vn.pildo.laptopshop.domain.Review;
import vn.pildo.laptopshop.service.ProductService;
import vn.pildo.laptopshop.service.ReviewService;

@Controller
public class ItemController {
  private final ProductService productService;
  private final ReviewService reviewService;

  public ItemController(ProductService productService, ReviewService reviewService) {
    this.productService = productService;
    this.reviewService = reviewService;
  }

  @GetMapping("/product/{id}")
  public String getProductDetail(
          Model model, 
          @PathVariable Long id,
          @RequestParam(defaultValue = "1") int page) {
          
      Product product = this.productService.getProductById(id);
      
      // Pagination config: 5 reviews per page
      Pageable pageable = PageRequest.of(page - 1, 5);
      Page<Review> reviewPage = this.reviewService.getReviewsByProduct(product, pageable);
      
      // Calculate average rating
      double averageRating = this.reviewService.getAverageRating(product);
      long totalReviews = this.reviewService.countReviews(product);

      model.addAttribute("product", product);
      model.addAttribute("reviews", reviewPage.getContent());
      model.addAttribute("currentPage", page);
      model.addAttribute("totalPages", reviewPage.getTotalPages());
      model.addAttribute("averageRating", averageRating);
      model.addAttribute("totalReviews", totalReviews);
      
      return "client/product-detail";
  }
}
