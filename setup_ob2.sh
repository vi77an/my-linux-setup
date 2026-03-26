#!/bin/bash

# Configuração de caminhos
TARGET_DIR="$HOME/.local/share/openbullet2"
DOTNET_INSTALL_DIR="$HOME/.dotnet"
ZSHRC="$HOME/.zshrc"

# 1. Cria a estrutura de pastas
mkdir -p "$TARGET_DIR"

# 2. Move os arquivos (se ainda estiverem em Downloads)
if [ -d "$HOME/Downloads/OpenBullet2.Web" ]; then
    mv "$HOME/Downloads/OpenBullet2.Web/"* "$TARGET_DIR/"
    echo "Arquivos movidos para $TARGET_DIR"
fi

# 3. Garante o Runtime 8.0 local
if [ ! -d "$DOTNET_INSTALL_DIR/shared/Microsoft.AspNetCore.App/8.0.0" ]; then
    wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
    chmod +x dotnet-install.sh
    ./dotnet-install.sh --channel 8.0 --install-dir "$DOTNET_INSTALL_DIR" --runtime aspnetcore
    rm dotnet-install.sh
fi

# 4. Ajusta permissões para rodar SEM sudo
chown -R $USER:$USER "$TARGET_DIR"
chmod -R 755 "$TARGET_DIR"

# 5. Configura o alias no .zshrc
if ! grep -q "alias ob2=" "$ZSHRC"; then
    echo "alias ob2='cd $TARGET_DIR && $DOTNET_INSTALL_DIR/dotnet ./OpenBullet2.Web.dll'" >> "$ZSHRC"
    echo "Alias 'ob2' configurado."
fi

echo "Setup finalizado. Execute 'source ~/.zshrc' e depois 'ob2'."
