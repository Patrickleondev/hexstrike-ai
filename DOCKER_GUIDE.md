# 🛠️ HexStrike AI - Guide Docker All-in-One (Débutant)

Ce projet est une version "dockérisée" de HexStrike AI. Cela signifie que tout l'environnement (Python, Chrome, et plus de 150 outils de sécurité comme Nmap ou SQLMap) est emballé dans une "boîte" (conteneur) virtuelle. Vous n'avez rien à installer sur votre PC à part Docker !

---

## 🚀 Installation : Pas à Pas

### 1. Pré-requis
- **Docker Desktop** (Windows/Mac) ou **Docker Engine** (Linux) doit être installé et lancé.
- **Git** pour récupérer les fichiers.

### 2. Récupérer le projet
Ouvrez votre terminal (PowerShell ou Bash) :
```bash
git clone https://github.com/Patrickleondev/hexstrike-ai.git
cd hexstrike-ai
```

### 3. Construire la "Boîte" (Build)
Cette étape crée l'image Docker. C'est comme installer Kali Linux sur une machine virtuelle, mais en ligne de commande.
*Soyez patient : Le téléchargement des outils (Nmap, Ghidra, etc.) peut prendre 10 à 20 minutes selon votre connexion.*
```bash
docker-compose build
```

### 4. Démarrer le Serveur
Lancez le conteneur en arrière-plan :
```bash
docker-compose up -d
```

---

## 📡 Comment l'utiliser ?

HexStrike AI n'a pas d'interface web classique. C'est un **Serveur MCP** (Model Context Protocol). Il sert de "bras armé" à une Intelligence Artificielle (comme Claude Desktop ou un agent personnalisé).

### Étape 1 : Vérifier que ça marche
Ouvrez simplement ce lien dans votre navigateur : [http://localhost:8888/health](http://localhost:8888/health)
Si vous voyez `{ "status": "healthy" }`, tout est bon !

### Étape 2 : Connecter votre IA (Exemple : Claude Desktop)
Pour que Claude puisse utiliser Nmap ou SQLMap, vous devez lui dire où se trouve votre serveur.
Ajoutez ceci dans votre fichier de configuration Claude (`claude_desktop_config.json`) :

```json
{
  "mcpServers": {
    "hexstrike-ai": {
      "command": "python",
      "args": [
        "CHEMIN_VERS_VOTRE_DOSSIER/hexstrike-ai/hexstrike_mcp.py",
        "--server",
        "http://localhost:8888"
      ]
    }
  }
}
```

---

## ❓ Questions Fréquentes

### "Dois-je utiliser mes propres Forks ?"
**Non, ce n'est pas obligatoire pour que ça marche.**
Vous pouvez utiliser le projet tel quel en local. Docker s'occupe de créer l'environnement pour vous.
Cependant, **je vous recommande fortement de pousser votre version sur votre GitHub** (Fork personnel) pour :
1. Sauvegarder vos configurations (et ce guide !).
2. Partager vos améliorations avec la communauté.
3. Réinstaller facilement votre environnement sur une autre machine (ex: passer de Windows à un Kali natif) juste en faisant un `git clone`.

### "Comment ajouter des outils dans le futur ?"
Si vous voulez ajouter un outil (par exemple `wireshark`), vous devez modifier le fichier **`Dockerfile`**.
1. Ouvrez `Dockerfile` avec un éditeur de texte.
2. Cherchez la section "INSTALLATION MASSIVE DES OUTILS".
3. Ajoutez le nom du paquet dans une ligne `apt-get install`.
   *Exemple :*
   ```dockerfile
   RUN apt-get install -y \
       nmap masscan ... wireshark \
       && apt-get clean
   ```
4. Relancez la construction : `docker-compose build`.

---

## 🧠 Apprendre et Maîtriser le MCP
Le **Model Context Protocol (MCP)** est une technologie récente qui permet aux IA de se connecter à des outils réels. C'est ce qui transforme un simple chatbot en hacker assistant.

Pour comprendre comment ça marche sous le capot et créer vos propres outils :

1.  **Documentation Officielle** : [modelcontextprotocol.io](https://modelcontextprotocol.io) - La bible du MCP. Commencez par l'introduction.
2.  **Introduction Vidéo (Anthropic)** : [Building with MCP](https://www.anthropic.com/news/model-context-protocol) - Explique bien le concept Client/Hôte/Ressource.
3.  **Dépôt GitHub de référence** : Regardez comment `hexstrike_mcp.py` est codé dans ce projet. C'est un excellent exemple d'implémentation Python utilisant la librairie `FastMCP`.
4.  **Tutoriels (Glama)** : [MCP Quickstart](https://glama.ai/mcp) - Pour tester des serveurs MCP simples.

---

## 📂 Commandes Utiles
- **Voir les logs** : `docker logs -f hexstrike-ai`
- **Entrer dans le conteneur (Shell)** : `docker exec -it hexstrike-ai /bin/bash`
- **Arrêter le serveur** : `docker-compose down`

*Bonne exploration avec votre IA Offensive !*
