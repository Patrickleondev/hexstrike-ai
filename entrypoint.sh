#!/bin/bash
set -e

# Activation de l'environnement virtuel
source /opt/hexstrike-env/bin/activate

echo "🔥 Démarrage de HexStrike AI MCP Server..."

# Lancement du serveur (port 8888 par défaut dans le code, exposé dans Docker)
# On utilise 0.0.0.0 pour permettre les connexions extérieures au conteneur
export HEXSTRIKE_HOST=0.0.0.0
python3 hexstrike_server.py --port 8888
