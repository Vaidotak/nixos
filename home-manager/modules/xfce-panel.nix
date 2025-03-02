{ config, lib, pkgs, ... }:

let
  # Apibrėžiame skriptų talpinimo vietą
  scriptsDir = "${config.home.homeDirectory}/bin/skydelio_skriptai";
  
  # Funkcija skriptų sukūrimui
  makeScript = name: text: {
    target = "${scriptsDir}/${name}";
    text = ''
      #!/usr/bin/env bash

      # File name: ${name}
      # Author vaidotak
      # Date: ${builtins.substring 0 10 (builtins.toString builtins.currentTime)}
      # Description:
      # URL:

      ${text}
    '';
    executable = true;
  };

  # Skriptų turinys
  scripts = {
    "installed.sh" = ''
      echo "Installed: $(stat -c %w / | cut -b 1-16)"
    '';

    "uptime.sh" = ''
      echo " $(uptime | awk -F'[ ,]+' '{print $4}')"
    '';

    "cpu_xfce.sh" = ''
      vmstat 2 | awk 'NR==3 {print "CPU: " 100-$15 "%"}'
    '';

    "sistemos_pavadinimas.sh" = ''
      echo " $(awk -F '=' '/^NAME=/{name=$2} /^VERSION=/{ver=$2} END{gsub(/"/, "", name); gsub(/"/, "", ver); print name, ver}' /etc/os-release)"
      ( ($(date +%s) - $(date -d "$(stat -c %w / | cut -b 1-16)" +%s)) / 86400 )

      date -d "$(stat -c %w / | cut -b 1-16)" +"%Y-%m-%d"
    '';

    "free_disko_talpa.sh" = ''
      df -h / | awk '/\// {print $4}'
    '';

    "ram_xfce.sh" = ''
      free -m | awk '/Mem/ {printf "%d%%\\n", $3*100/$2}'
    '';

    "wifi.sh" = ''
      interface=$(iw dev | grep Interface | awk '{print $2}')
      if [ -z "$interface" ]; then
          echo "📡 No WiFi"
          exit 1
      fi

      ssid=$(iw dev "$interface" link | grep "SSID" | awk '{print $2}')
      signal_strength=$(iw dev "$interface" link | grep signal | awk '{print $2}')

      if [ -z "$ssid" ]; then
          echo "📡 Disconnected"
      else
          # Pasirink tinkamą ikoną
          echo 📡 "$ssid: $signal_strength dBm"
      fi
    '';

    "progresas.sh" = ''
      # Description: Parodo metų progresą
      # URL: https://funkcijos.wordpress.com/2024/05/28/metu-progresijos-vizualizavimas-bash-skriptuose/

      metu_progresas() {
          local bar_length=''${1:-20}  # Numatytoji juostos ilgis yra 40, jei nenurodytas kitas
          local filled_color="\\e[1;33m"  # Ryškiai geltona spalva užpildytiems simboliams
          local empty_color="\\e[37m"     # Balta spalva tuštiems simboliams
          local reset_color="\\e[0m"      # Numatytoji spalva

          # Gauti dabartinę dieną (metų dienos numeris)
          current_day=$(date +%-j)

          # Gauti iš viso metų dienų skaičių
          total_days=$(date -d "Dec 31" +%-j)

          # Apskaičiuoti metų progresą procentais
          progress=$((current_day * 100 / total_days))

          # Apskaičiuoti užpildytų ir tuščių simbolių skaičių
          filled_chars=$((progress * bar_length / 100))
          open_chars=$((bar_length - filled_chars))

          # Sukurti vizualią juostą su "█" užimtai vietai ir "░" laisvai vietai
          bar=$(printf "%0.s█" $(seq 1 $filled_chars))
          bar+=$(printf "%0.s░" $(seq 1 $open_chars))

          # Parodyti rezultatą su spalvomis
          echo -e "Metų progresas: ''${filled_color}[''${bar:0:filled_chars}''${empty_color}''${bar:filled_chars}] ''${reset_color}''${progress}%"
      }

      metu_progresas
    '';
  };

  # XFCE panelės konfigūracijos failas
  xfcePanelConfig = ''
    <?xml version="1.1" encoding="UTF-8"?>

    <channel name="xfce4-panel" version="1.0">
      <property name="configver" type="int" value="2"/>
      <property name="panels" type="array">
        <value type="int" value="1"/>
        <value type="int" value="2"/>
        <property name="dark-mode" type="bool" value="true"/>
        <property name="panel-1" type="empty">
          <property name="position" type="string" value="p=6;x=0;y=0"/>
          <property name="length" type="double" value="100"/>
          <property name="position-locked" type="bool" value="true"/>
          <property name="icon-size" type="uint" value="0"/>
          <property name="size" type="uint" value="26"/>
          <property name="plugin-ids" type="array">
            <value type="int" value="15"/>
            <value type="int" value="1"/>
            <value type="int" value="35"/>
            <value type="int" value="13"/>
            <value type="int" value="20"/>
            <value type="int" value="22"/>
            <value type="int" value="34"/>
            <value type="int" value="18"/>
            <value type="int" value="17"/>
            <value type="int" value="19"/>
            <value type="int" value="27"/>
            <value type="int" value="21"/>
            <value type="int" value="3"/>
            <value type="int" value="2"/>
            <value type="int" value="29"/>
            <value type="int" value="26"/>
            <value type="int" value="30"/>
            <value type="int" value="16"/>
            <value type="int" value="36"/>
            <value type="int" value="23"/>
            <value type="int" value="33"/>
            <value type="int" value="5"/>
            <value type="int" value="43"/>
            <value type="int" value="8"/>
            <value type="int" value="32"/>
            <value type="int" value="9"/>
            <value type="int" value="24"/>
            <value type="int" value="10"/>
            <value type="int" value="11"/>
            <value type="int" value="25"/>
            <value type="int" value="6"/>
            <value type="int" value="7"/>
            <value type="int" value="28"/>
            <value type="int" value="12"/>
            <value type="int" value="38"/>
            <value type="int" value="41"/>
            <value type="int" value="44"/>
            <value type="int" value="14"/>
            <value type="int" value="31"/>
          </property>
          <property name="enter-opacity" type="uint" value="100"/>
          <property name="leave-opacity" type="uint" value="98"/>
          <property name="border-width" type="uint" value="0"/>
          <property name="background-style" type="uint" value="0"/>
          <property name="background-rgba" type="array">
            <value type="double" value="0.60392156862745094"/>
            <value type="double" value="0.59999999999999998"/>
            <value type="double" value="0.58823529411764708"/>
            <value type="double" value="1"/>
          </property>
        </property>
        <property name="panel-2" type="empty">
          <property name="position" type="string" value="p=12;x=680;y=1055"/>
          <property name="size" type="uint" value="16"/>
          <property name="length" type="double" value="100"/>
          <property name="position-locked" type="bool" value="true"/>
          <property name="plugin-ids" type="array">
            <value type="int" value="37"/>
            <value type="int" value="4"/>
          </property>
          <property name="background-style" type="uint" value="0"/>
          <property name="background-rgba" type="array">
            <value type="double" value="0.14117647058823529"/>
            <value type="double" value="0.12156862745098039"/>
            <value type="double" value="0.19215686274509805"/>
            <value type="double" value="1"/>
          </property>
          <property name="enter-opacity" type="uint" value="100"/>
          <property name="leave-opacity" type="uint" value="100"/>
        </property>
      </property>
      <property name="plugins" type="empty">
        <property name="plugin-1" type="string" value="applicationsmenu">
          <property name="custom-menu" type="bool" value="true"/>
          <property name="button-title" type="string" value="apps"/>
        </property>
        <property name="plugin-3" type="string" value="separator">
          <property name="expand" type="bool" value="false"/>
          <property name="style" type="uint" value="2"/>
        </property>
        <property name="plugin-5" type="string" value="separator">
          <property name="style" type="uint" value="2"/>
        </property>
        <property name="plugin-6" type="string" value="systray">
          <property name="square-icons" type="bool" value="true"/>
          <property name="known-legacy-items" type="array">
            <value type="string" value="belaidžio tinklo ryšys „django" aktyvus: django (73%)"/>
            <value type="string" value="konfigūruojamas belaidis tinklo ryšys „bruh"…"/>
            <value type="string" value="belaidžio tinklo ryšys „django" aktyvus: django (76%)"/>
            <value type="string" value="belaidžio tinklo ryšys „bruh" aktyvus: bruh (85%)"/>
            <value type="string" value="belaidžio tinklo ryšys „bruh" aktyvus: bruh (78%)"/>
            <value type="string" value="belaidžio tinklo ryšys „bruh" aktyvus: bruh (84%)"/>
            <value type="string" value="belaidžio tinklo ryšys „django" aktyvus: django (75%)"/>
            <value type="string" value="belaidžio tinklo ryšys „bruh" aktyvus: bruh (62%)"/>
            <value type="string" value="belaidžio tinklo ryšys „bruh" aktyvus: bruh (69%)"/>
            <value type="string" value="belaidžio tinklo ryšys „django" aktyvus: django (65%)"/>
            <value type="string" value="užklausiamas belaidžio tinklo adresas, skirtas „django"…"/>
            <value type="string" value="belaidžio tinklo ryšys „django" aktyvus: django (68%)"/>
            <value type="string" value="networkmanager įtaisas"/>
            <value type="string" value=".blueman-tray-wrapped"/>
            <value type="string" value="udiskie"/>
            <value type="string" value="caffeine"/>
            <value type="string" value="blueman"/>
          </property>
          <property name="known-items" type="array">
            <value type="string" value="Klipper"/>
            <value type="string" value="TelegramDesktop"/>
            <value type="string" value="vlc"/>
            <value type="string" value="qBittorrent"/>
            <value type="string" value="blueman"/>
            <value type="string" value="caffeine"/>
          </property>
          <property name="icon-size" type="int" value="0"/>
          <property name="single-row" type="bool" value="true"/>
          <property name="hide-new-items" type="bool" value="false"/>
        </property>
        <property name="plugin-8" type="string" value="pulseaudio">
          <property name="enable-keyboard-shortcuts" type="bool" value="true"/>
          <property name="show-notifications" type="bool" value="true"/>
          <property name="known-players" type="string" value="firefox;org.kde.gwenview;vlc"/>
        </property>
        <property name="plugin-9" type="string" value="power-manager-plugin"/>
        <property name="plugin-10" type="string" value="notification-plugin"/>
        <property name="plugin-11" type="string" value="separator">
          <property name="style" type="uint" value="0"/>
        </property>
        <property name="plugin-12" type="string" value="clock">
          <property name="mode" type="uint" value="2"/>
          <property name="show-week-numbers" type="bool" value="false"/>
          <property name="digital-layout" type="uint" value="3"/>
          <property name="digital-time-font" type="string" value="TeX Gyre Adventor Bold 12"/>
          <property name="flash-separators" type="bool" value="false"/>
          <property name="show-inactive" type="bool" value="false"/>
          <property name="show-meridiem" type="bool" value="false"/>
          <property name="show-seconds" type="bool" value="false"/>
        </property>
        <property name="plugin-13" type="string" value="separator">
          <property name="style" type="uint" value="0"/>
        </property>
        <property name="plugin-14" type="string" value="actions">
          <property name="appearance" type="uint" value="1"/>
          <property name="button-title" type="uint" value="3"/>
          <property name="custom-title" type="string" value="OFF"/>
          <property name="items" type="array">
            <value type="string" value="+lock-screen"/>
            <value type="string" value="-switch-user"/>
            <value type="string" value="-separator"/>
            <value type="string" value="-suspend"/>
            <value type="string" value="-hibernate"/>
            <value type="string" value="-hybrid-sleep"/>
            <value type="string" value="-separator"/>
            <value type="string" value="+shutdown"/>
            <value type="string" value="+restart"/>
            <value type="string" value="-separator"/>
            <value type="string" value="+logout"/>
            <value type="string" value="-logout-dialog"/>
          </property>
          <property name="ask-confirmation" type="bool" value="false"/>
        </property>
        <property name="plugin-17" type="string" value="launcher">
          <property name="items" type="array">
            <value type="string" value="17373861051.desktop"/>
          </property>
        </property>
        <property name="plugin-18" type="string" value="launcher">
          <property name="items" type="array">
            <value type="string" value="17373861062.desktop"/>
          </property>
        </property>
        <property name="plugin-19" type="string" value="launcher">
          <property name="items" type="array">
            <value type="string" value="17373861063.desktop"/>
          </property>
        </property>
        <property name="plugin-20" type="string" value="launcher">
          <property name="items" type="array">
            <value type="string" value="17373861064.desktop"/>
          </property>
          <property name="show-label" type="bool" value="false"/>
        </property>
        <property name="plugin-22" type="string" value="directorymenu">
          <property name="base-directory" type="string" value="/home/vaidotak"/>
        </property>
        <property name="plugin-7" type="string" value="genmon">
          <property name="command" type="string" value="${scriptsDir}/wifi.sh"/>
          <property name="use-label" type="bool" value="true"/>
          <property name="text" type="string" value=" "/>
          <property name="update-period" type="int" value="250"/>
          <property name="enable-single-row" type="bool" value="false"/>
          <property name="font" type="string" value="TeX Gyre Adventor Bold 8"/>
        </property>
        <property name="plugin-23" type="string" value="genmon">
          <property name="command" type="string" value="${scriptsDir}/ram_xfce.sh"/>
          <property name="use-label" type="bool" value="true"/>
          <property name="text" type="string" value="RAM "/>
          <property name="update-period" type="int" value="250"/>
          <property name="enable-single-row" type="bool" value="true"/>
          <property name="font" type="string" value="TeX Gyre Adventor Bold 8"/>
        </property>
        <property name="plugin-24" type="string" value="separator">
          <property name="style" type="uint" value="2"/>
        </property>
        <property name="plugin-25" type="string" value="screenshooter"/>
        <property name="plugin-26" type="string" value="genmon">
          <property name="command" type="string" value="uname -r"/>
          <property name="use-label" type="bool" value="true"/>
          <property name="text" type="string" value=" kernel "/>
          <property name="update-period" type="int" value="24750"/>
          <property name="enable-single-row" type="bool" value="true"/>
          <property name="font" type="string" value="TeX Gyre Adventor Bold 8"/>
        </property>
        <property name="plugin-28" type="string" value="separator">
          <property name="style" type="uint" value="2"/>
        </property>
        <property name="plugin-29" type="string" value="separator">
          <property name="style" type="uint" value="2"/>
        </property>
        <property name="plugin-30" type="string" value="separator">
          <property name="style" type="uint" value="2"/>
        </property>
        <property name="plugin-31" type="string" value="separator">
          <property name="style" type="uint" value="0"/>
        </property>
        <property name="plugin-32" type="string" value="separator">
          <property name="style" type="uint" value="2"/>
        </property>
        <property name="plugin-33" type="string" value="separator">
          <property name="style" type="uint" value="0"/>
        </property>
        <property name="plugin-27" type="string" value="launcher">
          <property name="items" type="array">
            <value type="string" value="17399865093.desktop"/>
            <value type="string" value="17399866008.desktop"/>
            <value type="string" value="17399865042.desktop"/>
            <value type="string" value="17399865415.desktop"/>
            <value type="string" value="17399865717.desktop"/>
            <value type="string" value="17399865486.desktop"/>
            <value type="string" value="17399864851.desktop"/>
            <value type="string" value="17399905581.desktop"/>
          </property>
          <property name="move-first" type="bool" value="true"/>
          <property name="arrow-position" type="uint" value="0"/>
          <property name="show-label" type="bool" value="false"/>
        </property>
        <property name="plugin-15" type="string" value="showdesktop">
          <property name="show-on-hover" type="bool" value="true"/>
        </property>
        <property name="plugin-16" type="string" value="genmon">
          <property name="command" type="string" value="${scriptsDir}/uptime.sh"/>
          <property name="use-label" type="bool" value="true"/>
          <property name="text" type="string" value="uptime"/>
          <property name="update-period" type="int" value="1000"/>
          <property name="enable-single-row" type="bool" value="true"/>
          <property name="font" type="string" value="TeX Gyre Adventor Bold 8"/>
        </property>
        <property name="plugin-21" type="string" value="genmon">
          <property name="command" type="string" value="${scriptsDir}/sistemos_pavadinimas.sh"/>
          <property name="use-label" type="bool" value="false"/>
          <property name="text" type="string" value=" "/>
          <property name="update-period" type="int" value="5000"/>
          <property name="enable-single-row" type="bool" value="true"/>
          <property name="font" type="string" value="TeX Gyre Adventor Bold 8"/>
        </property>
        <property name="plugin-34" type="string" value="genmon">
          <property name="command" type="string" value="${scriptsDir}/free_disko_talpa.sh"/>
          <property name="use-label" type="bool" value="true"/>
          <property name="text" type="string" value=" | home   "/>
          <property name="update-period" type="int" value="1000"/>
          <property name="enable-single-row" type="bool" value="true"/>
          <property name="font" type="string" value="TeX Gyre Adventor Bold 8"/>
        </property>
        <property name="plugin-35" type="string" value="separator">
          <property name="style" type="uint" value="0"/>
          <property name="expand" type="bool" value="true"/>
        </property>
        <property name="plugin-36" type="string" value="separator">
          <property name="style" type="uint" value="2"/>
          <property name="expand" type="bool" value="false"/>
        </property>
        <property name="plugin-4" type="string" value="tasklist">
          <property name="flat-buttons" type="bool" value="true"/>
          <property name="grouping" type="bool" value="false"/>
          <property name="middle-click" type="uint" value="1"/>
        </property>
        <property name="plugin-37" type="string" value="separator">
          <property name="expand" type="bool" value="true"/>
          <property name="style" type="uint" value="0"/>
        </property>
        <property name="plugin-2" type="string" value="genmon">
          <property name="command" type="string" value="${scriptsDir}/installed.sh"/>
          <property name="use-label" type="bool" value="true"/>
          <property name="text" type="string" value=""/>
          <property name="update-period" type="int" value="30000"/>
          <property name="enable-single-row" type="bool" value="true"/>
          <property name="font" type="string" value="TeX Gyre Adventor Bold 8"/>
        </property>
        <property name="plugin-38" type="string" value="separator">
          <property name="style" type="uint" value="2"/>
        </property>
        <property name="plugin-41" type="string" value="weather">
          <property name="location" type="empty">
            <property name="name" type="string" value="Klaipėda, Klaipėdos miesto savivaldybė"/>
            <property name="latitude" type="string" value="55.712753"/>
            <property name="longitude" type="string" value="21.135047"/>
          </property>
          <property name="msl" type="int" value="6"/>
          <property name="timezone" type="string" value="Europe/Vilnius"/>
          <property name="offset" type="string" value="+02:00"/>
          <property name="cache-max-age" type="int" value="172800"/>
          <property name="power-saving" type="bool" value="true"/>
          <property name="units" type="empty">
            <property name="temperature" type="int" value="0"/>
            <property name="pressure" type="int" value="0"/>
            <property name="windspeed" type="int" value="0"/>
            <property name="precipitation" type="int" value="0"/>
            <property name="altitude" type="int" value="0"/>
            <property name="apparent-temperature" type="int" value="2"/>
          </property>
          <property name="round" type="bool" value="true"/>
          <property name="single-row" type="bool" value="true"/>
          <property name="tooltip-style" type="int" value="1"/>
          <property name="forecast" type="empty">
            <property name="layout" type="int" value="1"/>
            <property name="days" type="int" value="5"/>
          </property>
          <property name="theme-dir" type="string" value="/nix/store/p01l16nhnh2ls0lghzxmik8r44vlqsi4-xfce4-weather-plugin-0.11.3/share/xfce4/weather/icons/simplistic"/>
          <property name="scrollbox" type="empty">
            <property name="show" type="bool" value="true"/>
            <property name="animate" type="bool" value="true"/>
            <property name="lines" type="int" value="1"/>
            <property name="color" type="string" value="rgb(198,70,0)"/>
            <property name="use-color" type="bool" value="true"/>
            <property name="font" type="string" value="TeX Gyre Adventor Bold 9"/>
          </property>
        </property>
        <property name="plugin-43" type="string" value="xfce4-notes-plugin"/>
        <property name="notes" type="empty">
          <property name="global" type="empty">
            <property name="version" type="string" value="1.11.2"/>
            <property name="background-color" type="string" value="#ed7ac96680e7"/>
            <property name="font-description" type="string" value="TeX Gyre Adventor Bold 11"/>
          </property>
        </property>
        <property name="plugin-44" type="string" value="separator">
          <property name="style" type="uint" value="0"/>
        </property>
      </property>
    </channel>
  '';

in {
  # Įtraukti reikalingus paketus
  # home.packages = with pkgs; [
  #   xfce.xfce4-panel
  #   xfce.xfce4-weather-plugin
  #   xfce.xfce4-notes-plugin
  #   xfce.xfce4-genmon-plugin
  #   xfce.xfce4-screenshooter
  #   iw       # WiFi komandos
  #   vmstat   # CPU statistikai
  # ];

  # Sukurti skriptų direktoriją
  home.activation.createScriptsDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir -p ${scriptsDir}
  '';

  # Sukurti skriptus
  home.file = builtins.listToAttrs (
    builtins.map (name: {
      name = "bin/skydelio_skriptai/${name}";
      value = makeScript name (scripts.${name});
    }) (builtins.attrNames scripts)
  ) // {
    # XFCE panelės konfigūracijos failas
    ".config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml".text = xfcePanelConfig;
  };

  

  # Užtikrinti, kad visi skriptai turėtų vykdymo teises
  # home.activation.scriptPermissions = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #   $DRY_RUN_CMD chmod +x ${scriptsDir}/*.sh
  # '';
}