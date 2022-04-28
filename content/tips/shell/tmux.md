---
title: Tmux configuration
date: 2022-04-28
description: How I setup my tmux for client work
---

.tmux.conf

    set -g mouse on

    unbind-key -T copy-mode-vi MouseDragEnd1Pane

    set -sg escape-time 0

    set-window-option -g mode-keys vi

    bind-key p command-prompt -p 'save history to filename:' -I '~/tmux.history' 'capture-pane -JS -32768 ; save-buffer %1 ; delete-buffer'

    set-window-option -g automatic-rename on
    set-option -g set-titles on

    set -g status-bg color160
    set -g status-fg white

    set-option -g default-terminal "screen-256color"
    set-option -g focus-events on
