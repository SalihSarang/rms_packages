/// Represents the different roles a user can have in the system.
enum UserRole { waiter, billing, chef, cashier, kitchen }

/// Represents the lifecycle state of a staff shift.
enum ShiftStatus { notStarted, active, paused, ended, missed }

/// Represents the different statuses an order can have.
enum OrderStatus { pending, preparing, ready, served, completed }

/// Represents the different statuses a payment can have.
enum PaymentStatus { pending, paid }

/// Represents the different methods of payment.
enum PaymentMethod { cash, card, upi }

/// Represents the different shapes a table can have.
enum TableShape { rectangle, circle }

/// Represents the different statuses a table can have.
enum TableStatus { available, occupied, reserved, served, cleaning }
