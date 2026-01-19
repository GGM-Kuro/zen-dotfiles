---
name: reflex
description: >
  Reflex web development patterns and best practices.
  Trigger: When building Reflex applications - components, state, routing.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## Project Structure (REQUIRED)

```
my_app/
├── __init__.py
├── my_app/
│   ├── components/
│   │   ├── base.py
│   │   └── layout.py
│   ├── pages/
│   │   └── home.py
│   ├── styles/
│   │   └── base.py
│   └── state.py
├── .web/
├── assets/
└── requirements.txt
```

## State Management (REQUIRED)

```python
# my_app/state.py
import reflex as rx
from typing import List, Optional, Dict, Any

class State(rx.State):
    """Global application state."""
    
    # Authentication
    user: Optional[Dict[str, Any]] = None
    is_authenticated: bool = False
    loading: bool = False
    
    # Data
    items: List[Dict[str, Any]] = []
    search_query: str = ""
    selected_item: Optional[Dict[str, Any]] = None
    
    # Form data
    form_data: Dict[str, Any] = {}
    
    def logout(self):
        """Logout user."""
        self.user = None
        self.is_authenticated = False
        return rx.redirect("/login")
    
    def set_search_query(self, query: str):
        """Set search query."""
        self.search_query = query
    
    def select_item(self, item: Dict[str, Any]):
        """Select an item."""
        self.selected_item = item
        return rx.redirect(f"/items/{item['id']}")

class AuthState(State):
    """Authentication specific state."""
    
    email: str = ""
    password: str = ""
    
    async def login(self):
        """Handle login."""
        if not self.email or not self.password:
            return rx.window_alert("Please enter email and password")
        
        self.loading = True
        yield
        
        try:
            await asyncio.sleep(1)  # Simulate API call
            
            if self.email == "user@example.com" and self.password == "password":
                self.user = {"email": self.email, "name": "Test User"}
                self.is_authenticated = True
                self.email = ""
                self.password = ""
                return rx.redirect("/dashboard")
            else:
                return rx.window_alert("Invalid credentials")
        finally:
            self.loading = False
```

## Component Pattern (REQUIRED)

```python
# my_app/components/base.py
import reflex as rx

def card(title: str, content: rx.Component, actions: Optional[rx.Component] = None):
    """Reusable card component."""
    return rx.card(
        rx.card_header(rx.heading(title, size="4")),
        rx.card_body(content),
        actions and rx.card_footer(actions),
        style={"margin": "16px 0"}
    )

def text_input(placeholder: str, name: str, **props):
    """Styled text input component."""
    return rx.input(
        placeholder=placeholder,
        name=name,
        style={"width": "100%"},
        **props
    )

def submit_button(text: str, loading: bool = False):
    """Submit button component."""
    return rx.button(
        rx.cond(loading, rx.spinner(size="3"), rx.text(text)),
        type="submit",
        disabled=loading,
        style={"background": "blue", "color": "white"}
    )
```

## Page Pattern (REQUIRED)

```python
# my_app/pages/home.py
import reflex as rx
from my_app.components.base import card
from my_app.components.layout import navbar
from my_app.state import State

@rx.page(route="/", title="Home")
def home() -> rx.Component:
    """Home page."""
    return rx.vstack(
        navbar(),
        rx.container(
            rx.vstack(
                rx.heading("Welcome", size="8", text_align="center"),
                card(
                    "Stats",
                    rx.vstack(
                        rx.text("Total Items: 42"),
                        rx.text("Users: 128"),
                        spacing="3"
                    )
                ),
                spacing="6"
            ),
            max_width="1200px"
        ),
        style={"min_height": "100vh"}
    )

@rx.page(route="/dashboard", title="Dashboard")
@rx.require_auth
def dashboard() -> rx.Component:
    """Dashboard page."""
    return rx.vstack(
        navbar(),
        rx.container(
            rx.vstack(
                rx.heading("Dashboard", size="7"),
                rx.cond(
                    State.loading,
                    rx.spinner(),
                    rx.grid(
                        *[card(item["name"], rx.text(item["description"])) 
                          for item in State.items],
                        columns="3"
                    )
                ),
                spacing="6"
            )
        )
    )
```

## Layout Pattern (REQUIRED)

```python
# my_app/components/layout.py
import reflex as rx
from my_app.state import State

def navbar() -> rx.Component:
    """Navigation bar component."""
    return rx.hstack(
        rx.link(
            rx.heading("My App", size="6"),
            href="/",
            style={"text-decoration": "none"}
        ),
        rx.spacer(),
        rx.hstack(
            rx.link(rx.text("Home"), href="/"),
            rx.link(rx.text("Dashboard"), href="/dashboard"),
            rx.cond(
                State.is_authenticated,
                rx.button("Logout", on_click=State.logout),
                rx.button("Login", on_click=rx.redirect("/login"))
            ),
            spacing="4"
        ),
        spacing="6",
        padding="16px 24px",
        style={"background": "gray", "color": "white"}
    )

def sidebar() -> rx.Component:
    """Sidebar component."""
    return rx.vstack(
        rx.button("Home", on_click=rx.redirect("/")),
        rx.button("Dashboard", on_click=rx.redirect("/dashboard")),
        rx.button("Profile", on_click=rx.redirect("/profile")),
        spacing="2",
        style={"min_height": "200px"}
    )
```

## Style Pattern (REQUIRED)

```python
# my_app/styles/base.py
import reflex as rx

# Color theme
colors = {
    "accent": rx.color("indigo", 9),
    "background": rx.color("gray", 1),
    "foreground": rx.color("mauve", 12),
    "border": rx.color("mauve", 6),
}

# Base styles
base_style = {
    "navbar": {
        "background": colors["accent"],
        "color": "white",
        "padding": "16px 24px",
    },
    "card": {
        "background": colors["background"],
        "border": f"1px solid {colors['border']}",
        "border_radius": "8px",
        "padding": "16px",
    },
    "button": {
        "background": colors["accent"],
        "color": "white",
        "padding": "8px 16px",
        "border_radius": "6px",
    }
}

def get_theme():
    """Get the application theme."""
    return {
        "accent_color": colors["accent"],
        "background_color": colors["background"],
        "color": colors["foreground"],
    }
```

## Service Pattern (REQUIRED)

```python
# my_app/services/api.py
import httpx
from typing import Dict, Any, Optional

class APIService:
    """Base API service class."""
    
    def __init__(self, base_url: str):
        self.base_url = base_url
    
    async def get(self, endpoint: str) -> Dict[str, Any]:
        """Make GET request."""
        async with httpx.AsyncClient() as client:
            response = await client.get(f"{self.base_url}/{endpoint}")
            response.raise_for_status()
            return response.json()
    
    async def post(self, endpoint: str, data: Dict[str, Any]) -> Dict[str, Any]:
        """Make POST request."""
        async with httpx.AsyncClient() as client:
            response = await client.post(f"{self.base_url}/{endpoint}", json=data)
            response.raise_for_status()
            return response.json()
```

## Main App (REQUIRED)

```python
# my_app/__init__.py
import reflex as rx
from my_app.pages import home, dashboard
from my_app.styles.base import get_theme

app = rx.App(theme=get_theme())

# Add pages
app.add_page(home.home)
app.add_page(dashboard.dashboard)

# Configure app
app.compile()
```

## Keywords
reflex, python, web, frontend, backend, state, components, styling, deployment