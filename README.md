[![CI](https://github.com/finitology/evento/actions/workflows/ci.yml/badge.svg)](https://github.com/finitology/evento/actions/workflows/ci.yml)
[![Go Report Card](https://goreportcard.com/badge/github.com/finitology/evento)](https://goreportcard.com/report/github.com/finitology/evento)
[![Go Reference](https://pkg.go.dev/badge/github.com/finitology/evento.svg)](https://pkg.go.dev/github.com/finitology/evento)
[![Coverage Status](https://coveralls.io/repos/github/finitology/evento/badge.svg?branch=main)](https://coveralls.io/github/finitology/evento?branch=main)
[![Release](https://img.shields.io/github/v/release/finitology/evento)](https://github.com/finitology/evento/releases)


# evento

> **evento** is a high-performance, enterprise-grade event orchestration engine purpose-built for blockchain observability and automation in regulated environments.

> **evento** is an enterprise-grade, JSON-RPC 2.0-based blockchain event indexing service designed with simplicity, scalability, and extensibility in mind.

## 🌐 Why evento?

With the rise of stablecoins, real-world assets (RWA), and evolving regulatory frameworks such as the **GENIUS Act** in the U.S., financial institutions require reliable and auditable middleware to ingest and process smart contract events. `evento` is built to serve that critical infrastructure role.

Whether you're tracking treasury-backed stablecoin transactions, RWA token movements, or DeFi protocol triggers, `evento` bridges the gap between blockchain events and traditional enterprise systems.

With the accelerating institutional adoption of stablecoins under the GENIUS Act and increasing demand for auditable event streams, Evento empowers financial institutions and infrastructure providers to seamlessly integrate blockchain event data into their existing systems with minimal friction.

---

## 🚀 Core Capabilities

| Feature                                     | MVP ✅ | Future Roadmap 🚀  |
|---------------------------------------------|--------|--------------------|
| JSON-RPC 2.0 API                            | ✅     | ✅                 |
| Supports all EVM Blockchains                | ✅     | ✅                 |
| Subscribe to smart contract events          | ✅     | ✅                 |
| ABI-based event signature parsing           | ✅     | ✅                 |
| PostgreSQL persistence                      | ✅     | ✅                 |
| Event polling from EVM-compatible nodes     | ✅     | ✅                 |
| Webhook transport                           | ✅     | ✅                 |
| Redis cluster support                       | ❌     | ✅                 |
| Kafka/SQS/Other transport integrations      | ❌     | ✅                 |
| Multi-chain support (Ethereum, Polygon etc) | ❌     | ✅                 |
| TLS/mTLS and secure webhook delivery        | ❌     | ✅                 |
| WebSocket event ingestion                   | ❌     | ❌ (by design)     |

---

## 📦 Architecture Overview

- Built in **pure Go**, with standard library and clean code practices.
- Uses `github.com/finitology/jsonrpc2` for standardized JSON-RPC 2.0 request handling.
- Stores contracts, ABIs, and sync state in **PostgreSQL**.
- Computes **event signatures** at subscription time and indexes all matching logs from contract deployment block onwards.
- **Pushes events** to downstream transports (e.g., webhook URLs).
- Tracks delivery and supports retries.

---

## 🐳 Container Images

Evento provides production-grade container images using two strategies:

| Use Case   | Base Image        | Notes |
|------------|-------------------|-------|
| Development / Testing | `golang:alpine` | Fast builds, debugger-friendly |
| Production | `gcr.io/distroless/static-debian12` | Minimal attack surface, no shell, no package manager |

---

## 📈 Scalability

While the MVP runs as a monolith, the architecture is designed to scale horizontally and vertically. With proper optimizations and batching, a single instance (e.g., 4 vCPU, 8 GB RAM) can:

- Track and index **thousands of smart contracts**
- Handle **hundreds of thousands of events per second (RPS)** with efficient log filtering
- Maintain delivery state for **millions of webhook callbacks**

Future scale strategies include:

- Event indexing workers per blockchain or per contract group
- Transport delivery queues per subscriber
- Redis-based caching of sync state and ABI data
- Sharded databases for high-throughput ingestion

---

## 📡 API Methods

### `evento_health`

```json
{
  "jsonrpc": "2.0",
  "method": "evento_health",
  "id": 1
}
```

Returns service health status.

---

### `evento_subscribe`

```json
{
  "jsonrpc": "2.0",
  "method": "evento_subscribe",
  "params": {
    "contract_address": "0xabc123...",
    "abi": [ ... ABI JSON ... ],
    "webhook_url": "https://example.com/webhook"
  },
  "id": 2
}
```

- Stores contract ABI and computed event signatures
- Begins polling blockchain from contract creation block
- Sends event payloads to the provided webhook

---

## 🛠️ Getting Started

```bash
git clone https://github.com/your-org/evento.git
cd evento
make build
./evento
```

---

## 🛠️ Project Structure (Planned)

```
evento/
├── cmd/                # Main application entrypoints
│   └── server/         # HTTP server main
├── internal/           # Private application packages
│   ├── api/            # JSON-RPC method handlers
│   ├── indexer/        # Blockchain polling logic
│   ├── storage/        # Postgres repositories
│   ├── transport/      # Webhook/Kafka/SQS
│   └── contracts/      # ABI parsing, deployment info
├── pkg/                # Reusable Go packages (optional)
├── scripts/            # DevOps scripts (DB, mocks, etc)
├── Dockerfile          # Multi-stage build
├── docker-compose.yml  # For local development
├── Makefile
└── README.md
```

---

## 🧪 Tests

```bash
make test
```

---

## 🏛️ Designed for Enterprises

- Aligns with upcoming U.S. **GENIUS Act** and stablecoin compliance needs
- Easy integration with compliance backends and on-prem/cloud hybrid topologies
- Future-ready for audit logs, security policy hooks, and programmable notifications

---

## 📜 License

Apache 2.0 — See [LICENSE](./LICENSE)

---

## 🙏 Acknowledgements

Inspired by Ethereum Indexer design patterns, JSON-RPC standards, and production infrastructure at scale.

- [Go-Ethereum](https://github.com/ethereum/go-ethereum)
- [jsonrpc2](https://github.com/finitology/jsonrpc2)