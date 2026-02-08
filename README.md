Azayzels-RL-Skeleton

RuneLite plugin skeleton for the Azayzels plugin series.

This repository is a base template used to create new RuneLite plugins.
It is intentionally minimal, portable, and designed to be cloned repeatedly.

Base package note (important)

The base package in this skeleton is intentionally named:

com.azayzels.azayzelsrlskeleton


This is a temporary placeholder package used only in the skeleton.

When you clone this repository to start a real plugin, the package name will be renamed automatically by your renamer script.

Do not rename packages or run renamers inside this skeleton repo.

Rules (read this once)

❌ Do NOT rename this skeleton repo

❌ Do NOT run renamer scripts inside this repo

✅ ONLY rename clones of this repo

✅ Treat this repo as immutable once cloned correctly

Requirements

Windows

Git installed

VS Code installed

Internet connection (for Gradle dependencies / Java 11 install if needed)

1) Get the skeleton onto your PC

Choose one method:

Option A: GitHub template (recommended)

Click Use this template on GitHub

Create your new repository

Clone your new repository locally

Option B: Clone directly
git clone https://github.com/Wackyguy101/Azayzels-RL-Skeleton.git

2) Open the project

Open the folder in VS Code

Open a PowerShell terminal inside VS Code

3) First-time setup (Java 11)

Run:

.\01_setup_vscode_windows.ps1


This ensures:

Java 11 is used

Gradle is configured correctly

(Optional) Java 11 is auto-installed if your setup script supports it

4) Build check (recommended)

Run:

.\gradlew clean build


Expected result:

BUILD SUCCESSFUL

5) Run (development)

Run:

.\02_run_windows.ps1

6) Create a new plugin from this skeleton (normal workflow)

This is the only time renaming happens.

Clone or copy this skeleton into a new folder

Rename the folder to your plugin name
Example:

Azayzels Kill Tracker


Run your renamer script
(paste from your saved notepad at this step)

Build:

.\gradlew clean build


Run:

.\02_run_windows.ps1

Keep the skeleton clean

Do not commit the following to this repo:

.jdk/

build/

.gradle/

These are local artifacts only.

Troubleshooting
Build fails due to Java issues

Run:

.\01_setup_vscode_windows.ps1


Then:

.\gradlew clean build

“Access denied” when deleting .jdk or Java DLLs

Close VS Code / IntelliJ

Stop Gradle daemons:

.\gradlew --stop


Retry deletion

Windows system variable check (IMPORTANT)

If problems persist, check your system environment variables.

Open system environment variables

Press Win + R

Type:

sysdm.cpl


Press Enter

Go to the Advanced tab

Click Environment Variables

Verify these variables
JAVA_HOME

If present, it must point to a Java 11 JDK

Example:

C:\Program Files\Eclipse Adoptium\jdk-11.x.x


If it points to Java 17+, edit or remove it

PATH

Ensure Java 11’s bin directory is either:

configured correctly, or

Java entries are removed so Gradle toolchains can decide

After making changes

Click OK

Close and reopen VS Code

Run:

.\gradlew clean build

Final notes

This skeleton assumes Java 11

RuneLite plugin development will not work correctly on Java 17+

Environment variables override scripts — always check them if behavior feels wrong
