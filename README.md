# 🚀 TG DevOps Assignment

Welcome to my DevOps project repository! This project demonstrates end-to-end deployment of a Dockerized application on **AWS EKS** with **Terraform** infrastructure and **CI/CD automation** using GitHub Actions.

---

## 📂 Project Structure

app/ # Python application & Dockerfile
data/ # Input/Output CSV files
infra/ # Terraform scripts (EKS, S3, IAM)
k8s/ # Kubernetes manifests
.github/workflows/ # GitHub Actions workflow
README.md
.gitignore

yaml
Copy code

---

## 🛠️ Deployment Steps

### 1️⃣ Clone the repository

```bash
git clone https://github.com/DHEVIKA/tg-devops-assignment.git
cd tg-devops-assignment
2️⃣ Terraform: Provision Infrastructure
bash
Copy code
cd infra
terraform init
terraform plan
terraform apply  # confirm with 'yes'
⚠️ Ensure AWS credentials are configured: aws configure

3️⃣ Docker: Build & Push Image
bash
Copy code
cd ../app
docker build -t my-app .
docker tag my-app:latest <docker-username>/my-app:latest
docker push <docker-username>/my-app:latest
4️⃣ Kubernetes: Deploy to EKS
bash
Copy code
aws eks --region <region> update-kubeconfig --name <cluster-name>
kubectl apply -f ../k8s/
kubectl get pods
kubectl get svc
5️⃣ CI/CD: GitHub Actions
Workflow triggers:

Push to main branch

Daily automated run

Steps:

Checkout repo

Build Docker image

Push to Docker Hub

Deploy/update to EKS

🔐 Security & IAM Decisions
Least-privilege IAM roles for EKS, S3, and other resources.

EKS service accounts restricted to necessary permissions.

Secrets (Docker credentials) stored in GitHub Secrets.

Terraform .tfstate files secured; sensitive values excluded from Git.

⚖️ Trade-offs & Assumptions
.terraform folder is ignored to keep repo under GitHub size limits.

Kubernetes manifests are minimal; in production, RBAC, namespaces, and network policies would be added.

Docker images pushed to Docker Hub for simplicity.

CI/CD workflow assumes the main branch is stable and triggers daily.

🖼️ Architecture Diagram (Text-Based)
pgsql
Copy code
     +----------------+
     | GitHub Repo    |
     | (Code + CI/CD) |
     +--------+-------+
              |
              v
      +-------+-------+
      | GitHub Actions|  <-- Scheduled daily & on push
      +-------+-------+
              |
              v
     +--------+--------+
     | Docker Build     |
     | Push to Hub      |
     +--------+--------+
              |
              v
      +-------+-------+
      | AWS EKS       |  <-- Kubernetes Cluster
      | Pods/Services |
      +---------------+
              |
              v
        +-----+-----+
        | S3 / Data  |
        +-----------+

## Output


<img width="1606" height="812" alt="Screenshot 2025-10-07 110517" src="https://github.com/user-attachments/assets/df60ccdd-c1db-405a-9286-e51e1aebab1d" />

