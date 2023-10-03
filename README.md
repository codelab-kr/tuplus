# Architecture
```mermaid
flowchart LR
    A[gateway] --> RabbitMQ
    subgraph RabbitMQ
      C[video-uploading] -.-> D[Metadata]
      B[video-streaming] -.-> E[History]
    end

    B --> F[(video-storage)]
    C --> F

    D --> G[(DB)]
    E --> G

    G --- J[mongodb]
    F --- H[mock-storage]
    F --- L[real-object-storage]

    subgraph OCI
      L
    end
```

## Frontend

- gateway

## Backend

- video-streaming / video-uploading \
  -- video-storage: Mock Storage / Real Storage (Azure Object Storage)

- metadata / history \
  -- db: MongoDB 

- RabbitMQ

<br>
<br>
<br>

# Development Environment
## Prerequisite

- Docker
- Docker Compose

## Up
```bash
./_up.sh
```

## Down
```bash
./_down.sh
```

## Access
- Gateway: http://localhost:4000

<br>
<br>
<br>

# Deploy to k8s
## [Azure k8s](./readme/README-azure-k8s.md)

## Azure Container Registry
```bash
mkdir -pv security/tettaform/azure
vi .env
STORAGE_ACCESS_KEY=<STORAGE_ACCESS_KEY>
```

<br>
<br>
<br>

# CI/CD
```mermaid
---
title: GitOps Flow
---
flowchart LR
  subgraph Jenkins
    job1[job build-image]
    job2[job tuplus-update-manifest]
  end
  subgraph GitHub
    repo1[code repo]
    repo2[yaml repo]
  end

  subgraph Container Registry
    image[gateway:1]
  end
  subgraph ArgoCD
    gitops[GitOps]
  end
  subgraph k8s
    image2[gateway:1]
  end
   dev[developer] --1--> repo1 --2--> job1 --push--> image
   job1 --3--> job2 --> repo2 --4--> gitops ---> image2
   image -.-> gitops
```