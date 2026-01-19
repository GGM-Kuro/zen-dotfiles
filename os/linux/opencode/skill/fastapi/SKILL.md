---
name: fastapi
description: >
  FastAPI patterns and best practices.
  Trigger: When building FastAPI applications - endpoints, models, dependencies.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## Project Structure (REQUIRED)

```
app/
├── __init__.py
├── main.py              # FastAPI app instance
├── api/
│   ├── __init__.py
│   ├── deps.py          # Dependencies
│   └── v1/
│       ├── __init__.py
│       └── endpoints/
│           └── users.py
├── core/
│   ├── __init__.py
│   └── config.py        # Settings
├── schemas/
│   ├── __init__.py
│   └── user.py
└── models/
    ├── __init__.py
    └── user.py
```

## Pydantic vs SQLAlchemy (REQUIRED)

```python
# schemas/user.py - Pydantic for API validation/response
from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime

class UserBase(BaseModel):
    email: EmailStr
    name: str
    is_active: bool = True

class UserCreate(UserBase):
    password: str

class User(UserBase):
    id: int
    created_at: datetime

    class Config:
        from_attributes = True

# models/user.py - SQLAlchemy for database
from sqlalchemy import Column, Integer, String, Boolean, DateTime
from sqlalchemy.sql import func

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    name = Column(String, nullable=False)
    hashed_password = Column(String, nullable=False)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
```

## Dependency Injection (REQUIRED)

```python
# api/deps.py
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from app.core.config import settings
from app.db.session import SessionLocal
from app import models

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="api/v1/auth/login")

def get_db() -> Generator[Session, None, None]:
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

def get_current_user(
    db: Session = Depends(get_db),
    token: str = Depends(oauth2_scheme)
) -> models.User:
    user = verify_token(token, db)  # Your auth logic
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid authentication credentials"
        )
    return user
```

## Endpoint Pattern (REQUIRED)

```python
# api/v1/endpoints/users.py
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from app.api import deps
from app import schemas
from app.models.user import User

router = APIRouter()

@router.get("/", response_model=List[schemas.User])
def read_users(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_user)
) -> List[User]:
    """Retrieve users."""
    users = db.query(User).offset(skip).limit(limit).all()
    return users

@router.post("/", response_model=schemas.User, status_code=status.HTTP_201_CREATED)
def create_user(
    *,
    db: Session = Depends(deps.get_db),
    user_in: schemas.UserCreate
) -> User:
    """Create new user."""
    # Check if user exists
    existing = db.query(User).filter(User.email == user_in.email).first()
    if existing:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="User with this email already exists"
        )
    
    # Create user (hash password first!)
    user = User(
        email=user_in.email,
        name=user_in.name,
        hashed_password=hash_password(user_in.password)  # Your hash function
    )
    db.add(user)
    db.commit()
    db.refresh(user)
    return user
```

## Settings Management (REQUIRED)

```python
# core/config.py
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    API_V1_STR: str = "/api/v1"
    SECRET_KEY: str
    DATABASE_URL: str
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 8  # 8 days
    
    class Config:
        env_file = ".env"

settings = Settings()
```

## Main Application (REQUIRED)

```python
# main.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core.config import settings
from app.api.v1.endpoints import users

app = FastAPI(
    title="My API",
    openapi_url=f"{settings.API_V1_STR}/openapi.json"
)

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(users.router, prefix=f"{settings.API_V1_STR}/users")

@app.get("/")
async def root():
    return {"message": "API is running"}
```

## Keywords
fastapi, python, api, rest, pydantic, sqlalchemy, dependencies
