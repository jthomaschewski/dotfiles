# dotfiles


### Setup new machine 

1. install chezmoi
```bash
pacman -S chezmoi
```

2. Define variables, e.g. in file `~/.config/chezmoi/chezmoi.toml`
```toml
[data]
name = "Your Name"
email = "name@example.com"
```

3. Apply config (Warning: Applies full config)
```bash
chezmoi init --apply https://github.com/jthomaschewski/dotfiles.git
```
