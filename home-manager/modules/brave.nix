{
  config,
  pkgs,
  ...
}:

{
  programs.brave = {
    enable = true;
    extensions = [
      # Brave Bookmarker
      "nlpldafmelhdbfadodfpmpnjoblpoeng"

      # Enable Right Click & Copy
      "pkoccklolohdacbfooifnpebakpbeipc"

      # Checker Plus for Gmail
      "oeopbcgkkoapgobdbedcemjljbihmemj"

      # Dark Reader
      "eimadpbcbfnmbkopoojfekhnkhdbieeh"

      # DeepL AI Translator
      "cofdbpoegempjloogbagkncekinflcnj"

      # Feedly Notifier
      "egikgfbhipinieabdmcpigejkaomgjgb"

      # Home - New Tab Page with ChatGPT
      "ehhkfhegcenpfoanmgfpfhnmdmflkbgk"

      # I still don't care about cookies
      "edibdbjcniadpccecjdfdjjppcpchdlm"

      # KeePassXC-Browser
      "oboonakemofpalcgghocfoadofidjkkk"

      # Obsidian Web Clipper
      "cnjifjpddelmedmihgijeibhnjfabmlf"

      # Save to Pocket
      "calnfcidhlhdmmmnicdpddbmmjmfohem"
    ];
  };
}