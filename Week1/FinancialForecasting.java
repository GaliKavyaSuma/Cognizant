import java.util.Scanner;

public class FinancialForecasting {
    // Understanding Recursive Algorithms
    // Recursion: A function calls itself to solve a smaller instance of the problem.
    //Base Case: Stops recursion (e.g., when years = 0).
    //Recursive Case: Calls itself with reduced input (e.g., years - 1).
    //Benefits:
    //Simplifies problems like compound interest by breaking into smaller steps.
    //Leads to concise code for problems with natural recursive structure.
    //Drawbacks:
    //High space complexity due to call stack (O(n) for n recursive calls).
    //Risk of stack overflow for large inputs.
    // In this scenario, recursion models compound interest by computing FV(n) = FV(n-1) * (1 + r).

    // Setting up Recursive method to calculate future value
    // Formula: FV = PV * (1 + r)^n
    // Recursive Definition:
    // Base Case: If years = 0, FV = PV
    // Recursive Case: FV(n) = FV(n-1) * (1 + r)
    static double calculateFutureValue(double presentValue, double growthRate, int years) {
        // Base case
        if (years == 0) {
            return presentValue;
        }
        // Recursive case
        return calculateFutureValue(presentValue, growthRate, years - 1) * (1 + growthRate);
    }
    // Implementing Main method with user input
    // Analysis
    // Time Complexity: O(n)
    // Makes n recursive calls, one per year.
    // Space Complexity: O(n)
    // Uses n stack frames due to recursive calls.
    // Optimization Techniques:
    // Memoization: Not applicable (no repeated subproblems).
    // Tail Recursion: Not optimized in Java; could rewrite as iterative.
    // Iterative Solution: Use a loop to compute FV = PV * (1 + r)^n, reducing space to O(1).
    // Direct Formula: Use Math.pow for FV = PV * (1 + r)^n, O(1) time but potential precision issues.
    // Recursive approach is used here as per exercise requirements, but iterative/direct formula is more efficient for production.
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Financial Forecasting Tool");
        System.out.println("Enter values to predict future investment value based on compound interest.");
        System.out.println("Growth rate should be a entered as a percentage (e.g., 5 = 5%).");
        while (true) {
            System.out.print("\nEnter initial investment amount (or 'exit' to quit): ");
            String input = scanner.nextLine().trim();
            if (input.equalsIgnoreCase("exit")) {
                System.out.println("Exiting forecasting tool...");
                break;
            }
            double presentValue;
            try {
                presentValue = Double.parseDouble(input);
                if (presentValue <= 0) {
                    System.out.println("Error: Investment amount must be positive.");
                    continue;
                }
            } catch (NumberFormatException e) {
                System.out.println("Error: Invalid number format. Please enter a valid amount.");
                continue;
            }
            // getting growth rate
            System.out.print("Enter annual growth rate (as decimal, e.g., 5 for 5%): ");
            input = scanner.nextLine().trim();
            double growthRate;
            try {
                growthRate = Double.parseDouble(input)/100;
                if (growthRate < -1) {
                    System.out.println("Error: Growth rate cannot be less than -100%.");
                    continue;
                }
            } catch (NumberFormatException e) {
                System.out.println("Error: Invalid number format. Please enter a valid growth rate.");
                continue;
            }
            // getting no.of years
            System.out.print("Enter number of years: ");
            input = scanner.nextLine().trim();
            int years;
            try {
                years = Integer.parseInt(input);
                if (years < 0) {
                    System.out.println("Error: Number of years cannot be negative.");
                    continue;
                }
            } catch (NumberFormatException e) {
                System.out.println("Error: Invalid number format. Please enter a valid number of years.");
                continue;
            }
            // clculating and display future value
            double futureValue = calculateFutureValue(presentValue, growthRate, years);
            System.out.printf("Future value after %d years: $%.2f%n", years, futureValue);
        }
        scanner.close();
    }
}