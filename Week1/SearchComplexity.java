public class SearchComplexity {
    static class Product implements Comparable<Product> {
        private int productId;
        private String productName;
        private String category;
        public Product(int productId, String productName, String category) {
            this.productId = productId;
            this.productName = productName;
            this.category = category;
        }
        public String getProductName() {
            return productName;
        }
        @Override
        public int compareTo(Product other) {
            return this.productName.compareTo(other.productName);
        }
        @Override
        public String toString() {
            return "Product{id=" + productId + ", name=" + productName + ", category=" + category + "}";
        }
    }
    // For Linear Search
    // Time Complexity is:
    // - In Best Case: O(1) (target is at first position)
    // - In Average Case: O(n) (checks half the array on average)
    // - In Worst Case: O(n) (target is at end or not found)
    static Product linearSearch(Product[] products, String productName) {
        for (Product product : products) {
            if (product.getProductName().equals(productName)) {
                return product;
            }
        }
        return null;
    }
    // For Binary Search
    // Time Complexity is:
    //In Best Case: O(1) (target is at middle)
    //In Average Case: O(log n) (halves search space each step)
    //In Worst Case: O(log n) (repeatedly divides until found or not present)
    //Precondition: Array must be sorted by productName
    static Product binarySearch(Product[] sortedProducts, String productName) {
        int left = 0;
        int right = sortedProducts.length - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            int comparison = sortedProducts[mid].getProductName().compareTo(productName);

            if (comparison == 0) {
                return sortedProducts[mid];
            } else if (comparison < 0) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null;
    }
    // Analysis and Testing
    // Time Complexity Comparison:
    // - Linear Search: O(n) worst/average case, suitable for small or unsorted datasets.
    // - Binary Search: O(log n) worst/average case, much faster for large datasets but requires sorting.
    // Suitability for E-commerce:
    //Binary Search is better for large product catalogs (e.g., millions of products) if data can be kept sorted.
    //Linear Search is simpler for small catalogs or when frequent updates make sorting impractical.
    //Trade-off: Binary search requires O(n log n) to sort initially or maintain sorted order, but search is faster.
    // For a typical e-commerce platform with a large, relatively static catalog, binary search is preferred.
    public static void main(String[] args) {
        Product[] products = {
            new Product(1, "Laptop", "Electronics"),
            new Product(2, "Smartphone", "Electronics"),
            new Product(3, "Headphones", "Accessories"),
            new Product(4, "Tablet", "Electronics")
        };
        // thi is sorted array
        Product[] sortedProducts = products.clone();
        java.util.Arrays.sort(sortedProducts);
        // her we are Testing Linear Search
        System.out.println("Linear Search Results:");
        Product result1 = linearSearch(products, "Laptop");
        System.out.println("Search for 'Laptop': " + (result1 != null ? result1 : "Not found"));
        Product result2 = linearSearch(products, "Camera");
        System.out.println("Search for 'Camera': " + (result2 != null ? result2 : "Not found"));
        // here we are testing bianry search
        System.out.println("\nBinary Search Results:");
        Product result3 = binarySearch(sortedProducts, "Laptop");
        System.out.println("Search for 'Laptop': " + (result3 != null ? result3 : "Not found"));
        Product result4 = binarySearch(sortedProducts, "Camera");
        System.out.println("Search for 'Camera': " + (result4 != null ? result4 : "Not found"));
    }
}