# README

# Sidekiq Job Assignment

## Description

This project is a Ruby on Rails application utilizing Sidekiq for job scheduling, PostgreSQL for database storage, Redis for caching, and Linux as the operating system.

## Assignment Overview

### Requirements

- **Duration**: Up to 7 days
- **Technologies**:
    - Ruby on Rails (minimum version 7)
    - Sidekiq
    - PostgreSQL
    - Redis
    - Linux

### Assignment Tasks

1. **Hourly Job**
    - Create a Sidekiq job that executes every hour:
        - Fetches 20 user records from the [Random User Generator API](https://randomuser.me/api/?results=20)
        - Stores the records in the PostgreSQL database using ActiveRecord
        - Checks for duplicate entries based on the user's `uuid`, updating existing records
        - Stores the total count of male and female records in Redis

2. **Daily Job**
    - Create a Sidekiq job to run at the end of each day:
        - Calculates the total count of male and female records captured within the day from Redis
        - Stores the totals in the `DailyRecord` table
        - Implements ActiveRecord::Dirty on the `DailyRecord` model to calculate and store average age for male and female records from the `User` table

3. **User Interface (Using Liquid)**
    - Develop a simple user interface that:
        - Displays a table of users (name, age, gender, created_at) with search and delete functionality
        - Updates the male_count/female_count attribute in the `DailyRecord` table upon user record deletion
        - Shows the total number of user records
        - Presents a report of `DailyRecord` instances with date, male_avg_count, female_avg_count, male_avg_age, and female_avg_age

## Setup Instructions

### Prerequisites

- Ensure Ruby on Rails 7+ is installed
- Set up PostgreSQL, Redis, and a Linux environment

### Installation

1. Clone the repository.
2. Install dependencies using `bundle install`.
3. Configure database settings in `config/database.yml`.
4. Run database migrations using `rails db:migrate`.
5. Start the Sidekiq process.
6. Launch the Rails server using `rails server`.

## Usage

- Access the application through the defined routes.
- Utilize the UI to view users, delete records, and access reports.

## Contributions

Contributions are welcome! Please follow the contribution guidelines in CONTRIBUTING.md.
