# .emacs.d
Personal Emacs Settings

Electric C Characters
---------------------
In C mode and related modes, certain printing characters are electric—in addition to inserting themselves, they also reindent the current line, and optionally also insert newlines. The “electric” characters are {, }, :, #, ;, ,, <, >, /, *, (, and ).

You might find electric indentation inconvenient if you are editing chaotically indented code. If you are new to CC Mode, you might find it disconcerting. You can toggle electric action with the command C-c C-l; when it is enabled, ‘/l’ appears in the mode line after the mode name:

C-c C-l

    Toggle electric action (c-toggle-electric-state). With a positive prefix argument, this command enables electric action, with a negative one it disables it. 

Electric characters insert newlines only when, in addition to the electric state, the auto-newline feature is enabled (indicated by ‘/la’ in the mode line after the mode name). You can turn this feature on or off with the command C-c C-a:

C-c C-a

    Toggle the auto-newline feature (c-toggle-auto-newline). With a prefix argument, this command turns the auto-newline feature on if the argument is positive, and off if it is negative. 

Usually the CC Mode style configures the exact circumstances in which Emacs inserts auto-newlines. You can also configure this directly. See Custom Auto-newlines in The CC Mode Manual. 
