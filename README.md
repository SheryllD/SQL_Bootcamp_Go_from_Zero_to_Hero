# The Complete SQL Bootcamp – Learning Repository

This repository documents my journey through the Udemy course [The Complete SQL Bootcamp](https://www.udemy.com/course/the-complete-sql-bootcamp/) by Jose Portilla. It serves as both a personal learning journal and a structured resource for reviewing core SQL concepts, tools, and practical exercises.

## Course Description

The Complete SQL Bootcamp provides a thorough, hands-on introduction to SQL using PostgreSQL. It is designed for beginners and covers essential concepts for anyone pursuing work in data analysis, business intelligence, or data science.

Throughout the course, students build their skills through guided lessons and exercises, learning how to write real SQL queries and work directly with databases using both the command line and graphical interfaces.

--- 

## Topics Covered

- Installing PostgreSQL and setting up a local database environment
- Connecting to databases using pgAdmin and the psql terminal
- Writing basic and complex SQL queries
- Filtering, ordering, and limiting results
- Using aggregate functions and GROUP BY clauses
- Understanding and using different types of JOINs
- Creating, updating, and deleting records
- Designing and managing tables and schemas
- Handling NULL values and using CASE expressions
- Subqueries and nested queries
- Window functions and analytical queries
- Working with timestamps and dates
- Final project applying all learned concepts

--- 

## Tools Used

| Tool          | Purpose                                                 |
|---------------|----------------------------------------------------------|
| PostgreSQL     | Open-source relational database management system (RDBMS) |
| pgAdmin 4      | Graphical user interface for PostgreSQL database management |
| psql (CLI)     | Command-line interface for interacting with PostgreSQL |
| Visual Studio Code | Optional text editor for managing `.sql` files        |
| macOS Terminal | Shell environment for installing and managing PostgreSQL |

---  

## System Configuration

- Operating System: macOS Monterey (12.x)
- Processor: Intel Core i5, 2.3 GHz Dual-Core
- PostgreSQL Version: 15 (installed via Homebrew)
- pgAdmin Version: 8.14 (Intel build, compatible with macOS 12)
- Homebrew: Used to install and manage PostgreSQL services

## PostgreSQL Installation (Homebrew, macOS)

To install PostgreSQL and start the server:

```bash
brew install postgresql@15
brew services start postgresql@15
```
--- 

## Repository Structure

├── README.md                   # Course overview and documentation
├── SQL_Exercises               # Section-by-section practice queries
└── SQL_information             # Further Information
