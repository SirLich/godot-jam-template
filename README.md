# Godot Jam Template

A template for Game Jams. Not all jams allow templates, so do your homework!

The code/structure of the project is yours to use under the MIT license. The assets themselves should be removed, as you create suitable replacements. I have the rights to these assets -you don't.

This template was last updated for Godot 4.6

## Stability Warning

This is my own template, for my own jams and small projects. Everything here is subject to change.

## Theme System 

The template ships with a few libraries to help you quickly theme your games UI.
- StyleboxFancy: This allows you to create styleboxes that mix textures and colors/outlines.
- QuickTheme: This allows you to generate the full theme from a few exported members.

## Handling Assets

This template has prototype assets, contained within `res://prototype_assets`.
If you create new assets with the same names, you can import them here to replace all usages.
Otherwise, you can right-click and `View Owners`, and manually replace where needed.

Demo scenes such as `main_menu.tscn` rely on these prototype assets. Of course you can also just edit these scenes directly, with your desired changes.

## Game Settings

The template comes with a settings file `res://jam_settings.tres` which other systems rely on. Changing values here is the best way to quickly set up your game (e.g., changing main menu music).

## Features

- Configured audio bus
- Settings page, with audio settings
- Scene transition system
- UI theme in place, ready for configuration
- Credits system, which reads from a markdown file

## Plugins / Additions

[Godot Sound Manager](https://github.com/nathanhoad/godot_sound_manager)
[Markdown Label](https://github.com/daenvil/MarkdownLabel)

## Hyrax

This plugin manages dependencies via [Hyrax](https://github.com/SirLich/hyrax). Dependencies have
been inlined (checked into version control), but Hyrax can be used to update them if desired. See `hyrax.toml`.
