# Azure Identity & Governance

> A reference setup for managing identities, access, and governance in Microsoft Entra ID and Azure. Built as part of AZ-104 study.

## Overview

This project documents a foundational identity and governance setup for a Microsoft Azure environment, built using Microsoft Entra ID. It covers the core building blocks an Azure administrator uses to control access: managing users and groups, assigning permissions through role-based access control (RBAC) at appropriate scopes, and enforcing organizational standards with Azure Policy. The setup follows least-privilege principles and reflects the identity and governance domain.

## What problem this solves

In any cloud environment, the central risk isn't just what you build; it's who can access it and what they're allowed to do. Without deliberate identity and governance, permissions sprawl: people accumulate more access than they need, resources get created without standards, and no one can answer "who can do what, and where?" This setup addresses that by establishing clear identities (users and groups), granting access through role assignments scoped to the narrowest level needed (least privilege), and enforcing consistent standards automatically through Azure Policy.

## Architecture

![Azure identity & governance architecture](screenshots/architecture-diagram.png)

The setup follows Azure's scope hierarchy: identities live in Microsoft Entra ID, access is granted via RBAC role assignments (who / what / where) that inherit downward through management group → subscription → resource group → resource, and Azure Policy enforces standards at scope.

## What's included

- **Users & groups** — Created and managed identities in Microsoft Entra ID, including
  individual users and security groups used to assign access collectively rather than
  per-person.
- **RBAC** — Assigned built-in roles (e.g. Virtual Machine Contributor) to users at a
  specific scope, following least-privilege principles, and removed access by deleting
  role assignments.
- **Azure Policy** — Explored policy definitions and initiatives (bundles of policies)
  for enforcing organizational standards such as tagging and region restrictions across
  scopes.
- **Azure resource hierarchy** — Worked within the management group → subscription →
  resource group → resource model that governs how access and policy inherit downward.

## Key concepts demonstrated

- **Role assignment as who / what / where** — every assignment combines an identity, a
  role (permission bundle), and a scope.
- **Scope inheritance** — access granted at a higher scope (e.g. subscription) is
  inherited by everything beneath it (resource groups, resources).
- **Privileged vs job-function roles** — Azure separates roles that can administer other
  roles (privileged, e.g. Owner) from roles that perform work but cannot grant access
  (job-function, e.g. Virtual Machine Contributor).
- **Policy vs initiative** — a policy is a single rule; an initiative is a collection of
  policies assigned together at a scope.
- **Least privilege** — granting access at the narrowest scope that meets the need.

## What I learned / would do differently

Working through this hands-on surfaced details that aren't obvious from reading alone.
The clearest example was understanding why a user with Virtual Machine Contributor
didn't appear in the "privileged role assignments" view. Azure deliberately separates
privileged roles from job-function roles, which only clicked once I had to find and
remove a specific assignment myself. I also learned that some identity features (group
licensing, self-service password reset) depend on paid Entra ID tiers that a free
account can't fully exercise, so I focused on the concepts where the hands-on was
blocked. If repeating this, I'd assign roles to groups rather than individual users from
the start, since group-based access scales far better than per-user assignments.