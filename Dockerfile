# Utilisation de l'image Kali Linux officielle (rolling) pour l'arsenal complet
FROM kalilinux/kali-rolling:latest

# Éviter les interactions lors de l'installation des paquets
ENV DEBIAN_FRONTEND=noninteractive

# Mise à jour et installation des dépendances de base
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-full \
    git \
    curl \
    wget \
    sudo \
    lsb-release \
    software-properties-common \
    && apt-get clean

# --- INSTALLATION MASSIVE DES OUTILS (Pentest Arsenal) ---

# Network & Recon
RUN apt-get install -y \
    nmap masscan rustscan amass subfinder fierce \
    dnsenum theharvester responder netexec enum4linux-ng \
    arp-scan nbtscan snmp oscanner \
    && apt-get clean

# Web App Security
RUN apt-get install -y \
    gobuster dirsearch ffuf dirb nuclei nikto \
    sqlmap wpscan arjun paramspider x8 katana httpx \
    dalfox jaeles hakrawler gau waybackurls wafw00f \
    && apt-get clean

# Password & Auth
RUN apt-get install -y \
    hydra john hashcat medusa patator \
    evil-winrm hash-identifier ophcrack \
    && apt-get clean

# Binary & Reverse
RUN apt-get install -y \
    gdb radare2 binwalk checksec \
    strings bsdmainutils ghidra \
    && apt-get clean

# Cloud & Containers
RUN apt-get install -y \
    prowler trivy kube-hunter \
    && apt-get clean

# Browser Agent (Chromium)
RUN apt-get install -y \
    chromium \
    chromium-driver \
    && apt-get clean

# --- CONFIGURATION DU PROJET ---

# Création du répertoire de travail
WORKDIR /app

# Copie des fichiers du projet
COPY . .

# Création de l'environnement virtuel et installation des dépendances Python
RUN python3 -m venv /opt/hexstrike-env
ENV PATH="/opt/hexstrike-env/bin:$PATH"

# Installation des dépendances Python
RUN pip3 install --no-cache-dir -r requirements.txt

# Création de l'entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Exposition du port API
EXPOSE 8888

# Lancement
ENTRYPOINT ["/entrypoint.sh"]
