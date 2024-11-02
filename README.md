# pets-rescue-adoption-platform
#Backend

Environment Setup:

JDK 1.8, IntelliJ IDEA, Maven, MySQL 5.7+, Navicat
Startup Steps:

Open IntelliJ IDEA, select "Open," and load the "pet-backend" project.
Configure IntelliJ with JDK 1.8 and Maven, then refresh and wait for the project to compile successfully.
Import the database file DB_Pet.sql using Navicat.
Configure the database settings in application.yml.
Start the Spring Boot backend project.
Frontend

Environment Setup:

Node 16.13.2 or higher (incompatibility issues may arise with certain versions).
Startup Steps:

Open the "pet-frontend" directory.
You can use "cmd," "VS Code," "WebStorm," "IDEA," or any environment that supports Vue development.
If unfamiliar with the command line, refer to the “Tech Stack Documentation.”
In the terminal, run the following command:
npm config set registry https://registry.npmmirror.com
npm install

Wait for the installation to complete.
In the terminal, run:
npm run dev

After completing the setup, the login page should be accessible at:
http://localhost:9312

Login Credentials:
Admin: admin / 123456
User: user / 123456
