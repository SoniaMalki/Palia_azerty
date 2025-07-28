# Palia AZERTY Patch 🇫🇷

Un patch simple pour configurer les touches de Palia pour les claviers AZERTY (déplacement en ZQSD et raccourcis F1-F8).

*Read this in English: [English Version](#-palia-azerty-patch--en)*

---

## ✅ Méthode Recommandée (Simple et Rapide)

1.  **Télécharger l'exécutable** : Allez dans la section [**Releases**](https://github.com/Sousa-Wagner/Palia-AZERTY-Patch/releases/latest) et téléchargez le fichier `PaliaAzertyPatcher.exe`.
2.  **Lancer le patcher** :
    *   Assurez-vous que Palia est bien fermé.
    *   Exécutez `PaliaAzertyPatcher.exe`. Il s'occupe de tout.
    *   *Note : Vous devez toujours installer AutoHotkey (voir étape 1 ci-dessous) pour que les touches F1-F8 fonctionnent.*

---

## 👨‍💻 Méthode Manuelle (Instructions originales)

### 🎯 Le Problème Corrigé

Par défaut, Palia n'est pas pensé pour les claviers français. Ce patch corrige deux problèmes majeurs :

1.  **Le déplacement (ZQSD) :** Le script modifie la configuration du jeu pour que Z, Q, S, D servent à se déplacer.
2.  **La barre de raccourcis :** Le jeu attend les touches `1, 2, 3...`. Sur un clavier AZERTY, il faut faire `Maj` pour y accéder. Ce patch utilise **AutoHotkey** pour que les touches `F1` à `F8` activent les objets de la barre de raccourcis, ce qui est bien plus pratique.

### 🧰 Ce que font les fichiers

Ce projet contient 2 fichiers essentiels pour la méthode manuelle :

*   `patch_palia_azerty.ps1` : Le script principal qui modifie le fichier de configuration de Palia. **À ne lancer qu'une seule fois.**
*   `Palia.ahk` : Le script pour AutoHotkey qui s'occupe des touches F1 à F8. Il doit être actif quand vous jouez.

---

### ✅ Étape 1 : Installer AutoHotkey (Indispensable)

Cet outil gratuit et sécurisé permet de simuler les touches F1 à F8.

1.  Téléchargez **AutoHotkey v2** sur le site officiel : 🔗 **https://www.autohotkey.com/**
2.  Cliquez sur "Download", puis "Download Current Version".
3.  Lancez l'installeur et choisissez "Express Installation". C'est tout !

---

### ✅ Étape 2 : Lancer le Patch

C'est ici qu'on modifie les touches du jeu.

1.  Assurez-vous que `patch_palia_azerty.ps1` et `Palia.ahk` sont dans le même dossier.
2.  Faites un **clic droit** sur `patch_palia_azerty.ps1`.
3.  Choisissez **"Exécuter avec PowerShell"**.
4.  Une fenêtre (souvent bleue) va s'ouvrir, appliquer les changements et lancer le script `Palia.ahk` pour vous.

Une fois que c'est fait, vous n'avez plus besoin de relancer ce patch, sauf si une mise à jour du jeu réinitialise vos touches.

---

### ✅ Étape 3 : Vérifier que tout est actif

Pour que les touches F1-F8 fonctionnent, le script AutoHotkey doit tourner en fond.

1.  Regardez en bas à droite de votre écran, près de l’horloge.
2.  Cliquez sur la petite flèche (^) pour afficher les icônes cachées.
3.  Vous devez voir une **icône verte avec un "H"**. Si elle est là, tout est prêt ! ✅

> **L'icône "H" n'est pas là ?** Pas de panique. Allez dans votre dossier `Documents\AutoHotkey` et double-cliquez sur le fichier `Palia.ahk` pour le lancer manuellement.

---

### 💡 Dépannage (FAQ)

*   **"Une erreur rouge s'affiche quand je lance le script PowerShell !"**
    *   C'est sûrement la politique de sécurité de Windows. C'est facile à corriger.
    *   1. Ouvrez le menu Démarrer, tapez "PowerShell", faites un **clic droit** dessus et "Exécuter en tant qu'administrateur".
    *   2. Copiez-collez cette commande dans la fenêtre bleue et appuyez sur Entrée : `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
    *   3. Tapez `O` (pour Oui) et validez. C'est bon ! Relancez le patch.

*   **"Comment annuler les changements ?"**
    *   Le patch a créé une sauvegarde. Allez dans :
        `C:\Users\VotreNom\AppData\Local\Palia\Saved\Config\WindowsClient`
    *   Supprimez le fichier `GameUserSettings.ini`.
    *   Renommez `GameUserSettings_original.ini` en `GameUserSettings.ini`.

*   **"Comment désactiver le script AutoHotkey ?"**
    *   Faites un clic droit sur l'icône verte "H" et choisissez "Exit".

---
<br>

# 🇬🇧 Palia AZERTY Patch – EN

A simple patch to set up Palia's keybindings for AZERTY keyboards (ZQSD movement and F1-F8 shortcuts).

---

## ✅ Recommended Method (Quick & Easy)

1.  **Download the executable**: Go to the [**Releases**](https://github.com/Sousa-Wagner/Palia-AZERTY-Patch/releases/latest) page and download the `PaliaAzertyPatcher.exe` file.
2.  **Run the patcher**:
    *   Make sure Palia is closed.
    *   Run `PaliaAzertyPatcher.exe`. It handles everything.
    *   *Note: You still need to install AutoHotkey (see step 1 below) for the F1-F8 keys to work.*

---

## 👨‍💻 Manual Method (Original Instructions)

### 🎯 The Problem It Solves

Palia's default settings aren't ideal for French keyboards. This patch fixes two main issues:

1.  **Movement (ZQSD):** The script patches the game's config file to use Z, Q, S, D for movement.
2.  **Shortcut Bar:** The game expects keys `1, 2, 3...`, which require `Shift` on an AZERTY keyboard. This patch uses **AutoHotkey** to map your `F1` to `F8` keys to the shortcut bar for much easier access.

### 🧰 What The Files Do

This project contains 2 key files for the manual method:

*   `patch_palia_azerty.ps1`: The main script that patches Palia's config file. **You only need to run this once.**
*   `Palia.ahk`: The AutoHotkey script that handles the F1-F8 keys. It needs to be running while you play.

---

### ✅ Step 1: Install AutoHotkey (Required)

This free and safe tool is needed to remap the F1-F8 keys.

1.  Download **AutoHotkey v2** from the official website: 🔗 **https://www.autohotkey.com/**
2.  Click "Download", then "Download Current Version".
3.  Run the installer and select "Express Installation". You're done!

---

### ✅ Step 2: Run the Patch

This is where the magic happens.

1.  Make sure `patch_palia_azerty.ps1` and `Palia.ahk` are in the same folder.
2.  **Right-click** on `patch_palia_azerty.ps1`.
3.  Select **"Run with PowerShell"**.
4.  A window (usually blue) will pop up, apply the changes, and launch the `Palia.ahk` script for you.

You don't need to run this patch again unless a game update resets your keybindings.

---

### ✅ Step 3: Check if it's running

For the F1-F8 keys to work, the AutoHotkey script must be running in the background.

1.  Look at the bottom-right of your screen, near the clock (system tray).
2.  Click the small arrow (^) to show hidden icons.
3.  You should see a **green "H" icon**. If it's there, you're good to go! ✅

> **Don't see the "H" icon?** No worries. Go to your `Documents\AutoHotkey` folder and double-click the `Palia.ahk` file to start it manually.

---

### 💡 Troubleshooting (FAQ)

*   **"I see a red error when I run the PowerShell script!"**
    *   This is likely Windows' script security policy. It's an easy fix.
    *   1. Open your Start Menu, type "PowerShell", **right-click** it, and "Run as administrator".
    *   2. In the blue window, paste this command and press Enter: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
    *   3. Type `Y` (for Yes) and confirm. Done! Now run the patch again.

*   **"How can I undo the changes?"**
    *   The patch made a backup for you. Go to:
        `C:\Users\YourName\AppData\Local\Palia\Saved\Config\WindowsClient`
    *   Delete the `GameUserSettings.ini` file.
    *   Rename `GameUserSettings_original.ini` to `GameUserSettings.ini`.

*   **"How do I stop the AutoHotkey script?"**
    *   Right-click the green "H" icon in your system tray and choose "Exit".
    
---
### ❤️ Credits

Icon used for the executable:
<a href="https://www.flaticon.com/free-icons/keyboard-and-mouse" title="Keyboard and mouse icons">Keyboard and mouse icons created by Muhammad Atif - Flaticon</a>
