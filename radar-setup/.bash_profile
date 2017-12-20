for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Add tab completion for git
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

# Original settings
GRADLE_HOME=/Users/Bradley/Library/gradle-2.7
export GRADLE_HOME

export PATH=$PATH:$GRADLE_HOME/bin

# added by Anaconda2 4.1.1 installer
export PATH="/Users/Bradley/anaconda/bin:$PATH"
## End of original settings

# include Z
  . `brew --prefix`/etc/profile.d/z.sh
