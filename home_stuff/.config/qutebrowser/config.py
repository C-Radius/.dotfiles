# dracula theme configuration
import dracula.draw
config.load_autoconfig()
dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})

# detach videos to mpv
# Uncomment this to still load settings configured via autoconfig.yml
config.bind('<Ctrl-Shift-y>',
            'hint links spawn --detach mpv --force-window yes {hint-url}')
# config.load_autoconfig()

# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')

# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set('content.cookies.accept', 'all', 'devtools://*')

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value.
# Type: FormatString
config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value.
# Type: FormatString
config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://accounts.google.com/*')

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value.
# Type: FormatString
config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value.
# Type: FormatString
config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://docs.google.com/*')

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value.
# Type: FormatString
config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://drive.google.com/*')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'chrome-devtools://*')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome-devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Page to open if :open -t/-b/-w is used without URL. Use `about:blank`
# for a blank page.
# Type: FuzzyUrl
c.url.default_page = 'https://www.google.com'

# Search engines which can be used via the address bar.  Maps a search
# engine name (such as `DEFAULT`, or `ddg`) to a URL with a `{}`
# placeholder. The placeholder will be replaced by the search term, use
# `{{` and `}}` for literal `{`/`}` braces.  The following further
# placeholds are defined to configure how special characters in the
# search terms are replaced by safe characters (called 'quoting'):  *
# `{}` and `{semiquoted}` quote everything except slashes; this is the
# most   sensible choice for almost all search engines (for the search
# term   `slash/and&amp` this placeholder expands to `slash/and%26amp`).
# * `{quoted}` quotes all characters (for `slash/and&amp` this
# placeholder   expands to `slash%2Fand%26amp`). * `{unquoted}` quotes
# nothing (for `slash/and&amp` this placeholder   expands to
# `slash/and&amp`).  The search engine named `DEFAULT` is used when
# `url.auto_search` is turned on and something else than a URL was
# entered to be opened. Other search engines can be used by prepending
# the search engine name to the search term, e.g. `:open google
# qutebrowser`.
# Type: Dict
c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?hl=en&q={}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "d": "https://duckduckgo.com/?q={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "gh": "https://github.com/search?q={}",
    "rs": "https://doc.rust-lang.org/std/index.html?search={}",
    "rd": "https://www.reddit.com/search/?q={}"
}

# Page(s) to open at the start.
# Type: List of FuzzyUrl, or FuzzyUrl
c.url.start_pages = 'https://www.google.com'

# Bindings for normal mode
config.bind('Sq', 'open qute://bookmarks')
config.bind('Ss', 'open qute://settings')
config.bind('T', 'tab-focus')
config.bind('V', 'enter-mode caret ;; toggle-selection --line')
config.bind('ZQ', 'quit')
config.bind('ZZ', 'quit --save')
config.bind('[[', 'navigate prev')
config.bind(']]', 'navigate next')
config.bind('`', 'enter-mode set_mark')
config.bind('ad', 'download-cancel')
config.bind('b', 'set-cmd-text -s :quickmark-load')
config.bind('cd', 'download-clear')
config.bind('co', 'tab-only')
config.bind('d', 'tab-close')
config.bind('f', 'hint')
config.bind('g$', 'tab-focus -1')
config.bind('g0', 'tab-focus 1')
config.bind('gB', 'set-cmd-text -s :bookmark-load -t')
config.bind('gC', 'tab-clone')
config.bind('gD', 'tab-give')
config.bind('gO', 'set-cmd-text :open -t -r {url:pretty}')
config.bind('gU', 'navigate up -t')
config.bind('g^', 'tab-focus 1')
config.bind('ga', 'open -t')
config.bind('gb', 'set-cmd-text -s :bookmark-load')
config.bind('gd', 'download')
config.bind('gf', 'view-source')
config.bind('gg', 'scroll-to-perc 0')
config.bind('gi', 'hint inputs --first')
config.bind('gl', 'tab-move -')
config.bind('gm', 'tab-move')
config.bind('go', 'set-cmd-text :open {url:pretty}')
config.bind('gr', 'tab-move +')
config.bind('gt', 'set-cmd-text -s :buffer')
config.bind('gu', 'navigate up')
config.bind('h', 'scroll left')
config.bind('i', 'enter-mode insert')
config.bind('j', 'scroll down')
config.bind('k', 'scroll up')
config.bind('l', 'scroll right')
config.bind('m', 'quickmark-save')
config.bind('n', 'search-next')
config.bind('o', 'set-cmd-text -s :open')
config.bind('pP', 'open -- {primary}')
config.bind('pp', 'open -- {clipboard}')
config.bind('q', 'record-macro')
config.bind('r', 'reload')
config.bind('sf', 'save')
config.bind('sk', 'set-cmd-text -s :bind')
config.bind('sl', 'set-cmd-text -s :set -t')
config.bind('ss', 'set-cmd-text -s :set')
config.bind(
    'tIH', 'config-cycle -p -u *://*.{url:host}/* content.images ;; reload')
config.bind(
    'tIh', 'config-cycle -p -u *://{url:host}/* content.images ;; reload')
config.bind('tIu', 'config-cycle -p -u {url} content.images ;; reload')
config.bind(
    'tPH', 'config-cycle -p -u *://*.{url:host}/* content.plugins ;; reload')
config.bind(
    'tPh', 'config-cycle -p -u *://{url:host}/* content.plugins ;; reload')
config.bind('tPu', 'config-cycle -p -u {url} content.plugins ;; reload')
config.bind(
    'tSH', 'config-cycle -p -u *://*.{url:host}/* content.javascript.enabled ;; reload')
config.bind(
    'tSh', 'config-cycle -p -u *://{url:host}/* content.javascript.enabled ;; reload')
config.bind(
    'tSu', 'config-cycle -p -u {url} content.javascript.enabled ;; reload')
config.bind('th', 'back -t')
config.bind(
    'tiH', 'config-cycle -p -t -u *://*.{url:host}/* content.images ;; reload')
config.bind(
    'tih', 'config-cycle -p -t -u *://{url:host}/* content.images ;; reload')
config.bind('tiu', 'config-cycle -p -t -u {url} content.images ;; reload')
config.bind('tl', 'forward -t')
config.bind(
    'tpH', 'config-cycle -p -t -u *://*.{url:host}/* content.plugins ;; reload')
config.bind(
    'tph', 'config-cycle -p -t -u *://{url:host}/* content.plugins ;; reload')
config.bind('tpu', 'config-cycle -p -t -u {url} content.plugins ;; reload')
config.bind(
    'tsH', 'config-cycle -p -t -u *://*.{url:host}/* content.javascript.enabled ;; reload')
config.bind(
    'tsh', 'config-cycle -p -t -u *://{url:host}/* content.javascript.enabled ;; reload')
config.bind(
    'tsu', 'config-cycle -p -t -u {url} content.javascript.enabled ;; reload')
config.bind('u', 'undo')
config.bind('v', 'enter-mode caret')
config.bind('wB', 'set-cmd-text -s :bookmark-load -w')
config.bind('wO', 'set-cmd-text :open -w {url:pretty}')
config.bind('wP', 'open -w -- {primary}')
config.bind('wb', 'set-cmd-text -s :quickmark-load -w')
config.bind('wf', 'hint all window')
config.bind('wh', 'back -w')
config.bind('wi', 'inspector')
config.bind('wl', 'forward -w')
config.bind('wo', 'set-cmd-text -s :open -w')
config.bind('wp', 'open -w -- {clipboard}')
config.bind('xO', 'set-cmd-text :open -b -r {url:pretty}')
config.bind('xo', 'set-cmd-text -s :open -b')
config.bind('yD', 'yank domain -s')
config.bind('yM', 'yank inline [{title}]({url}) -s')
config.bind('yP', 'yank pretty-url -s')
config.bind('yT', 'yank title -s')
config.bind('yY', 'yank -s')
config.bind('yd', 'yank domain')
config.bind('ym', 'yank inline [{title}]({url})')
config.bind('yp', 'yank pretty-url')
config.bind('yt', 'yank title')
config.bind('yy', 'yank')
config.bind('{{', 'navigate prev -t')
config.bind('}}', 'navigate next -t')

# Bindings for caret mode
config.bind('$', 'move-to-end-of-line', mode='caret')
config.bind('0', 'move-to-start-of-line', mode='caret')
config.bind('<Ctrl+Space>', 'drop-selection', mode='caret')
config.bind('<Escape>', 'leave-mode', mode='caret')
config.bind('<Ctrl+c>', 'leave-mode', mode='caret')
config.bind('<Return>', 'yank selection', mode='caret')
config.bind('<Space>', 'toggle-selection', mode='caret')
config.bind('G', 'move-to-end-of-document', mode='caret')
config.bind('H', 'scroll left', mode='caret')
config.bind('J', 'scroll down', mode='caret')
config.bind('K', 'scroll up', mode='caret')
config.bind('L', 'scroll right', mode='caret')
config.bind('V', 'toggle-selection --line', mode='caret')
config.bind('Y', 'yank selection -s', mode='caret')
config.bind('[', 'move-to-start-of-prev-block', mode='caret')
config.bind(']', 'move-to-start-of-next-block', mode='caret')
config.bind('b', 'move-to-prev-word', mode='caret')
config.bind('c', 'enter-mode normal', mode='caret')
config.bind('e', 'move-to-end-of-word', mode='caret')
config.bind('gg', 'move-to-start-of-document', mode='caret')
config.bind('h', 'move-to-prev-char', mode='caret')
config.bind('j', 'move-to-next-line', mode='caret')
config.bind('k', 'move-to-prev-line', mode='caret')
config.bind('l', 'move-to-next-char', mode='caret')
config.bind('o', 'reverse-selection', mode='caret')
config.bind('v', 'toggle-selection', mode='caret')
config.bind('w', 'move-to-next-word', mode='caret')
config.bind('y', 'yank selection', mode='caret')
config.bind('{', 'move-to-end-of-prev-block', mode='caret')
config.bind('}', 'move-to-end-of-next-block', mode='caret')

# Bindings for command mode
config.bind('<Ctrl+c>', 'leave-mode', mode='command')
config.bind('<Alt+Backspace>', 'rl-backward-kill-word', mode='command')
config.bind('<Alt+b>', 'rl-backward-word', mode='command')
config.bind('<Alt+d>', 'rl-kill-word', mode='command')
config.bind('<Alt+f>', 'rl-forward-word', mode='command')
config.bind('<Ctrl+?>', 'rl-delete-char', mode='command')
config.bind('<Ctrl+Return>', 'command-accept --rapid', mode='command')
config.bind('<Ctrl+Shift+Tab>',
            'completion-item-focus prev-category', mode='command')
config.bind('<Ctrl+Shift+c>', 'completion-item-yank --sel', mode='command')
config.bind('<Ctrl+Tab>', 'completion-item-focus next-category', mode='command')
config.bind('<Ctrl+a>', 'rl-beginning-of-line', mode='command')
config.bind('<Ctrl+b>', 'rl-backward-char', mode='command')
#config.bind('<Ctrl+c>', 'completion-item-yank', mode='command')
config.bind('<Ctrl+d>', 'completion-item-del', mode='command')
config.bind('<Ctrl+e>', 'rl-end-of-line', mode='command')
config.bind('<Ctrl+f>', 'rl-forward-char', mode='command')
config.bind('<Ctrl+h>', 'rl-backward-delete-char', mode='command')
config.bind('<Ctrl+k>', 'rl-kill-line', mode='command')
config.bind('<Ctrl+n>', 'command-history-next', mode='command')
config.bind('<Ctrl+p>', 'command-history-prev', mode='command')
config.bind('<Ctrl+u>', 'rl-unix-line-discard', mode='command')
config.bind('<Ctrl+w>', 'rl-unix-word-rubout', mode='command')
config.bind('<Ctrl+y>', 'rl-yank', mode='command')
config.bind('<Down>', 'completion-item-focus --history next', mode='command')
config.bind('<Escape>', 'leave-mode', mode='command')
config.bind('<Return>', 'command-accept', mode='command')
config.bind('<Shift+Del>', 'completion-item-del', mode='command')
config.bind('<Shift+Tab>', 'completion-item-focus prev', mode='command')
config.bind('<Tab>', 'completion-item-focus next', mode='command')
config.bind('<Up>', 'completion-item-focus --history prev', mode='command')

# Bindings for hint mode
config.bind('<Ctrl+c>', 'leave-mode', mode='hint')
config.bind('<Ctrl+b>', 'hint all tab-bg', mode='hint')
config.bind('<Ctrl+f>', 'hint links', mode='hint')
config.bind('<Ctrl+r>', 'hint --rapid links tab-bg', mode='hint')
config.bind('<Escape>', 'leave-mode', mode='hint')
config.bind('<Return>', 'follow-hint', mode='hint')

# Bindings for insert mode
config.bind('<Ctrl+e>', 'open-editor', mode='insert')
config.bind('<Escape>', 'leave-mode', mode='insert')
config.bind('<Shift+Ins>', 'insert-text -- {primary}', mode='insert')
config.bind('<Ctrl+c>', 'leave-mode', mode='insert')
# Bindings for passthrough mode
config.bind('<Shift+Escape>', 'leave-mode', mode='passthrough')

# Bindings for prompt mode
config.bind('<Alt+Backspace>', 'rl-backward-kill-word', mode='prompt')
config.bind('<Alt+Shift+y>', 'prompt-yank --sel', mode='prompt')
config.bind('<Alt+b>', 'rl-backward-word', mode='prompt')
config.bind('<Alt+d>', 'rl-kill-word', mode='prompt')
config.bind('<Alt+f>', 'rl-forward-word', mode='prompt')
config.bind('<Alt+y>', 'prompt-yank', mode='prompt')
config.bind('<Ctrl+?>', 'rl-delete-char', mode='prompt')
config.bind('<Ctrl+a>', 'rl-beginning-of-line', mode='prompt')
config.bind('<Ctrl+b>', 'rl-backward-char', mode='prompt')
config.bind('<Ctrl+e>', 'rl-end-of-line', mode='prompt')
config.bind('<Ctrl+f>', 'rl-forward-char', mode='prompt')
config.bind('<Ctrl+h>', 'rl-backward-delete-char', mode='prompt')
config.bind('<Ctrl+k>', 'rl-kill-line', mode='prompt')
config.bind('<Ctrl+p>', 'prompt-open-download --pdfjs', mode='prompt')
config.bind('<Ctrl+u>', 'rl-unix-line-discard', mode='prompt')
config.bind('<Ctrl+w>', 'rl-unix-word-rubout', mode='prompt')
config.bind('<Ctrl+x>', 'prompt-open-download', mode='prompt')
config.bind('<Ctrl+y>', 'rl-yank', mode='prompt')
config.bind('<Down>', 'prompt-item-focus next', mode='prompt')
config.bind('<Escape>', 'leave-mode', mode='prompt')
config.bind('<Return>', 'prompt-accept', mode='prompt')
config.bind('<Shift+Tab>', 'prompt-item-focus prev', mode='prompt')
config.bind('<Tab>', 'prompt-item-focus next', mode='prompt')
config.bind('<Up>', 'prompt-item-focus prev', mode='prompt')

# Bindings for register mode
config.bind('<Escape>', 'leave-mode', mode='register')

# Bindings for yesno mode
config.bind('<Alt+Shift+y>', 'prompt-yank --sel', mode='yesno')
config.bind('<Alt+y>', 'prompt-yank', mode='yesno')
config.bind('<Escape>', 'leave-mode', mode='yesno')
config.bind('<Return>', 'prompt-accept', mode='yesno')
config.bind('N', 'prompt-accept --save no', mode='yesno')
config.bind('Y', 'prompt-accept --save yes', mode='yesno')
config.bind('n', 'prompt-accept no', mode='yesno')
config.bind('y', 'prompt-accept yes', mode='yesno')

config.source('qutewal.py')
