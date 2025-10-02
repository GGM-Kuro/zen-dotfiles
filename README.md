# zen-dotfiles
 
# Pasos para instalar 
---
### 1. Instalar Nix (manejador de paquetes)
```bash
sh <(curl -L https://nixos.org/nix/install)
```

### 2. Configurar Nix

Para habilitar las caracteristicas experimentales y los "flakes" debemos crear/editar el archivo de configuracion:
```bash
# El fichero de configuracion puede no existir
sudo mkdir -p /etc/nix
sudo nano /etc/nix/nix.conf
```
agregamos:
```bash
extra-experimental-features = flakes nix-command
build-users-group = nixbld
```
esto debemos agregarlo para poder usar flakes y nix-command ya que son experimentales, pero con esto ya podemos usar una configuracion completamente reproducible y declarativa

### 3. Preparamos el sistema
**El fichero flake.nix ya viene preparado para correr la configuracion con un solo comando**
solo debes modificar user = "tuusuario"
las arquitecturas estan definidas en homeConfigurations={..}


### 4. Instalamos Home-Manager

```bash
# paquete adicional (puede llegar a faltar)
nix-channel --add https://nixos.org/channels/nixos-23.05 nixpkgs
nix-channel --update

# agregamos el canal home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

# actualizamos los canales 
nix-channel --update

# Instalamos home-manager
nix-shell '<home-manager>' -A install
```

### 5, Iniciamos la instalacion
```bash
# debemos estar en nuestor home 
cd ~ 
# ahora si lo glonamos
git clone https://github.com/GGM-Kuro/zen-dotfiles.git .dotfiles

# ingresamos en nuestrto proyecto en home-files
cd .config/home-files

# "x86_64" debe hacer referencia a alguna de las arquitecturas definidas en flake.nix
home-manager switch --flake .#x86_64 -b bakcup 
```

# TODO-LIST
    - update pacman, pamac config and fix sytem-links for both
