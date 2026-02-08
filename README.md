Azayzels-RL-Skeleton

RuneLite plugin skeleton for the Azayzels plugin series.

This repo is the base template. Do not rename or run renamers inside this skeleton repo.
You only rename clones of this repo.

Requirements

Windows

Git installed

VS Code installed

Internet connection (for Gradle dependencies / Java 11 install if needed)

1) Get the skeleton onto your PC

Pick one:

Option A: GitHub “Use this template”

On GitHub, click Use this template

Create your new repo

Clone your new repo locally

Option B: Clone directly
git clone https://github.com/Wackyguy101/Azayzels-RL-Skeleton.git

2) Open the project

Open the folder in VS Code

Open a terminal in VS Code (PowerShell)

3) First-time setup (Java 11)

Run:

.\01_setup_vscode_windows.ps1


This ensures the project uses Java 11 correctly (auto-installs Java 11 if your setup script is configured to do so).

4) Build check (recommended)

Run:

.\gradlew clean build


You should see: BUILD SUCCESSFUL

5) Run (dev)

Run:

.\02_run_windows.ps1

6) Create a new plugin from this skeleton (your workflow)

Clone / copy the skeleton into a new folder

Rename the folder to your plugin name (example: Azayzels Kill Tracker)

Run your renamer script (paste from your saved notepad at this step)

Build:

.\gradlew clean build


Run:

.\02_run_windows.ps1

Important rules

Do not run renamers inside Azayzels-RL-Skeleton.

Only rename clones.

Keep the skeleton clean:

don’t commit .jdk/

don’t commit build/

don’t commit .gradle/

Troubleshooting
Build fails because Java is wrong

Run:

.\01_setup_vscode_windows.ps1


Then:

.\gradlew clean build

“Access denied” deleting .jdk or Java DLLs locked

Close VS Code / IntelliJ and stop Gradle daemons:

.\gradlew --stop


Then retry delete.

Windows system variable check (IMPORTANT)

If you still have build issues after running the setup script, verify your system variables.

Open system environment variables

Press Win + R

Type:

sysdm.cpl


Press Enter

Go to the Advanced tab

Click Environment Variables

Check / fix these variables
JAVA_HOME

If present, it must point to a Java 11 JDK

Example:

C:\Program Files\Eclipse Adoptium\jdk-11.x.x


If it points to Java 17+, edit or remove it

PATH

Ensure Java 11’s bin folder is either:

included correctly, or

Java entries are removed so Gradle can use toolchains

After changes

Click OK

Close and reopen VS Code

Run:

.\gradlew clean build

Final notes

This skeleton assumes Java 11

RuneLite plugin development will not work correctly on Java 17+

Environment variables override scripts — always check them if something feels “weird”
