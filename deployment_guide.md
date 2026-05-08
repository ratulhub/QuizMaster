# QuizMaster - Deployment Guide

This guide explains how to deploy the QuizMaster monolithic Java web application to **Render**.

We are utilizing a **Dockerfile** to bundle our Java application with Tomcat 10.1, making deployment seamless and professional.

## Prerequisites
1. You have built your project (`mvn clean package`) and verified that `target/ROOT.war` exists.
2. You have set up your Supabase PostgreSQL database.
3. You have a GitHub account.
4. You have a Render account.

## Step 1: Push to GitHub
Render pulls your code directly from GitHub.
1. Open your terminal in the `QuizMaster` folder.
2. Initialize and push your code:
   ```bash
   git init
   git add .
   git commit -m "Ready for production"
   git branch -M main
   git remote add origin https://github.com/yourusername/QuizMaster.git
   git push -u origin main
   ```

## Step 2: Create a Web Service on Render
1. Log in to [Render](https://render.com/).
2. Click **New +** and select **Web Service**.
3. Connect your GitHub account and select the `QuizMaster` repository.
4. Configure the service:
   - **Name**: `quizmaster-app`
   - **Region**: Select the closest one.
   - **Branch**: `main`
   - **Runtime**: `Docker` (Render will automatically detect the Dockerfile in your repository).
   - **Instance Type**: Free (or Starter if you prefer).

## Step 3: Configure Environment Variables
Before clicking "Create Web Service", scroll down to **Environment Variables** and add the following:
- `DB_URL`: Your Supabase JDBC Connection URL (e.g., `jdbc:postgresql://db.xxxx.supabase.co:5432/postgres`)
- `DB_USER`: `postgres`
- `DB_PASSWORD`: Your Supabase password.

## Step 4: Deploy
1. Click **Create Web Service**.
2. Render will now start building your Docker image. This process involves:
   - Pulling the `tomcat:10.1-jdk17` image.
   - Copying your `target/ROOT.war` file.
   - Starting the Tomcat server on port 8080.
3. Once the build is complete, you will see a green "Live" badge.
4. Click on the URL provided by Render (e.g., `https://quizmaster-app.onrender.com`) to access your live application!

## Troubleshooting
- **Database Connection Error**: Double-check your `DB_URL`, `DB_USER`, and `DB_PASSWORD` in the Render Environment Variables tab. Ensure you are using the JDBC connection string, not the URI.
- **Application Not Updating**: If you make changes to your code, ensure you run `mvn clean package` locally BEFORE committing and pushing to GitHub. Render needs the updated `.war` file in the repository.
