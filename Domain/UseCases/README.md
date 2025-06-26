# UseCases

Application-specific business rules.

Guidelines:

1. Prefer static functions or protocol-based classes when you need polymorphism.
2. Inject repositories via initialiser so you can stub them in tests.
3. Remain asynchronous via `async/await` or Combine publishers; never call `URLSession` directly here.
