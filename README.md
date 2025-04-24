# Nixvim Configuration

[![Built with Nix](https://img.shields.io/badge/Built_With-Nix-5277C3.svg?logo=nixos&labelColor=73C3D5)](https://nixos.org/)
[![Powered by Nixvim](https://img.shields.io/badge/Powered_By-Nixvim-green.svg)](https://github.com/nix-community/nixvim)

A reproducible, declarative, and customized Neovim configuration using the Nixvim Framework.

## Features

- Fully declarative Neovim configuration using Nix
- Reproducible setup across different machines
- Easy installation using Nix flakes
- Customized key mappings, plugins, and themes
- Built on top of the powerful Nixvim framework

## Quick Start

### Prerequisites

- [Nix package manager](https://nixos.org/download.html) with flakes enabled

### Installation

You can run this configuration directly using:

```bash
nix run github:Lukerten/nixvim
```

### Installation as a Development Environment

To use this as your development environment:

```bash
# Clone the repository
git clone https://github.com/Lukerten/nixvim.git
cd nixvim

# Run Neovim with this configuration
nix run .
```

## Configuration Overview

This repository contains my personal Neovim configuration built with the [Nixvim](https://github.com/nix-community/nixvim) framework. The configuration is organized in a modular way, making it easy to understand and extend.

## Customization

To customize this configuration for your own use:

1. Fork this repository
2. Modify the Nix files according to your preferences
3. Run `nix run .` to test your changes

## Acknowledgments

- [Nix](https://nixos.org/) - The purely functional package manager
- [Nixvim](https://github.com/nix-community/nixvim) - The framework used to configure Neovim with Nix
- [Neovim](https://neovim.io/) - The next generation Vim editor

## License

This project is licensed under the MIT License - see the LICENSE file for details.
