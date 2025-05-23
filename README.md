# Tokenized Supply Chain Sustainability Certification

A blockchain-based system for verifying, certifying, and tracking sustainability credentials throughout the supply chain using Clarity smart contracts.

## Overview

This project implements a comprehensive system for tokenized sustainability certification in supply chains. It enables:

- Verification of supply chain participants
- Recording and tracking of sustainability standards
- Validation of compliance through audits
- Issuance of NFT-based sustainability certificates
- Consumer verification of product sustainability claims

## Smart Contracts

The system consists of five interconnected smart contracts:

1. **Entity Verification Contract** (`entity-verification.clar`)
    - Registers and verifies supply chain participants
    - Manages entity ownership and metadata
    - Supports different entity types (suppliers, manufacturers, distributors, retailers, auditors)

2. **Standards Compliance Contract** (`standards-compliance.clar`)
    - Defines sustainability standards and requirements
    - Tracks entity compliance with standards
    - Supports different standard types (environmental, social, governance)

3. **Audit Verification Contract** (`audit-verification.clar`)
    - Records and verifies sustainability audits
    - Links audits to entities and standards
    - Tracks audit validity and expiration

4. **Certification Issuance Contract** (`certification-issuance.clar`)
    - Issues NFT-based sustainability certificates
    - Links certificates to entities and standards
    - Manages certificate validity and revocation

5. **Consumer Verification Contract** (`consumer-verification.clar`)
    - Links products to sustainability certificates
    - Enables consumers to verify product sustainability
    - Provides detailed sustainability information

## System Flow

1. Supply chain entities register and get verified
2. Sustainability standards are defined
3. Auditors perform compliance assessments
4. Verified audits lead to sustainability certificates (NFTs)
5. Certificates are linked to products
6. Consumers can verify product sustainability

## Contract Interactions

\`\`\`
┌─────────────────────┐      ┌─────────────────────┐
│ Entity Verification │◄────►│ Standards Compliance│
└─────────┬───────────┘      └──────────┬──────────┘
│                              │
│                              │
▼                              ▼
┌─────────────────────┐      ┌─────────────────────┐
│  Audit Verification │◄────►│Certification Issuance│
└─────────┬───────────┘      └──────────┬──────────┘
│                              │
│                              │
└──────────────┬───────────────┘
│
▼
┌─────────────────────┐
│Consumer Verification│
└─────────────────────┘
\`\`\`

## Testing

The project includes comprehensive tests for each contract using Vitest. Tests cover:

- Entity registration and verification
- Standards creation and compliance tracking
- Audit registration and validation
- Certificate issuance and verification
- Product-certificate linking and consumer verification

## Getting Started

1. Clone the repository
2. Run the tests: `npm test`
3. Deploy the contracts to a Stacks blockchain node

## Usage Examples

### Registering an Entity

```clarity
(contract-call? .entity-verification register-entity 
  "entity-123" 
  "Sustainable Farms Inc." 
  1 
  "California, USA"
)
