## Usage

First, symlink the cheatsheet repo into `_cheatsheets`

```
./_cheatsheets
```

Update the index:

```
make update_deps
```

Fetch preview images that need to be fetched:

```
make -B -j 4
```
