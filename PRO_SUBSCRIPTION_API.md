# Pro Subscription API Documentation

This document describes the API endpoints for checking and managing pro subscription status for user accounts.

## Features

- Check if a user account has a pro subscription
- Update a user's pro subscription status
- Proper error handling for non-existent users

## Database Schema

The `User` entity now includes an `isPro` boolean field:
- `isPro` (boolean): Indicates whether the user has an active pro subscription (default: false)

## API Endpoints

### 1. Check Pro Subscription Status

**Endpoint:** `GET /api/user/{id}/pro-status`

**Description:** Check if a user account has purchased a pro subscription.

**Parameters:**
- `id` (path parameter): The user ID

**Response (Success - 200 OK):**
```json
{
  "isPro": true,
  "message": "User has pro subscription"
}
```

**Response (User Not Found - 404 Not Found):**
```json
{
  "isPro": false,
  "message": "User not found"
}
```

**Example Usage:**
```bash
curl -X GET http://localhost:8080/api/user/1/pro-status
```

### 2. Update Pro Subscription Status

**Endpoint:** `POST /api/user/{id}/pro-status`

**Description:** Update the pro subscription status for a user account.

**Parameters:**
- `id` (path parameter): The user ID
- `isPro` (form parameter): Boolean value to set the pro status (true/false)

**Response (Success - 200 OK):**
```
Pro subscription activated
```
or
```
Pro subscription deactivated
```

**Response (User Not Found - 404 Not Found):**
```
User not found
```

**Response (Error - 500 Internal Server Error):**
```
Error updating pro status: [error message]
```

**Example Usage:**

Activate pro subscription:
```bash
curl -X POST "http://localhost:8080/api/user/1/pro-status" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "isPro=true"
```

Deactivate pro subscription:
```bash
curl -X POST "http://localhost:8080/api/user/1/pro-status" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "isPro=false"
```

## Implementation Details

### Service Layer

The `UserService` class includes two new methods:

1. `checkUserProStatus(Long id)`: Returns the pro status of a user
2. `updateUserProStatus(Long id, boolean isPro)`: Updates the pro status of a user

### Controller Layer

The `UserController` class includes two new endpoints:

1. `checkProStatus(@PathVariable Long id)`: GET endpoint to check pro status
2. `updateProStatus(@PathVariable Long id, @RequestParam boolean isPro)`: POST endpoint to update pro status

## Testing

To test the implementation:

1. Start the application with MySQL database
2. Create a test user through the admin interface or API
3. Use the provided curl commands to check and update pro status
4. Verify changes in the database:
   ```bash
   SELECT id, email, is_pro FROM user;
   ```

## Vietnamese Translation (Bản dịch tiếng Việt)

### Hỏi: Tài khoản này tôi mua pro chưa vậy? Làm sao để check?

**Trả lời:** Bạn có thể kiểm tra trạng thái pro của tài khoản bằng cách:

1. Gọi API GET `/api/user/{id}/pro-status` với `{id}` là ID của tài khoản
2. API sẽ trả về:
   - `isPro: true` - Tài khoản đã mua pro
   - `isPro: false` - Tài khoản chưa mua pro

Ví dụ kiểm tra tài khoản có ID = 1:
```bash
curl -X GET http://localhost:8080/api/user/1/pro-status
```

Để cập nhật trạng thái pro:
```bash
# Kích hoạt pro
curl -X POST "http://localhost:8080/api/user/1/pro-status" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "isPro=true"

# Hủy pro
curl -X POST "http://localhost:8080/api/user/1/pro-status" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "isPro=false"
```
