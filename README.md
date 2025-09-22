# TwoTierApplication 🚀

A **two-tier application** built with **Laravel (Backend API)**, **Node.js (Frontend)**, and **MySQL (Database)**.  
This project is fully containerized with Docker and deployed on **AWS ECS (Fargate)** with an automated **CI/CD pipeline** using GitHub → CodePipeline → CodeBuild → CodeDeploy.

---

## 🛠 Tech Stack
- **Backend:** Laravel (PHP 8, Composer)
- **Frontend:** Node.js (Yarn, Vite, React/Vue/etc. depending on config)
- **Database:** Amazon RDS (MySQL)
- **Containerization:** Docker & Docker Compose
- **Orchestration:** AWS ECS (Fargate)
- **CI/CD:** AWS CodePipeline, CodeBuild, CodeDeploy (Blue/Green Deployment)
- **Storage & Secrets:**  
  - `.env` stored in **S3**  
  - Credentials managed via **AWS Secrets Manager**  
- **Networking & Security:**  
  - **Application Load Balancer (ALB)** + Target Groups  
  - **Route53** for DNS  
  - **ACM** for SSL Certificates  
- **Monitoring & Notifications:**  
  - **CloudWatch** (logs & metrics)  
  - **SNS** (deployment notifications)

---

## 📂 Project Structure
```
TwoTierApplication/
│── app/                # Laravel backend app code
│── bootstrap/
│── config/
│── database/
│── public/             # Laravel public assets
│── resources/          # Frontend (Node.js)
│── routes/
│── storage/
│── tests/
│── vendor/
│
│── Dockerfile          # Laravel App Dockerfile
│── Dockerfile.nginx    # Nginx for serving Laravel
│── Dockerfile.node     # Node.js frontend
│── docker-compose.yml  # Local setup with multiple containers
│
│── buildspec.yml       # CodeBuild config
│── appspec.yml         # CodeDeploy config
│── taskdef.json        # ECS Task Definition for Blue/Green
│
│── composer.json / lock
│── package.json / yarn.lock
│── vite.config.js
│── .env (stored in S3 for production)
```

---

## ⚙️ Local Development (Docker Compose)

```bash
# Clone repo
git clone https://github.com/your-org/TwoTierApplication.git
cd TwoTierApplication

# Copy environment file
cp .env.example .env

# Start containers
docker-compose up -d --build

# Run migrations
docker exec -it laravel-app php artisan migrate
```

- Laravel API available at: `http://localhost:8000`  
- Node frontend available at: `http://localhost:3000`

---

## 🚀 CI/CD Workflow (AWS)

1. **Developer pushes code to GitHub**  
2. **CodePipeline** triggers:
   - **CodeBuild:**  
     - Installs dependencies  
     - Builds Node frontend (`yarn install && yarn run build`)  
     - Builds Laravel backend (`composer install`)  
     - Creates Docker images (`laravel-app`, `laravel-nginx`, `laravel-node`)  
     - Pushes images to **Amazon ECR**  
   - **CodeDeploy (Blue/Green):**  
     - Deploys new ECS task definition  
     - Performs Blue/Green deployment on ECS service  
     - Updates Application Load Balancer target group  
3. **ECS Service** updated with new version.  
4. **Route53 + ACM** provide DNS + SSL for the app.  
5. **CloudWatch & SNS** handle monitoring + notifications.

---

## 🔐 Environment & Secrets
- `.env` file stored securely in **S3** (fetched at deployment).  
- Database and API secrets managed in **AWS Secrets Manager**.  
- Do **not** commit `.env` to GitHub.

---

## 📊 Monitoring & Logs
- Application & ECS logs → **CloudWatch Logs**  
- Deployment status → **SNS Notifications**  

---

## 📜 Deployment Notes
- Deployment type: **Blue/Green (ECS Fargate)**  
- Load balancing via **Application Load Balancer (ALB)**  
- Health checks configured on `/` route  

---

## 🤝 Contribution
1. Fork the repo  
2. Create a feature branch (`git checkout -b feature/my-feature`)  
3. Commit your changes (`git commit -m 'Added new feature'`)  
4. Push to GitHub (`git push origin feature/my-feature`)  
5. Create a Pull Request  

---

## 📄 License
Licensed under the [MIT License](LICENSE).  
