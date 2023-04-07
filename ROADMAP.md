# Groen Roadmap

In its early stages in its lifetime, Groen has a potential to be a powerful note taking,
organization and todo app thanks to _Norg_ file format. To achive its potential it is better to
share thoughts and roadmap for future contributions.

See also: [Neorg Mobile Application Roadmap](https://github.com/nvim-neorg/neorg/blob/main/ROADMAP.md#mobile-application)

## Considerations

### Mobile first and feel as native as possible
Self-exlplanatory. As a key feature of Flutter, iOS and Android are both supported. And they should
feel as native as possible. It can be achived in the Flutter code base. The user experience of
mobile platforms prioritized over desktop platforms. Desktop platforms will be supported but it will
be secondary. Web support is not planned for now. May be just a web Norg editor for demo purposes.

### Norg format as first class
As expected, the source of truth is the Norg files on the local filesystem. All the workspace
context should be created according to them. So, there should be listeners to filesystem that
invalidates caches and indexes in case of any external change to any workspace file. Additionally
conflicting changes must be handled without any data loss.

### Ease of using as a default text editor
Having to switch to different editor while capturing your thoughts leads to bad user experience. The
app can display and edit any text file.

### Image support
Images may carry more information than text. Norg format has file link feature that allows us to
link any file in the workspace. There is no separate link type for images yet. But they can be
linked with generic file link for now.

### Not just for power users
You most likely to have some Neovim experience. You are capable to edit your Norg files easily with
your editor and you are waiting for this app to resolve your needs. But mobile apps are open to
anyone, not just terminal nerds like us. So, any user can install the app and taking notes even
without have to know the Norg file format using the UI/UX features. Which means the app will support
both WYSIWYG and WYSINWYG style editing. They will gradually become power users when they want
comfortably. Trust the magic of Norg.

### Not altering the files unnecesarily
Displaying a plain text file format in a mobile application brings a challenge of the altering the
files in realtime without changing _too much_. The app have to be capable of editing as either
WYSIWYG and WYSINWYG. When the _what you see is not what you get_ editing active, the changes in the
UI content have to be interpreted to the Norg format. This interpretation should not format whole
file. Because of in the Norg format whitespaces are not that important, every Neorg user can have
different styling choices. The changes in UI have to change the Norg file in a scope that as small
as possible.

### Indexing using SQLite
Note collections can contain massive number of files. It may be impossible to search, link
autocomplete and refactor fast. There have to be indexes. Neovim can make use of SQLite database
using [SQLite plugin](https://github.com/kkharji/SQLite.lua). So, the database choice is SQLite to
allow future integrations with Neovim and Neorg. SQLite has full text search capabilities with
[FTS5](https://www.sqlite.org/fts5.html) extension. Indexing provides us fast linking, backlinking,
tagging, searching and refactoring capabilities.

### Extensive search based usage
Recalling the thoughts is crucial. With a workspace that have hundreds of notes, file-explorer or
tree like UI elements get less effective while navigating between notes. Searching fast and easy is
the key of navigation at some point. With the help of the indexes and caches, notes can be searched
by their content, tags, ids (zettel), workspace and filename. The list of searchable elements may
grow in future. Search input accepts a simple query to get what to search but it is not necessary.
If the input has not special query key, results will still include tags etc. They will just be
displayed in default order/priority.

### Plugin system using Dart FFI
Dart can run external executables with FFI. This feature can be used for a plugin system that
accepts any programming language that supports FFI (Rust, Go, C, Python). Some features like
calendar and TODO may provided as a  New parsers for different file formats may provided as
offically supported plugins that can be disabled. In that way attraction to the features can be
tracked without compromising any individual privacy. The FFI system may not appropriate for security
concerns. This topic needs a proper discussion, research and POC.

## Versions

[_semver_](https://semver.org/) versioning will be used.

### Version 0.1.0 - MVP Release
Initial release aims to display and edit Norg files in a local workspace, simple usages of links,
some UI functionality for non-code usage.

1. [x] Implement a level 1 parser in pure Dart
2. [x] Display the parsed content in a mock editor
3. [x] Implement a simple edit-parse-display loop
4. [ ] Implement a level 2 parser
5. [ ] Externalize the Norg parser as a flutter/dart library
9. [ ] Implement toggle-able autosave
6. [ ] Choose an appropriate editor library
7. [ ] Implement directing `{:link:}` link format without db or cache
8. [ ] Implement a level 3 parser
9. [ ] Implement a proper design

