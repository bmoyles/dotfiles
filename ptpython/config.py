from __future__ import unicode_literals
from prompt_toolkit.styles import Style
from ptpython.layout import CompletionVisualisation


__all__ = (
    'configure',
)

BACKGROUND = "#1d1f21"
CURRENT_LINE = "#282a2e"
SELECTION = "#373b41"
FOREGROUND = "#c5c8c6"
COMMENT = "#969896"
RED = "#cc6666"
ORANGE = "#de935f"
YELLOW = "#f0c674"
GREEN = "#b5bd68"
AQUA = "#8abeb7"
BLUE = "#81a2be"
PURPLE = "#b294bb"
_tomorrow_night_style = {
    # No corresponding class for the following:
    'pygments.text':                      FOREGROUND,  # class:  ''
    'pygments.whitespace':                "",          # class: 'w'
    'pygments.error':                     RED,         # class: 'err'
    'pygments.other':                     "",          # class 'x'

    'pygments.comment':                   COMMENT,   # class: 'c'
    'pygments.comment.multiline':         "",        # class: 'cm'
    'pygments.comment.preproc':           "",        # class: 'cp'
    'pygments.comment.single':            "",        # class: 'c1'
    'pygments.comment.special':           "",        # class: 'cs'

    'pygments.keyword':                   PURPLE,    # class: 'k'
    'pygments.keyword.constant':          "",        # class: 'kc'
    'pygments.keyword.declaration':       "",        # class: 'kd'
    'pygments.keyword.namespace':         AQUA,      # class: 'kn'
    'pygments.keyword.pseudo':            "",        # class: 'kp'
    'pygments.keyword.reserved':          "",        # class: 'kr'
    'pygments.keyword.type':              YELLOW,    # class: 'kt'

    'pygments.operator':                  AQUA,      # class: 'o'
    'pygments.operator.word':             "",        # class: 'ow' - like keywords

    'pygments.punctuation':               FOREGROUND,  # class: 'p'

    'pygments.name':                      FOREGROUND,  # class: 'n'
    'pygments.name.attribute':            BLUE,        # class: 'na' - to be revised
    'pygments.name.builtin':              "",          # class: 'nb'
    'pygments.name.builtin.pseudo':       "",          # class: 'bp'
    'pygments.name.class':                YELLOW,      # class: 'nc' - to be revised
    'pygments.name.constant':             RED,         # class: 'no' - to be revised
    'pygments.name.decorator':            AQUA,        # class: 'nd' - to be revised
    'pygments.name.entity':               "",          # class: 'ni'
    'pygments.name.exception':            RED,         # class: 'ne'
    'pygments.name.function':             BLUE,        # class: 'nf'
    'pygments.name.property':             "",          # class: 'py'
    'pygments.name.label':                "",          # class: 'nl'
    'pygments.name.namespace':            YELLOW,      # class: 'nn' - to be revised
    'pygments.name.other':                BLUE,        # class: 'nx'
    'pygments.name.tag':                  AQUA,        # class: 'nt' - like a keyword
    'pygments.name.variable':             RED,         # class: 'nv' - to be revised
    'pygments.name.variable.class':       "",          # class: 'vc' - to be revised
    'pygments.name.variable.global':      "",          # class: 'vg' - to be revised
    'pygments.name.variable.instance':    "",          # class: 'vi' - to be revised

    'pygments.number':                    ORANGE,    # class: 'm'
    'pygments.number.float':              "",        # class: 'mf'
    'pygments.number.hex':                "",        # class: 'mh'
    'pygments.number.integer':            "",        # class: 'mi'
    'pygments.number.integer.long':       "",        # class: 'il'
    'pygments.number.oct':                "",        # class: 'mo'

    'pygments.literal':                   ORANGE,    # class: 'l'
    'pygments.literal.date':              GREEN,     # class: 'ld'

    'pygments.string':                    GREEN,       # class: 's'
    'pygments.string.backtick':           "",          # class: 'sb'
    'pygments.string.char':               FOREGROUND,  # class: 'sc'
    'pygments.string.doc':                COMMENT,     # class: 'sd' - like a comment
    'pygments.string.double':             "",          # class: 's2'
    'pygments.string.escape':             ORANGE,      # class: 'se'
    'pygments.string.heredoc':            "",          # class: 'sh'
    'pygments.string.interpol':           ORANGE,      # class: 'si'
    'pygments.string.other':              "",          # class: 'sx'
    'pygments.string.regex':              "",          # class: 'sr'
    'pygments.string.single':             "",          # class: 's1'
    'pygments.string.symbol':             "",          # class: 'ss'

    'pygments.generic':                   "",                    # class: 'g'
    'pygments.generic.deleted':           RED,                   # class: 'gd',
    'pygments.generic.emph':              "italic",              # class: 'ge'
    'pygments.generic.error':             "",                    # class: 'gr'
    'pygments.generic.heading':           "bold " + FOREGROUND,  # class: 'gh'
    'pygments.generic.inserted':          GREEN,                 # class: 'gi'
    'pygments.generic.output':            "",                    # class: 'go'
    'pygments.generic.prompt':            "bold " + COMMENT,     # class: 'gp'
    'pygments.generic.strong':            "bold",                # class: 'gs'
    'pygments.generic.subheading':        "bold " + AQUA,        # class: 'gu'
    'pygments.generic.traceback':         "",                    # class: 'gt'
}


def configure(repl):
    """
    Configuration method. This is called during the start-up of ptpython.

    :param repl: `PythonRepl` instance.
    """
    # Show function signature (bool).
    repl.show_signature = True

    # Show docstring (bool).
    repl.show_docstring = True

    # Show the "[Meta+Enter] Execute" message when pressing [Enter] only
    # inserts a newline instead of executing the code.
    repl.show_meta_enter_message = True

    # Show completions. (NONE, POP_UP, MULTI_COLUMN or TOOLBAR)
    repl.completion_visualisation = CompletionVisualisation.POP_UP

    # When CompletionVisualisation.POP_UP has been chosen, use this
    # scroll_offset in the completion menu.
    repl.completion_menu_scroll_offset = 0

    # Show line numbers (when the input contains multiple lines.)
    repl.show_line_numbers = True

    # Show status bar.
    repl.show_status_bar = True

    # When the sidebar is visible, also show the help text.
    repl.show_sidebar_help = True

    # Highlight matching parethesis.
    repl.highlight_matching_parenthesis = True

    # Line wrapping. (Instead of horizontal scrolling.)
    repl.wrap_lines = True

    # Mouse support.
    repl.enable_mouse_support = False

    # Complete while typing. (Don't require tab before the
    # completion menu is shown.)
    repl.complete_while_typing = True

    # Vi mode.
    repl.vi_mode = False

    # Paste mode. (When True, don't insert whitespace after new line.)
    repl.paste_mode = False

    # Use the classic prompt. (Display '>>>' instead of 'In [1]'.)
    repl.prompt_style = 'classic'  # 'classic' or 'ipython'

    # Don't insert a blank line after the output.
    repl.insert_blank_line_after_output = False

    # History Search.
    # When True, going back in history will filter the history on the records
    # starting with the current input. (Like readline.)
    # Note: When enable, please disable the `complete_while_typing` option.
    #       otherwise, when there is a completion available, the arrows will
    #       browse through the available completions instead of the history.
    repl.enable_history_search = False

    # Enable auto suggestions. (Pressing right arrow will complete the input,
    # based on the history.)
    repl.enable_auto_suggest = True

    # Enable open-in-editor. Pressing C-X C-E in emacs mode or 'v' in
    # Vi navigation mode will open the input in the current editor.
    repl.enable_open_in_editor = True

    # Enable system prompt. Pressing meta-! will display the system prompt.
    # Also enables Control-Z suspend.
    repl.enable_system_bindings = True

    # Ask for confirmation on exit.
    repl.confirm_exit = False

    # Enable input validation. (Don't try to execute when the input contains
    # syntax errors.)
    repl.enable_input_validation = True

    # Set color depth (keep in mind that not all terminals support true color).
    # repl.color_depth = 'DEPTH_1_BIT'  # Monochrome.
    # repl.color_depth = 'DEPTH_4_BIT'  # ANSI colors only.
    # repl.color_depth = 'DEPTH_8_BIT'  # The default, 256 colors.
    repl.color_depth = 'DEPTH_24_BIT'  # True color.

    # Syntax.
    repl.enable_syntax_highlighting = True

    # Use this colorscheme for the code.
    # repl.install_code_colorscheme('tomorrow-night', _tomorrow_night_style)
    repl.code_styles['tomorrow-night'] = Style.from_dict(_tomorrow_night_style)
    repl.use_code_colorscheme('tomorrow-night')
