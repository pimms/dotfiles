# Show the full path
set -U fish_prompt_pwd_dir_length 0

set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)


# Fish git prompt
#set __fish_git_prompt_showdirtystate 'yes'
#set __fish_git_prompt_showstashstate 'yes'
#set __fish_git_prompt_showuntrackedfiles 'yes'
#set __fish_git_prompt_showupstream 'yes'
#set __fish_git_prompt_color_branch yellow
#set __fish_git_prompt_color_upstream_ahead green
#set __fish_git_prompt_color_upstream_behind red

# Status Chars
#set __fish_git_prompt_char_dirtystate '⚡'
#set __fish_git_prompt_char_stagedstate '→'
#set __fish_git_prompt_char_untrackedfiles '☡'
#set __fish_git_prompt_char_stashstate '↩'
#set __fish_git_prompt_char_upstream_ahead '+'
#set __fish_git_prompt_char_upstream_behind '-'



function fish_prompt
  set last_status $status

  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal

  printf '%s ' (__fish_git_prompt)

  set_color normal
end

function docker-remove-unused
    for i in (docker images | grep -E "^<none>\s+<none>" | awk '{print $3}')
        docker rmi $i
    end
end

function docker-rm-all
    for i in (docker ps -a | awk '{print $1}')
        docker stop $i
        docker rm $i
    end
end

function json_escape
    cat $argv | python -c 'import json,sys; print(json.dumps(sys.stdin.read()))'
end

function makej
    make -j 3 $argv
end

function vscode
    "/Applications/Visual Studio Code.app/Contents/MacOS/Electron" $argv
end


# JENV
set -gx PATH $PATH $HOME/.jenv/bin
set PATH $HOME/.jenv/shims $PATH
command jenv rehash 2>/dev/null
function jenv
  set cmd $argv[1]
  set arg ""
  if test (count $argv) -gt 1
    # Great... fish first array index is ... 1 !
    set arg $argv[2..-1]
  end

  switch "$cmd"
    case enable-plugin rehash shell shell-options
        set script (jenv "sh-$cmd" "$arg")
        eval $script
    case '*'
        command jenv $cmd $arg
    end
end
