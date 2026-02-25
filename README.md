# runpod-nvm-node-bash-installer
install nvm / latest node in runpod

```
wget -qO- https://raw.githubusercontent.com/justinwlin/runpod-nvm-node-bash-installer/refs/heads/main/nvmnode.sh | bash && source ~/.bashrc
```

## Potential Issue: nvm not found in non-interactive shells

### Problem

nvm is installed via `.bashrc`, but `.bashrc` has a guard at the top:

```bash
case $- in
  *i*) ;;
  *) return;;
esac
```

This exits early for non-interactive shells, so the nvm/PATH setup never runs when using commands like `su - claude -c "command"`. You'll see errors like `nvm: command not found` or `node: command not found` even though nvm is installed.

### Fix

Create a `~/.bash_profile` for the user that loads nvm before the interactive check runs:

```bash
# ~/.bash_profile
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
```

This ensures nvm and node are on the PATH for all login shells (interactive or not).
