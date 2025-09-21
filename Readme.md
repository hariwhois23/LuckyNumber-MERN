# Steps to Run the Project

## Application Development & Testing

**Test Before Deploy:** Always test your application locally before proceeding to containerization and deployment.

**Containerization with Docker:**
- Create Dockerfiles for both **Frontend** and **Backend** components with their required dependencies
- Use **Docker Compose** to orchestrate multiple containers (Frontend, Backend, MongoDB) seamlessly
- Single-command deployment for local development:

```bash
docker-compose up --build
```

## AWS Infrastructure Provisioning

### Prerequisites
- Configure AWS access keys to grant Terraform permissions to your AWS account
- Complete the `terraform.tfvars` file with your variable definitions

### Deploy Infrastructure
```bash
terraform apply --auto-approve
```
> **Note:** The script outputs the EC2 instance's Public IP address for subsequent configuration steps.

## CI/CD Pipeline Configuration

### Prerequisites - GitHub Secrets Setup
Configure the following in your GitHub repository secrets:
- **Public IP** (from Terraform output)
- **Host name** (ubuntu for Ubuntu instances)
- **Private key** (paired with EC2's public key)

### Continuous Integration (CI)
- **Trigger:** Code pushes to the main branch
- **Process:** Checkout code → Run application tests
- **Output:** Test coverage stored in `.lcov` file

### Continuous Deployment (CD)
- **Purpose:** Automated application deployment to production
- **Method:** Uses appleboy SSH action to connect to EC2 instance
- **Deployment:** Executes bash script running `docker-compose` for app deployment

## Security & Configuration Notes

### Security Best Practices
- Keep sensitive files private and out of public repositories
- Use environment variables for secrets and configuration

### Frontend Configuration
> **Critical:** Update frontend API URLs from `localhost` to the actual server's public IP address. This ensures proper communication between frontend and backend in production environment.

---

This streamlined process takes your application from development to production with automated testing and deployment, leveraging containerization and infrastructure as code for consistency and reliability.