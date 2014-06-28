# Default values for the appearance of the prompt. Configure at will.
GIT_PROMPT_PREFIX="("
GIT_PROMPT_SUFFIX=")"
GIT_PROMPT_SEPARATOR="|"
GIT_PROMPT_BRANCH="${BoldCyan}"
GIT_PROMPT_STAGED="${BoldBlue}#"
GIT_PROMPT_CONFLICTS="${BoldRed}x"
GIT_PROMPT_CHANGED="${BoldYellow}+"
GIT_PROMPT_REMOTE=" "
GIT_PROMPT_UNTRACKED="${BoldWhite}…"
GIT_PROMPT_STASHED="${BoldBlue}⚑"
GIT_PROMPT_CLEAN="${BoldGreen}✔"
GIT_PROMPT_COMMAND_OK="${Green}✔ "
GIT_PROMPT_COMMAND_FAIL="${Red}✘ "

GIT_PROMPT_START_USER="${Yellow}${PathShort}${ResetColor}"
GIT_PROMPT_START_ROOT="${Yellow}${PathShort}${ResetColor}"
GIT_PROMPT_END_USER=" \n${White}${Time12a}${ResetColor} $ "
GIT_PROMPT_END_ROOT=" \n${White}${Time12a}${ResetColor} # "

# Please do not add colors to these symbols
GIT_PROMPT_SYMBOLS_AHEAD="↑·"
GIT_PROMPT_SYMBOLS_BEHIND="↓·"
GIT_PROMPT_SYMBOLS_PREHASH=":"

