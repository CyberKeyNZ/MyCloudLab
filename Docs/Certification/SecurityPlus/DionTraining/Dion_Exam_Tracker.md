🛡️ Section 1.1: General Security Concepts
1. The CIA Triad
The foundation of all security. Every exam question about "goals" usually points back to one of these:

* Confidentiality: Ensuring only authorized people see the data (Encryption, Access Control).

* Integrity: Ensuring the data hasn't been changed (Hashing, Digital Signatures).

* Availability: Ensuring systems are up when needed (Redundancy, Backups, Patching).

2. Essential Terminology
* Gap Analysis: Comparing where you are now to where you want to be (the "Gap" in your security).

* Zero Trust: The "Never Trust, Always Verify" mindset. Even if someone is inside the network, they must prove who they are.

* Plane of Control: This is the "Manager" layer that decides how traffic moves.

* Plane of Data: This is the "Worker" layer where the actual traffic flows based on the Control Plane's orders.

3. Security Control Categories
CompTIA loves to test you on what kind of control you are using:

* Technical (Logical): Hardware/Software (Firewalls, Antivirus, Encryption).

* Managerial (Administrative): Policies, Procedures, and Training.

* Operational: Day-to-day human tasks (Physical security, log reviews).

* Physical: Things you can touch (Locks, Cameras, Fences).

4. Security Control Types (The "Action")
* Preventive: Stops the event before it happens (Firewalls, Guard Dogs).

* Detective: Records or alerts you that an event happened (Logs, CCTV, Motion Sensors).

* Corrective: Fixes the problem after it happens (Backups, Antivirus cleaning).

* Deterrent: Discourages the attacker (Warning signs, "Dummy" cameras).

* Compensating: A "Plan B" when the main control isn't possible (e.g., using a separate log server because the main app can't encrypt).

---

Acronym_CheatSheet:
Acronym----Full Name-------------------------------------Why it Matters
CIA      "Confidentiality, Integrity, Availability"     "The three pillars of the security ""triad."""
BIA       Business Impact Analysis                      Part of risk management; determines what happens if a service goes down.
CCTV      Closed-Circuit Television                     A physical/operational detective control.
AUP      Acceptable Use Policy                          A managerial control defining how employees use company tech.
NDA      Non-Disclosure Agreement                      A managerial/legal control to protect confidentiality.
SLE      Single Loss Expectancy                        The cost of a single risk event (Asset Value x Exposure Factor).
ALE      Annual Loss Expectancy                       The yearly cost of a risk (SLE x Annual Rate of Occurrence).
SLA     Service Level Agreement                       "A contract defining the ""Availability"" a provider must maintain."