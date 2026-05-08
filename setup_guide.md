# QuizMaster - Complete Setup Guide

This guide is written specifically for beginners to successfully set up, run, and deploy the QuizMaster project. We will use a clean Java Web Architecture (Tomcat + JSP + Servlets) and connect it to a free Supabase PostgreSQL database.

## Phase 1: Software Installation
Before starting, ensure you have the following installed:
1. **Java Development Kit (JDK) 17**: Download and install from the Oracle or Adoptium website.
2. **Eclipse IDE for Enterprise Java and Web Developers**: Crucial for running Java web projects easily.
3. **Apache Maven**: Install Maven and add it to your System PATH.
4. **Git**: To version control your code.
5. **Docker Desktop** (Optional, but useful for testing deployment locally).

## Phase 2: Database Setup (Supabase)
We are using Supabase because it provides a free, powerful PostgreSQL database in the cloud.

1. Go to [Supabase](https://supabase.com/) and create a free account.
2. Create a New Project. Note your Database Password; you won't be able to see it again.
3. Once the project is ready, click on the **SQL Editor** on the left menu.
4. Open the `schema.sql` file from your QuizMaster project folder, copy all the contents, and paste it into the SQL Editor.
5. Click **Run**. This will create all the necessary tables (users, profiles, streaks, quiz_modes, quiz_attempts).
6. Go to **Project Settings -> Database** and find your **Connection String (JDBC)**. It looks like this:
   `jdbc:postgresql://db.xxxxxx.supabase.co:5432/postgres`

## Phase 3: Project Configuration
1. Open Eclipse and select `File -> Import... -> Maven -> Existing Maven Projects`.
2. Browse to the `QuizMaster` folder and click **Finish**.
3. Open the file `src/main/java/quiz/db/DBConnection.java`.
4. You don't need to change the code directly if you use environment variables. However, for quick local testing, you can temporarily replace the default values in `getEnv(...)` with your Supabase credentials:
   - `DB_URL`: Your Supabase JDBC URL
   - `DB_USER`: Usually `postgres`
   - `DB_PASSWORD`: The password you created in Step 2.

## Phase 4: Running Locally in Eclipse
1. In Eclipse, go to `Window -> Preferences -> Server -> Runtime Environments`.
2. Click **Add...** and select **Apache Tomcat v10.1**. Provide the path to a downloaded Tomcat 10.1 directory.
3. Right-click the `QuizMaster` project in the Project Explorer, select `Run As -> Run on Server`.
4. Select your Tomcat 10.1 server and click **Finish**.
5. The application will open in a browser. You can log in using the default admin account (`admin` / `admin123`) or register a new user.

## Phase 5: Building for Production
1. Open your terminal or command prompt.
2. Navigate to the root of the QuizMaster project.
3. Run the following command:
   ```bash
   mvn clean package
   ```
4. This will create a `ROOT.war` file inside the `target/` directory. This is your bundled web application.

## Phase 6: Deployment
Please refer to the `deployment_guide.md` for step-by-step instructions on deploying this application to Render.
