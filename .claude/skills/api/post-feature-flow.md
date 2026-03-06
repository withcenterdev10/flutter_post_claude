# Post Feature Flow

```mermaid
flowchart TD
    Request([Incoming Request]) --> Method{HTTP Method}

    %% ─── CREATE POST ───────────────────────────────────────────
    Method -->|POST| AuthCreate{Authenticated?}
    AuthCreate -->|No| Deny1[401 Unauthorized]
    AuthCreate -->|Yes| CreatePost[Create Post\nattached to user]
    CreatePost --> Res201[201 Created]

    %% ─── UPDATE POST ────────────────────────────────────────────
    Method -->|PUT| AuthUpdate{Authenticated?}
    AuthUpdate -->|No| Deny2[401 Unauthorized]
    AuthUpdate -->|Yes| FindPostUpdate{Post exists?}
    FindPostUpdate -->|No| NotFound3[404 Not Found]
    FindPostUpdate -->|Yes| OwnerUpdate{Is owner\nof post?}
    OwnerUpdate -->|No| Deny3[403 Forbidden]
    OwnerUpdate -->|Yes| UpdatePost[Update Post]
    UpdatePost --> Res200u[200 OK]

    %% ─── DELETE POST ────────────────────────────────────────────
    Method -->|DELETE| AuthDelete{Authenticated?}
    AuthDelete -->|No| Deny4[401 Unauthorized]
    AuthDelete -->|Yes| FindPostDelete{Post exists?}
    FindPostDelete -->|No| NotFound5[404 Not Found]
    FindPostDelete -->|Yes| OwnerDelete{Is owner\nof post?}
    OwnerDelete -->|No| Deny5[403 Forbidden]
    OwnerDelete -->|Yes| DeletePost[Delete Post]
    DeletePost --> Res200d[200 OK]

    %% ─── VIEW MULTIPLE POSTS (paginated) ────────────────────────
    Method -->|GET /posts| AuthList{Authenticated?}
    AuthList -->|No| PublicList[Return all\npublished posts\nwith pagination]
    AuthList -->|Yes| OwnAll{Filter own\nposts only?}
    OwnAll -->|Yes| ListOwn[Return ALL posts\nby this user\nwith pagination]
    OwnAll -->|No| ListAll[Return all\npublished posts\nwith pagination]
    PublicList --> Res200l[200 OK + page meta]
    ListOwn --> Res200l
    ListAll --> Res200l

    %% ─── VIEW SINGLE POST ───────────────────────────────────────
    Method -->|GET /posts/:id| FindSingle{Post exists?}
    FindSingle -->|No| NotFound6[404 Not Found]
    FindSingle -->|Yes| ReturnSingle[Return post\nto anyone]
    ReturnSingle --> Res200s[200 OK]

    %% ─── Styling ────────────────────────────────────────────────
    classDef deny fill:#e74c3c,color:#fff,stroke:#c0392b
    classDef success fill:#2ecc71,color:#fff,stroke:#27ae60
    classDef notfound fill:#e67e22,color:#fff,stroke:#d35400

    class Deny1,Deny2,Deny3,Deny4,Deny5 deny
    class Res201,Res200u,Res200d,Res200l,Res200s success
    class NotFound3,NotFound5,NotFound6 notfound
```

## Summary

| Operation | Who can do it |
|---|---|
| Create Post | Authenticated users only |
| Update Post | Authenticated owner of the post only |
| Delete Post | Authenticated owner of the post only |
| View multiple posts (paginated) | Anyone; authenticated users can filter to see ALL their own posts |
| View single post | Anyone |

---

## Database Schema

### Entity Relationship

```mermaid
erDiagram
    users {
        TEXT id PK "bin2hex(random_bytes(8))"
        TEXT email
        TEXT password
        TEXT name
        TEXT gender
    }

    posts {
        TEXT id PK "bin2hex(random_bytes(8))"
        TEXT user_id FK "references users(id)"
        TEXT title
        TEXT body
        TEXT created_at
        TEXT updated_at
    }

    users ||--o{ posts : "authors"
```

### SQL

```sql
-- Existing table (reference)
CREATE TABLE IF NOT EXISTS users (
  id       TEXT PRIMARY KEY,
  email    TEXT,
  password TEXT,
  name     TEXT,
  gender   TEXT
);

-- New table
CREATE TABLE IF NOT EXISTS posts (
  id         TEXT PRIMARY KEY,
  user_id    TEXT NOT NULL,
  title      TEXT NOT NULL,
  body       TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT NOT NULL DEFAULT (datetime('now')),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```

### Field Notes

| Field | Type | Notes |
|---|---|---|
| `id` | TEXT | Random hex — `bin2hex(random_bytes(8))`, same pattern as `users.id` |
| `user_id` | TEXT | FK to `users.id`; cascades delete so posts are removed when the user is deleted |
| `title` | TEXT | Required short title of the post |
| `body` | TEXT | Required full content of the post |
| `created_at` | TEXT | ISO-8601 UTC timestamp; set once on insert |
| `updated_at` | TEXT | ISO-8601 UTC timestamp; updated on every edit |