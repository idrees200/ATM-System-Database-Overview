# ATM System Database Overview

This repository contains SQL scripts and data for an ATM system database. The database schema manages users, cards, transactions, card types, and transaction types.

## Database Schema

### Tables:

1. **User:**
   - userId (int, primary key)
   - name (varchar(20), not null)
   - phoneNum (varchar(15), not null)
   - city (varchar(20), not null)

2. **CardType:**
   - cardTypeID (int, primary key)
   - name (varchar(15))
   - description (varchar(40), null)

3. **Card:**
   - cardNum (varchar(20), primary key)
   - cardTypeID (int, foreign key references CardType(cardTypeID))
   - PIN (varchar(4), not null)
   - expireDate (date, not null)
   - balance (float, not null)

4. **UserCard:**
   - userID (int, foreign key references User(userId))
   - cardNum (varchar(20), foreign key references Card(cardNum))
   - primary key (cardNum)

5. **Transaction:**
   - transId (int, primary key)
   - transDate (date, not null)
   - cardNum (varchar(20), foreign key references Card(cardNum))
   - amount (int, not null)

6. **Transactiontype:**
   - transtypeId (int, primary key)
   - transtypename (varchar(25))
   - Descriptionn (varchar(30))

## Usage

This database simulates an ATM system with functionalities such as user management, card management, transactions, and transaction types.

### Files

- **create_database.sql:** SQL script to create the database schema.
- **insert_data.sql:** SQL script to populate the tables with sample data.
- **README.md:** This file, providing an overview of the database structure.

### Dependencies

- **SQL Server:** Ensure you have SQL Server installed to run the provided scripts.
- **SQL Server Management Studio (SSMS)** or another SQL client for executing queries.

## Getting Started

1. **Setup Database:**
   - Execute `create_database.sql` in SQL Server Management Studio (SSMS) to create the database and tables.

2. **Insert Data:**
   - Execute `insert_data.sql` to populate the tables with sample data.

3. **Run Queries:**
   - Use SQL queries to interact with the database schema and retrieve information as needed.

