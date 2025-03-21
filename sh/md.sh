#!/usr/bin/env bash
# Description: Tai Bash scenarijus, pavadintas Atsisiuntimų aplanko organizatorius. Jis automatiškai rūšiuoja failus iš Atsisiuntimų aplanko į atitinkamus katalogus pagal jų tipą. Pradžioje, šį scenarijų pasidariau, kad iškeltų .md failus į Obsidian notes, bet vėliau supratęs, kaip tai patogu, patobulinau scenarijų ir dabar surūšiuoja daugybę kitų failų tipų, dažnai sutinkamų Atsisiuntimų aplanke.
# URL: https://funkcijos.wordpress.com/2024/05/13/atsisiuntimu-aplanko-organizatorius-tvarkinga-failu-sistema-vienu-paspaudimu/

src_dir="$HOME/Atsiuntimai/"
dst_dir="$HOME/Obsidian/notes/"
docs_dir="$HOME/Dokumentai/"
music_dir="$HOME/Muzika/"
video_dir="$HOME/Video/"
images_dir="$HOME/Paveikslėliai/"
zip_dir="$HOME/Archyvuoti/"
script_dir="$HOME/bin/"

if ! ls "$src_dir"/*.md >/dev/null 2>&1; then
  echo "Nėra .md failų Atsisiuntimų kataloge"
else
  for file in "$src_dir"*.md; do
    filename="${file%%.*}"
    dst_file="${dst_dir}$(basename "$filename").md"
    if [ -f "$dst_file" ]; then
      echo "Failas $file jau egzistuoja kataloge $dst_dir"
    else
      mv "$file" "$dst_file"
      echo "Perkeltas failas $file į katalogą $dst_dir"
    fi
  done
fi

move_files() {
  local extensions=("$@")
  local target_dir="${extensions[-1]}"
  unset 'extensions[${#extensions[@]}-1]'

  for ext in "${extensions[@]}"; do
    shopt -s nullglob
    files=("$src_dir"/*.$ext)
    shopt -u nullglob
    if [ ${#files[@]} -eq 0 ]; then
      echo "Nėra .$ext failų Atsisiuntimų kataloge"
    else
      for file in "${files[@]}"; do
        if [ -f "$file" ]; then
          mv "$file" "$target_dir"
          echo "Perkeltas failas $file į katalogą $target_dir"
        fi
      done
    fi
  done
}



move_files "PDF" "pdf" "rtf" "xlsx" "doc" "docx" "epub" "txt" "nix" "odt" "$docs_dir"
move_files "mp3" "m4a" "m4b" "$music_dir"
move_files "avi" "mpeg" "mp4" "MP4" "mkv" "MOV" "mov" "$video_dir"
move_files "jpg" "JPG" "jpeg" "png" "gif" "heif" "webp" "svg" "$images_dir"
move_files "zip" "tar" "tar.gz" "gzip" "bzip2" "gpg" "xz" "7z" "$zip_dir"
move_files "sh" "yaml" "json" "conf" "list" "$script_dir"
