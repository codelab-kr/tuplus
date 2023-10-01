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
    G --- M[real-DBMS]

    subgraph OCI
      L
      M
    end
```

## Frontend

- gateway

## Backend

- video-streaming / video-uploading \
  -> video-storage: Mock Storage (local) / Real Storage (OCI Object Storage)

- metadata / history \
  -> db: MongoDB (local) / Real DB (OCI DB)

- RabbitMQ

<br>

# Development Environment (Local)

## Prerequisite

- Docker
- Docker Compose

## Run

```bash
docker-compose up --build -d
```

## Stop

```bash
docker-compose down -v
```

## Access

- Gateway: http://localhost:4000

# Deployment (OCI)

chmod +x ./scripts/cd/infrastructure.sh
./scripts/cd/infrastructure.sh

cat ~/.kube/free-k8s-config-seoul | base64 | pbcopy

github -> settings -> secrets ->
KUBE_CONFIG
CONTAINER_REGISTRY
REGISTRY_UN
REGISTRY_PW
COMPARTMENT_ID
BUCKET_NAME
NAMESPACE

OCI_CONFIG
OKE_CLUSTER_OCID
OCI_CLI_USER
OCI_CLI_TENANCY
OCI_CLI_FINGERPRINT
OCI_CLI_KEY_CONTENT
OCI_CLI_REGION
OKE_CLUSTER_OCID

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