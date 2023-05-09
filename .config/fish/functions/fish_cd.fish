# Define a function to wrap around the original 'cd' command
function fish_cd
  # Call the original 'cd' command and pass the arguments
  command cd $argv

  # Update the zoxide database
  zoxide add "$(pwd)"
end

# Enable auto-completion for the wrapped 'cd' command
function _fish_cd_autocomplete
  __fish_complete_directories
end

# Attach the auto-completion function to the wrapped 'cd' command
complete -f -c cd -n "__fish_cd_autocomplete" -a "(__fish_complete_directories)" -d "Change directory using zoxide"
