alias reload!='. ~/.zshrc'

# tmux
alias tls="tmux ls"
alias td="tmux detach"
alias tnew="new-tmux-from-dir-name"
alias tatt="tmux attach-session -t "

# Work section
alias wpc='ssh artofhuman@10.101.100.17'
alias wrails='ssh -L 3000:localhost:3000 artofhuman@10.101.100.17'
alias wrubik='ssh -L 3010:localhost:3010 artofhuman@10.101.100.17'
alias wchat='ssh -L 3001:localhost:3001 artofhuman@10.101.100.17'
alias rwpc='ssh artofhuman@ssh.railsc.ru -p 22017'
alias rwrails='ssh -L 3000:localhost:3000 artofhuman@ssh.railsc.ru -p 22017'
alias c='cd ~/code'
alias pc='cd ~/code/python'
alias rc='cd ~/code/ruby'

# ruby and rails
alias be="bundle exec"
alias bi="bundle install"
alias rk="bundle exec rake"
alias rs="rails s"
