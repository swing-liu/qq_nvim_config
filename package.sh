#!/bin/bash
# 打包 Neovim 全套配置和插件

BACKUP_FILE="nvim-full-$(date +%Y%m%d).tar.gz"

tar -zcf "$BACKUP_FILE" \
  ~/.config/nvim \
  ~/.local/share/nvim \
  ~/.local/state/nvim \
  /usr/local/share/nvim

echo "✅ 已创建: $BACKUP_FILE"
echo "解压到新机器: tar -xzvf $BACKUP_FILE -C ~/"

