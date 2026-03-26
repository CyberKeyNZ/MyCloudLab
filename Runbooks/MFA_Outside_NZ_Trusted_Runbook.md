# 🛡️ Conditional Access Deployment Runbook

**Title:** MFA Enforcement Outside Trusted Locations (Microsoft Entra ID)

**Audience:** Identity Engineers, Cloud Security, SOC, IT Operations

**Purpose:**
Provide a safe, repeatable, and auditable method to design, test, deploy, validate, and roll back a Conditional Access (CA) policy that enforces MFA for all sign-ins **outside a trusted geographic or network boundary**.

---

## 1️⃣ Control Objective

**Security Goal:**
Ensure all users are challenged with Multi-Factor Authentication (MFA) when signing in from **untrusted locations**, while allowing streamlined access from **trusted networks or countries**.

**Risk Addressed:**

* Credential theft
* Impossible travel
* MFA fatigue attacks
* Token replay from foreign infrastructure

**Zero Trust Principle Applied:**

> Never trust location — always verify identity, device, and risk

---

## 2️⃣ Architecture Overview

### Policy Model

**Design Pattern:** EXCLUDE-based

> Apply MFA to ALL locations EXCEPT trusted

This ensures new regions or IP ranges are automatically protected without policy updates.

### Logical Flow

```
User Signs In
      ↓
Microsoft Entra Evaluates:
- User
- App
- Location
- Risk
      ↓
IF Location ∈ Trusted
    → Allow sign-in
ELSE
    → Require MFA
```

---

## 3️⃣ Prerequisites

### Tenant

* Microsoft Entra ID P2
* Global Administrator or Conditional Access Administrator role

### Safety Controls

* Break-glass admin account
* MFA registered for test user
* At least one Named Location configured

---

## 4️⃣ Naming Standards

**Policy Name Format:**

```
MFA-Outside-<TrustedZone>
```

**Example:**

```
MFA-Outside-NZ-Trusted
```

---

## 5️⃣ Trusted Location Design

### Recommended Types

| Type              | Use Case                               |
| ----------------- | -------------------------------------- |
| Country           | Low complexity, geographic enforcement |
| IP Range          | Corporate office, VPN exit nodes       |
| Compliant Network | Microsoft Global Secure Access         |

### Example: Country-Based Trust

**Named Location:**

```
NZ-Trusted
```

**Includes:**

* New Zealand

---

## 6️⃣ Policy Configuration

### Users

| Setting | Value             |
| ------- | ----------------- |
| Include | All users         |
| Exclude | Break-glass admin |

---

### Target Resources

| Setting | Value          |
| ------- | -------------- |
| Include | All cloud apps |

---

### Network (Location)

| Setting            | Value      |
| ------------------ | ---------- |
| Mode               | Exclude    |
| Excluded Locations | NZ-Trusted |

**Resulting Logic:**

> Apply policy everywhere except NZ

---

### Grant Controls

| Setting | Value        |
| ------- | ------------ |
| Access  | Grant access |
| Control | Require MFA  |

---

### Session Controls (Optional)

| Control                    | Use Case                |
| -------------------------- | ----------------------- |
| Sign-in frequency          | Force re-authentication |
| Persistent browser session | Reduce token lifetime   |

---

### Enable Policy

| Mode        | Status  |
| ----------- | ------- |
| Report-only | Phase 1 |
| On          | Phase 3 |

---

## 7️⃣ Deployment Phases

### Phase 1 — Simulation (Report-only)

**Goal:** Observe behavior without enforcement

**Validation Tasks:**

* Sign in from trusted location
* Sign in from untrusted location
* Review Conditional Access logs

---

### Phase 2 — Evidence Collection

#### Log Location

Microsoft Entra Admin Center →

```
Monitoring → Sign-in logs
```

#### Forensic Fields

| Field          | Purpose                   |
| -------------- | ------------------------- |
| Policy Name    | Confirms evaluation       |
| Result         | Would apply / Not applied |
| Location       | Source geography          |
| IP Address     | Network origin            |
| Grant Controls | MFA / Block               |

---

### Phase 3 — Enforcement

**Change Action:**
Switch policy mode:

```
Report-only → ON
```

---

## 8️⃣ Validation Checklist

### Trusted Zone Test

| Test            | Expected Result |
| --------------- | --------------- |
| Sign in from NZ | No MFA prompt   |
| CA Result       | Not applied     |

### Untrusted Zone Test

| Test            | Expected Result        |
| --------------- | ---------------------- |
| Sign in from US | MFA required           |
| CA Result       | Success (MFA enforced) |

---

## 9️⃣ Rollback Plan

### Immediate Rollback

Option A:

```
Enable Policy → OFF
```

Option B:

```
Exclude affected user
```

### Emergency Access

| Control             | Status          |
| ------------------- | --------------- |
| Break-glass account | Always excluded |
| MFA                 | Disabled        |

---

## 🔟 Incident Scenarios

### Lockout

**Symptom:** All admins blocked

**Response:**

* Use break-glass account
* Disable policy
* Audit Named Locations

---

### False Positives

**Symptom:** MFA prompts from trusted country

**Response:**

* Verify IP geolocation
* Check VPN routing
* Validate Named Location

---

## 1️⃣1️⃣ Audit Evidence Template

### Change Record

| Field       | Value                  |
| ----------- | ---------------------- |
| Change ID   | CA-YYYY-MM-DD-001      |
| Engineer    | Name                   |
| Policy Name | MFA-Outside-NZ-Trusted |
| Mode        | Report-only → ON       |
| Approval    | Manager / CAB          |

---

### Evidence Capture

* Screenshot: Policy Summary
* Screenshot: Sign-in Log (Trusted)
* Screenshot: Sign-in Log (Untrusted)

---

## 1️⃣2️⃣ Operator Notes

### Design Strengths

* Future-proof
* Zero Trust aligned
* Audit-friendly
* Low maintenance

### Risk Considerations

* VPN bypass
* IP geolocation drift
* MFA service outages

---

## 1️⃣3️⃣ Maturity Roadmap

| Level | Capability                     |
| ----- | ------------------------------ |
| 1     | Location-based MFA             |
| 2     | Device compliance              |
| 3     | Risk-based MFA                 |
| 4     | Continuous Access Evaluation   |
| 5     | Identity Protection automation |

---

## 🧠 Operator Mindset

> Identity is the new perimeter.
> Conditional Access is your firewall.
> Logs are your packet capture.

---

## 📌 Version Control

**Version:** 1.0

**Last Updated:** 2026-02-01

**Owner:** Philip Van Den Berg

---

If you want, this can be exported into:

* PDF (Security+ Binder)
* Notion Template
* GitHub Markdown Repo

Just say which format you want next.
