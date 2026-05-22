# project-kratos

**Executive Summary** : Designed to tackle business revenue loss caused by slow manual rollbacks, Project Kratos provides a self-healing infrastructure. By automating the detection and recovery process, it achieves near-zero downtime through intelligent, automated deployment rollbacks.



```mermaid
graph TD
    %% Step 1: Input 
    Dev[Developer] -->|Git Push| GitRepo(GitHub Repository)

    %% Step 2: CI/CD Pipeline
    GitRepo -->|Trigger| GHA[GitHub Actions CI]
    GHA -->|Build Image| DockerHub[Docker Registry]

    %% Step 3: GitOps Core
    GitRepo -->|Sync Manifests| ArgoCD[ArgoCD Controller]
    DockerHub -->|Pull Image| K8sCluster[EKS/Kubernetes Cluster]

    %% Step 4: The Self-Healing Loop (Most Important)
    K8sCluster -->|Metrics| Prom[Prometheus Monitoring]
    Prom -->|Detect 5xx Errors| Analysis{Analysis Engine}
    
    %% Step 5: Rollback Logic
    Analysis -->|Failure Detected| ArgoCD
    ArgoCD -->|Auto Rollback| K8sCluster
    
    %% Output
    K8sCluster -->|Serve| User[End User]
```

## Key Features

**Infra as Code**: Multi-environment (Staging/Prod) setup using Terraform with remote state locking.

**Self-healing GitOps**: Automated drift detection and correction via ArgoCD

**Automated Canary Rollbacks**: Real-time monitoring of 5xx errors with 60-second automated rollbacks.



## 📂 Directory Structure

```plaintext
project-kratos/
├── .github/workflows/   # CI Pipelines (Build & Test)
├── terraform/           # Infrastructure as Code
│   ├── environments/    # Staging & Prod configs
│   └── modules/         # Reusable VPC, K8s modules
├── kubernetes/          # K8s Manifests (Helm/Kustomize)
├── src/                 # Application Source Code
└── README.md            # Project Documentation
```

