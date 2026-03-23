You are running in NixOS under WSL2 installed via https://github.com/nix-community/NixOS-WSL

## NixOS-WSL Key Differences from Bare-Metal

**What works normally:**
- systemd (native WSL2 systemd, PID 1, no shim)
- Nix/NixOS configuration, packages, services
- User-space everything

**What doesn't apply / skip configuring:**
- Bootloader (no GRUB/systemd-boot - WSL handles boot)
- Kernel/initrd (uses Microsoft's WSL2 kernel)
- Hardware: GPU (`/dev/dri`), power management, direct disk access
- `/etc/fstab` for root filesystem

**WSL-managed (don't fight it):**
- `/etc/resolv.conf` - auto-generated DNS
- `/etc/wsl.conf` - WSL behavior config
- Network: virtual NAT via Hyper-V

**WSL-specific NixOS options** (in `configuration.nix`):
- `wsl.enable = true;` (required)
- `wsl.defaultUser = "nixos";`
- `wsl.interop.*` - Windows interop settings
- `wsl.useWindowsDriver = true;` - GPU passthrough if needed
- `wsl.docker-native.*` - Docker integration

**Windows interop:**
- `.exe` files run directly via binfmt
- Windows drives at `/mnt/c`, `/mnt/d`, etc.
- WSLg provides GUI/audio via `/mnt/wslg`
