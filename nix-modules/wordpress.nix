{ pkgs, ... }:
let

wp-theme-hello = pkgs.stdenv.mkDerivation rec {
  name = "hello-elementor";
  version = "3.4.4";
  src = pkgs.fetchzip {
    url = "https://downloads.wordpress.org/theme/${name}.${version}.zip";
    hash = "sha256-G7+GztSUMMQ9hkceuUC7wW2LFyTDcWlyj8BHM/hgpaw=";
  };
  installPhase = "mkdir -p $out; cp -R * $out/";
};

wp-plugin-elementor = pkgs.stdenv.mkDerivation rec {
  name = "elementor";
  version = "3.30.2";
  src = pkgs.fetchzip {
    url = "https://downloads.wordpress.org/plugin/${name}.${version}.zip";
    hash = "sha256-Fvhni2z1W5FN/WCzcDfNOmq5L9uNxwh91e70f+b2SLg=";
  };
  installPhase = "mkdir -p $out; cp -R * $out/";
};


wp-plugin-all-in-one-wp-migration = pkgs.stdenv.mkDerivation rec {
  name = "all-in-one-wp-migration";
  version = "7.97";
  src = pkgs.fetchzip {
    url = "https://downloads.wordpress.org/plugin/${name}.${version}.zip";
    hash = "sha256-GsKpAUJQC5f9NtKehif2wGLYXAbaK+kayrN/qj7prXM=";
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p $out
    cp -R * $out/
    
    # Replace storage path in PHP files
    find $out -type f -name "*.php" -exec sed -i \
      "s|AI1WM_STORAGE_PATH', __DIR__ . '/storage|AI1WM_STORAGE_PATH', '/var/lib/wordpress/wp-content/ai1wm-storage|g" {} +
  '';
};

in {
  services.wordpress.sites."localhost" = {
    themes = { inherit wp-theme-hello; };
    plugins = {
      inherit
        # wp-plugin-all-in-one-wp-migration
        wp-plugin-elementor;
    };
  };
}
