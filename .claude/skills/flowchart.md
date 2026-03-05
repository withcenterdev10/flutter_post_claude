# REST API Flowchart

## Registration — POST /users

```
Client sends POST /users
        |
        v
Validate required fields (email, password)
        |
       / \
missing?   no
  |         |
  v         v
400 Bad   SELECT * FROM users WHERE email = ?
Request     |
{ "status": "failed",
  "message": "These fields are required. (email, password)" }
           / \
         found  not found
          |         |
          v         v
        400 Bad   Hash password
        Request     |
        { "status": "failed",
          "message": "Email already exists" }
                    v
               Generate unique ID (bin2hex random_bytes)
                    |
                    v
               INSERT user into DB
               (name and gender stored if provided, else "")
                    |
                    v
               200 OK
               { "status": "success",
                 "message": "User created successfully YEY :D",
                 "id": "..." }
```

---

## Login — POST /login

```
Client sends POST /login
        |
        v
Validate required fields (email, password)
        |
       / \
missing?   no
  |         |
  v         v
400 Bad   Look up user by email in DB
Request     |
{ "error": "email and password are required" }
           / \
        not    found
       found     |
          |      v
          v   Verify password (password_verify)
        401      |
     Unauthorized / \
     { "error": "invalid credentials" }
              match?  no
                |      |
                v      v
             200 OK   401 Unauthorized
             {         { "error": "invalid credentials" }
               "id",
               "email",
               "name",
               "gender"
             }
```

---

## Get All Users — GET /users

```
Client sends GET /users
        |
        v
Query DB: SELECT * FROM users
        |
        v
200 OK
[
  { "id", "email", "name", "gender" },
  ...
]
```

---

## Get Single User — GET /users/{id}

```
Client sends GET /users/{id}
        |
        v
Extract {id} from URL
        |
       / \
missing?   provided
   |           |
   v           v
400 Bad     Query DB: SELECT * FROM users WHERE id = ?
Request         |
{ "error":     / \
  "id is    found   not found
  required" }  |         |
               v         v
            200 OK     404 Not Found
            {           { "error": "user not found" }
              "id",
              "email",
              "name",
              "gender"
            }
```

---

## Update User — PUT /users/{id}

```
Client sends PUT /users/{id}
        |
        v
Extract {id} from URL
        |
       / \
missing?   provided
   |           |
   v           v
400 Bad     Validate fields in request body
Request         |
{ "error":     / \
  "id is   invalid   valid
  required" }  |        |
               v        v
            400 Bad   Check user exists in DB
            Request     |
            { "error": / \
              "..." } not    found
                      found     |
                         |      v
                         v   Build UPDATE query with provided fields
                       404      |
                     Not Found  v
                     { "error": Execute UPDATE
                       "user      |
                       not        v
                       found" } 200 OK
                              {
                                "id",
                                "email",
                                "name",
                                "gender"
                              }
```

---

## Delete User — DELETE /users/{id}

```
Client sends DELETE /users/{id}
        |
        v
Extract {id} from URL
        |
       / \
missing?   provided
   |           |
   v           v
400 Bad     Check user exists in DB
Request         |
{ "error":     / \
  "id is    not    found
  required" }found    |
               |      v
               v   Execute DELETE FROM users WHERE id = ?
             404      |
           Not Found  v
           { "error": 200 OK
             "user    { "message": "user deleted successfully" }
             not
             found" }
```

---

## HTTP Method Routing (index.php)

```
Incoming Request
        |
        v
Database::createDB()  (ensure DB & table exist)
        |
        v
Read REQUEST_METHOD + URI path
        |
        +------ GET    /users       --> Get All Users
        |
        +------ GET    /users/{id}  --> Get Single User
        |
        +------ POST   /users       --> Registration (UserController)
        |
        +------ POST   /login       --> Login (UserController)
        |
        +------ PUT    /users/{id}  --> Update User
        |
        +------ DELETE /users/{id}  --> Delete User
        |
        +------ (no match)          --> 404 { "error": "route not found" }
```

---

## JSON Response Reference

| Scenario                  | Status | Body                                      |
|---------------------------|--------|-------------------------------------------|
| Success (created)         | 201    | `{ "id", "email", "name", "gender" }`     |
| Success (single/updated)  | 200    | `{ "id", "email", "name", "gender" }`     |
| Success (all users)       | 200    | `[ { "id", "email", "name", "gender" } ]` |
| Success (deleted)         | 200    | `{ "message": "user deleted successfully" }` |
| Missing required field    | 400    | `{ "error": "<field> is required" }`      |
| Invalid credentials       | 401    | `{ "error": "invalid credentials" }`      |
| Resource not found        | 404    | `{ "error": "user not found" }`           |
| Email already exists      | 409    | `{ "error": "email already exists" }`     |
