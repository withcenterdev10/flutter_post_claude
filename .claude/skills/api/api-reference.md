# PhpPlayground REST API Reference

Base URL: `http://localhost:8000`

All requests and responses use `Content-Type: application/json`.

All responses follow a consistent shape:

- `status`: `"success"` or `"failed"`
- `message`: human-readable string (on failure or simple success)
- `user` / `users`: data payload (on success)
- `post` / `posts`: post data payload (on success)

---

## User Object

Fields returned for a user (password is **never** returned):

```json
{
  "id": "acd28705f796c7d9",
  "email": "user@example.com",
  "name": "John Doe",
  "gender": "male",
  "is_logged_in": true
}
```

> `is_logged_in` is a bool (`true`/`false`) in login/register responses,
> and an integer (`1`/`0`) in GET responses (SQLite limitation — treat both as boolean in Flutter).

---

## Endpoints

### 1. Register — `POST /`

Creates a new user. New users are not logged in by default.

**Request body:**

```json
{
  "email": "user@example.com", // required
  "password": "secret123", // required
  "name": "John Doe", // optional, defaults to ""
  "gender": "male" // optional, defaults to ""
}
```

**Success `200`:**

```json
{
  "status": "success",
  "message": "User created successfully",
  "user": {
    "id": "acd28705f796c7d9",
    "email": "user@example.com",
    "name": "John Doe",
    "gender": "male",
    "is_logged_in": false
  }
}
```

**Failure — missing fields:**

```json
{
  "status": "failed",
  "message": "These fields are required. (email, password)"
}
```

**Failure — email taken:**

```json
{
  "status": "failed",
  "message": "Email already exists"
}
```

---

### 2. Login — `POST /login`

Authenticates a user and sets `is_logged_in` to `true`.

**Request body:**

```json
{
  "email": "user@example.com", // required
  "password": "secret123" // required
}
```

**Success `200`:**

```json
{
  "status": "success",
  "user": {
    "id": "acd28705f796c7d9",
    "email": "user@example.com",
    "name": "John Doe",
    "gender": "male",
    "is_logged_in": true
  }
}
```

**Failure — wrong credentials:**

```json
{
  "status": "failed",
  "message": "Invalid credentials"
}
```

---

### 3. Logout — `POST /logout`

Sets `is_logged_in` to `false` for the given user.

**Request body:**

```json
{
  "id": "acd28705f796c7d9" // required
}
```

**Success `200`:**

```json
{
  "status": "success",
  "message": "Logged out successfully"
}
```

**Failure — missing id:**

```json
{
  "status": "failed",
  "message": "id is required"
}
```

**Failure — user not found:**

```json
{
  "status": "failed",
  "message": "User not found"
}
```

**Failure — already logged out:**

```json
{
  "status": "failed",
  "message": "User is not logged in"
}
```

---

### 4. Get All Users — `GET /`

Returns all users. Password is not included.

**Request:** no body required.

**Success `200`:**

```json
{
  "status": "success",
  "users": [
    {
      "id": "acd28705f796c7d9",
      "email": "user@example.com",
      "name": "John Doe",
      "gender": "male",
      "is_logged_in": 1
    }
  ]
}
```

---

### 5. Get Single User — `GET /?id={id}`

**Request:** query parameter `id`.

```
GET /?id=acd28705f796c7d9
```

**Success `200`:**

```json
{
  "status": "success",
  "user": {
    "id": "acd28705f796c7d9",
    "email": "user@example.com",
    "name": "John Doe",
    "gender": "male",
    "is_logged_in": 1
  }
}
```

**Failure — not found:**

```json
{
  "status": "failed",
  "message": "User not found"
}
```

---

### 6. Update Profile — `PUT /`

Updates `name`, `gender`, and/or `password`. All fields are optional — only provided fields are changed. `email` cannot be changed.

**Request body:**

```json
{
  "id": "acd28705f796c7d9", // required
  "name": "New Name", // optional
  "gender": "female", // optional
  "password": "newpassword456" // optional — will be hashed automatically
}
```

**Success `200`:**

```json
{
  "status": "success",
  "message": "User updated successfully",
  "user": {
    "id": "acd28705f796c7d9",
    "email": "user@example.com",
    "name": "New Name",
    "gender": "female",
    "is_logged_in": 1
  }
}
```

**Failure — missing id:**

```json
{
  "status": "failed",
  "message": "id is required"
}
```

**Failure — not found:**

```json
{
  "status": "failed",
  "message": "User not found"
}
```

---

### 7. Delete User — `DELETE /`

**Request body:**

```json
{
  "id": "acd28705f796c7d9" // required
}
```

**Success `200`:**

```json
{
  "status": "success",
  "message": "User deleted successfully"
}
```

**Failure — not found:**

```json
{
  "status": "failed",
  "message": "User not found"
}
```

---

---

## Post Object

Fields returned for a post:

```json
{
  "id": "b3f1a2c4d5e6f7a8",
  "user_id": "acd28705f796c7d9",
  "title": "My First Post",
  "body": "Hello, world!",
  "created_at": "2026-03-06 10:00:00",
  "updated_at": "2026-03-06 10:00:00"
}
```

---

### 8. Create Post — `POST /posts`

Requires the author to be logged in. Pass `user_id` in the body — the API checks `is_logged_in` in the DB.

**Request body:**

```json
{
  "user_id": "acd28705f796c7d9", // required — must be logged in
  "title": "My First Post", // required
  "body": "Hello, world!" // required
}
```

**Success `200`:**

```json
{
  "status": "success",
  "message": "Post created successfully",
  "post": {
    "id": "b3f1a2c4d5e6f7a8",
    "user_id": "acd28705f796c7d9",
    "title": "My First Post",
    "body": "Hello, world!",
    "created_at": "2026-03-06 10:00:00",
    "updated_at": "2026-03-06 10:00:00"
  }
}
```

**Failure — missing fields:**

```json
{
  "status": "failed",
  "message": "These fields are required. (user_id, title, body)"
}
```

**Failure — not logged in:**

```json
{
  "status": "failed",
  "message": "Unauthorized"
}
```

---

### 9. Get All Posts — `GET /posts`

Public. Returns all posts with pagination. Authenticated users can additionally filter to see only their own posts by passing `user_id`.

**Query parameters:**

| Param     | Required | Default | Description                                                           |
| --------- | -------- | ------- | --------------------------------------------------------------------- |
| `page`    | No       | `1`     | Page number                                                           |
| `limit`   | No       | `10`    | Items per page                                                        |
| `user_id` | No       | —       | If provided and the user is logged in, returns only that user's posts |

```
GET /posts?page=1&limit=5
GET /posts?user_id=acd28705f796c7d9&page=1&limit=10
```

**Success `200`:**

```json
{
  "status": "success",
  "posts": [
    {
      "id": "b3f1a2c4d5e6f7a8",
      "user_id": "acd28705f796c7d9",
      "title": "My First Post",
      "body": "Hello, world!",
      "created_at": "2026-03-06 10:00:00",
      "updated_at": "2026-03-06 10:00:00"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 42
  }
}
```

---

### 10. Get Single Post — `GET /posts/{id}`

Public. No auth required.

```
GET /posts/b3f1a2c4d5e6f7a8
```

**Success `200`:**

```json
{
  "status": "success",
  "post": {
    "id": "b3f1a2c4d5e6f7a8",
    "user_id": "acd28705f796c7d9",
    "title": "My First Post",
    "body": "Hello, world!",
    "created_at": "2026-03-06 10:00:00",
    "updated_at": "2026-03-06 10:00:00"
  }
}
```

**Failure — not found:**

```json
{
  "status": "failed",
  "message": "Post not found"
}
```

---

### 11. Update Post — `PUT /posts/{id}`

Only the post's author (logged in) can update it. At least one of `title` or `body` must be provided.

```
PUT /posts/b3f1a2c4d5e6f7a8
```

**Request body:**

```json
{
  "user_id": "acd28705f796c7d9", // required — must be logged in
  "title": "Updated Title", // optional — at least one of title/body required
  "body": "Updated content." // optional — at least one of title/body required
}
```

**Success `200`:**

```json
{
  "status": "success",
  "message": "Post updated successfully",
  "post": {
    "id": "b3f1a2c4d5e6f7a8",
    "user_id": "acd28705f796c7d9",
    "title": "Updated Title",
    "body": "Updated content.",
    "created_at": "2026-03-06 10:00:00",
    "updated_at": "2026-03-06 11:30:00"
  }
}
```

**Failure — not logged in:**

```json
{
  "status": "failed",
  "message": "Unauthorized"
}
```

**Failure — editing another user's post:**

```json
{
  "status": "failed",
  "message": "Forbidden"
}
```

**Failure — not found:**

```json
{
  "status": "failed",
  "message": "Post not found"
}
```

---

### 12. Delete Post — `DELETE /posts/{id}`

Only the post's author (logged in) can delete it.

```
DELETE /posts/b3f1a2c4d5e6f7a8
```

**Request body:**

```json
{
  "user_id": "acd28705f796c7d9" // required — must be logged in
}
```

**Success `200`:**

```json
{
  "status": "success",
  "message": "Post deleted successfully"
}
```

**Failure — not logged in:**

```json
{
  "status": "failed",
  "message": "Unauthorized"
}
```

**Failure — deleting another user's post:**

```json
{
  "status": "failed",
  "message": "Forbidden"
}
```

**Failure — not found:**

```json
{
  "status": "failed",
  "message": "Post not found"
}
```

---

## Quick Reference Table

### User Endpoints

| Method   | Path      | Auth Required | Purpose         |
| -------- | --------- | ------------- | --------------- |
| `POST`   | `/`       | No            | Register        |
| `POST`   | `/login`  | No            | Login           |
| `POST`   | `/logout` | No            | Logout          |
| `GET`    | `/`       | No            | Get all users   |
| `GET`    | `/?id=`   | No            | Get single user |
| `PUT`    | `/`       | No            | Update profile  |
| `DELETE` | `/`       | No            | Delete user     |

### Post Endpoints

| Method   | Path          | Auth Required | Purpose                   |
| -------- | ------------- | ------------- | ------------------------- |
| `POST`   | `/posts`      | Yes           | Create post               |
| `GET`    | `/posts`      | No            | Get all posts (paginated) |
| `GET`    | `/posts/{id}` | No            | Get single post           |
| `PUT`    | `/posts/{id}` | Yes (owner)   | Update post               |
| `DELETE` | `/posts/{id}` | Yes (owner)   | Delete post               |

---

## Flutter Usage Notes

- Store the user `id` locally (e.g. `SharedPreferences`) after login to use in subsequent requests.
- The `is_logged_in` field from GET endpoints returns as an integer (`0`/`1`). Cast with `isLoggedIn == 1` or `isLoggedIn == true` depending on the response origin.
- All endpoints accept and return UTF-8 JSON. Set `Content-Type: application/json` on every request that has a body.
- On login success, persist the full user object locally. On logout, clear local storage.
- For post write operations (create, update, delete), always include the stored `user_id` in the request body — there are no session cookies or tokens.
