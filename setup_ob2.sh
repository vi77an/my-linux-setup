#!/bin/bash

# 1. Definir caminhos
DOTNET_DIR="$HOME/.dotnet"
OB2_DIR="$HOME/Downloads/OpenBullet2.Web" # Altere se mudar a pasta

# 2. Instalar o Runtime 8.0 (LTS) automaticamente
echo "📥 Instalando .NET Runtime 8.0..."
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --channel 8.0 --install-dir "$DOTNET_DIR" --runtime aspnetcore

# 3. Corrigir Permissões (Para rodar SEM sudo e evitar o aviso de segurança)
echo "🔐 Ajustando permissões da pasta..."
sudo chown -R $USER:$USER "$OB2_DIR"
chmod -R 755 "$OB2_DIR"

# 4. Criar o Alias no .zshrc (se não existir)
if ! grep -q "alias ob2=" ~/.zshrc; then
    echo "alias ob2='cd $OB2_DIR && $DOTNET_DIR/dotnet ./OpenBullet2.Web.dll'" >> ~/.zshrc
    echo "✅ Alias 'ob2' adicionado ao .zshrc"
fi

echo "🚀 Tudo pronto! Reinicie o terminal e digite 'ob2'"
