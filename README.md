<!-- ABOUT THE PROJECT -->
## About The Project

Team Name: tcdd

Project Name: Soon

## Team Members

UI Designer: Bahadır Kümüş

Front-End Developers: Tolga Biçer, Durmuş Burak Dirikli, Doğukan Gökduman

BackEnd Developers: Efecan Arat, Bahadır Kümüş, Doğukan Gökduman

Database Managers: Doğukan Gökduman, Bahadır Kümüş 

Scrum Master / DevOps: Bahadır Kümüş, Efecan Arat

<!-- SETUP -->
## Web App Setup Guide

Follow these steps to set up and run the web app locally or via Docker.

### 1. Add Project Master Key

- Add the master key provided to the file `tcdd/config/master.key`.
- Inside this file, paste the **master key** exactly as it was provided.

### 2. Configure Environment Variables

- Create a `.env` file in the main project directory (`tcdd/.env`).
- Inside the `.env` file, add the following variables, replacing `username` and `password` with the credentials provided to you:

  ```bash
  POSTGRES_USER=username
  POSTGRES_PASSWORD=password
  ```

### Option A: Run Web App and Database Server Using Docker

1. **Build and Run the Docker Containers**:
   - In the main project directory, run the following command to build and start both the web and database containers:

     ```bash
     docker-compose up --build
     ```

2. **Initialize the Database**:
   - After the containers are up and running, execute the following command to initialize the database (create, migrate, and seed):

     ```bash
     docker-compose exec web rake db:drop db:create db:migrate db:seed
     ```

3. **Stop the Docker Containers**:
   - To stop the running containers, use:

     ```bash
     docker-compose down
     ```

   - To restart the containers, simply run:

     ```bash
     docker-compose up
     ```

### Option B: Run Web App Locally and Database Server on Docker

1. **Run PostgreSQL Container**:
   - Start the PostgreSQL database container by running:

     ```bash
     docker-compose up db
     ```

2. **Start Web App Locally**:
   - In a separate terminal window, run the following command to start the Puma web server and run Minitests using Guard:

     ```bash
     bundle exec guard
     ```

3. **Initialize the Database**:
   - For the first-time setup, run the following commands to drop, create, migrate, and seed the database:

     ```bash
     rails db:drop db:create db:migrate db:seed
     ```
---

<!-- SPRINTS -->
## Sprints

The project is planned to be completed in 5 Sprints. Project planning progresses through Trello, and tasks completed after the relevant sprint are added here. You can find the relevant  [Trello link](https://trello.com/invite/6714c2844c67cecf50ae2465/ATTIa2365e44e5b80f0e5deb5b3cb36ed3d71D28C5F4) here.

### Sprint 1 (21.10.2024 – 03.11.2024)
![Sprint1](https://github.com/user-attachments/assets/d751ef8d-fa2b-4d37-a058-3d71bc5654aa)
### Sprint 2 (04.11.2024 – 17.11.2024)
![image](https://github.com/user-attachments/assets/3bf4b05e-9860-4ae8-a478-392e35c4711c)
### Sprint 3 (18.11.2024 – 01.12.2024)
### Sprint 4 (02.12.2024 – 15.12.2024)
### Sprint 5 (16.12.2024 – 29.12.2024)
