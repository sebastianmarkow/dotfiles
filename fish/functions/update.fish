function update
    echo -s (set_color red) "Updating OSX" (set_color normal)
    softwareupdate --install --all
    echo -s (set_color red) "Updating Homebrew" (set_color normal)
    brew update --all; and brew upgrade --all
end
