# Serverless Café Orders Platform (AWS + Terraform)

> **Project Focus Statement**  
> The goal of this project is to demonstrate **architectural best practices**, not business complexity.  
> The processing logic is intentionally minimal to highlight **scalability**, **decoupling**, and **event-driven design patterns** commonly used in real-world AWS systems.

---

## 📌 Overview
This project is a **serverless, event-driven web application** deployed on AWS using **Terraform**.
It demonstrates how to design a **scalable, decoupled, and secure architecture** using fully managed AWS services.

The application allows users to authenticate using **Amazon Cognito**, submit café orders through an API, and process those orders asynchronously using **SQS**, **Lambda**, **DynamoDB**, and **SNS**.



# Serverless Café Orders Platform (AWS + Terraform)

## 📌 Overview
This project is a **serverless, event-driven web application** deployed on AWS using **Terraform**.
It demonstrates how to design a **scalable, decoupled, and secure architecture** using fully managed AWS services.

The application allows users to authenticate using **Amazon Cognito**, submit café orders through an API, and process those orders asynchronously using **SQS**, **Lambda**, **DynamoDB**, and **SNS**.

> ⚠️ Note:  
> The business logic is intentionally kept simple.  
> The primary focus of this project is **AWS Architecture Design**, scalability, and decoupling patterns.

---

## 🏗️ Architecture Diagram

![Architecture](architecture.png)

---

## 🧱 Architecture Layers

### 🌐 Web Tier
- **Amazon S3** – Static website hosting
- **Amazon CloudFront** – Global content delivery
- **Amazon Route 53** – DNS resolution

### 🔐 Authentication
- **Amazon Cognito (Hosted UI)** – User authentication and authorization
- OAuth 2.0 implicit flow using access and ID tokens

### 🔄 Application Tier
- **Amazon API Gateway** – REST API endpoint
- **AWS Lambda (Order API)** – Receives and stores orders
- **Amazon SQS** – Decouples order submission from processing
- **AWS Lambda (Order Processor)** – Processes orders asynchronously

### 🗄️ Data Tier
- **Amazon DynamoDB** – Serverless NoSQL database for orders

### 📣 Notifications
- **Amazon SNS** – Publishes order processing notifications (email subscription)

---

## 🔁 Request Flow

1. User logs in using **Amazon Cognito Hosted UI**
2. Tokens are stored locally in the browser
3. Frontend sends API request with **Authorization Bearer Token**
4. API Gateway invokes **Lambda (Order API)**
5. Order is saved in **DynamoDB**
6. Order ID is sent to **Amazon SQS**
7. Processing Lambda consumes the message
8. Order status is updated
9. Notification is sent using **Amazon SNS**

---

## 🧠 Why SQS Between Lambda Functions?

Although the processing logic is simple, **Amazon SQS** is intentionally placed between the Lambda functions to demonstrate:

- **Decoupling** between API and processing layers
- **Handling traffic spikes** without overwhelming downstream services
- **Retry mechanism** and fault isolation
- **Asynchronous processing**
- **Scalability for future complex processing**

This pattern is commonly used in **production-grade serverless architectures**.

---

## 🛠️ Technologies Used

- AWS Lambda
- Amazon API Gateway
- Amazon Cognito
- Amazon S3
- Amazon CloudFront
- Amazon Route 53
- Amazon DynamoDB
- Amazon SQS
- Amazon SNS
- Terraform (Infrastructure as Code)

---

## 🚀 Deployment

All AWS resources are provisioned using **Terraform**.

> Terraform state files and sensitive data are excluded using `.gitignore`.

Recommended backend:
- **S3** for Terraform state
- **DynamoDB** for state locking

---

## 🔐 Security Considerations

- IAM roles with least privilege
- Cognito authentication with JWT tokens
- Authorization header validation in API Gateway
- No secrets stored in frontend code

---

## 📈 Future Improvements

- Add AWS WAF to CloudFront / API Gateway
- Enable CloudWatch Alarms and X-Ray tracing
- Implement CI/CD using GitHub Actions
- Replace implicit flow with Authorization Code + PKCE
- Add caching strategies for API Gateway

---

## 👨‍💻 Author
**Abdulrhman Ghram**  
AWS Cloud / DevOps Engineer
