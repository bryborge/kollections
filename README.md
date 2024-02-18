# Kollections

Kollections is a Ruby on Rails application designed to provide users with a platform to create and manage their personal
collections. Whether it's a collection of books, stamps, art, or any other items, Kollections offers an intuitive and
user-friendly interface to catalog and showcase these items.

## Features

*   **User Authentication:** Secure login and registration functionality.
*   **Create Collections:** Users can create and name their own collections.
*   **Item Management:** Add, update, or remove items from collections.
*   **Search and Filter:** Easily search within collections or filter items by various criteria. *(coming soon!)*
*   **Responsive Design:** Fully responsive interface for a seamless experience across devices.

## Technology Stack

**Ruby on Rails:** The application is built with Ruby on Rails.
**MySQL:** Database management.
**Bootstrap:** For styling and responsive design.
**RSpec:** Used for writing and running tests.

## Getting Started

### Prerequisites

*   Ruby
*   Rails
*   MySQL

### Installation

Clone the repository and navigate to the app directory:

```sh
git clone https://github.com/bryborge/kollections.git && cd $_
```

Install the required gems:

```sh
bundle install
```

Setup the database:

```sh
bundle exec rails db:create db:migrate
```

### Running the Application

Run the Rails server:

```sh
bundle exec rails server
```

Access the application via http://localhost:3000/ in your browser.

## Testing

To run the test suite:

```sh
bundle exec rspec
```

## License

This project is licensed under the MIT License.
