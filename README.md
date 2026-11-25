# reference.nvim

如果想要寫一些參考用的模板, 之後想要修改當中的內容

就可以使用此插件


## Install

```lua
vim.pack.add({ "https://github.com/CarsonSlovoka/reference.nvim" })
```

接著在`~/.zshrc`中加入: `nvimRef()`的內容

```sh
# 也可以考慮寫到 ~/.bashrc
cat >> ~/.zshrc <<'sh'
function nvimRef() {
  if [ -z "${NVIM:-}" ]; then
    bat -l bash -P
    return
  fi

  local payload
  payload=$(base64 | tr -d '\n') || return

  nvim --server "$NVIM" \
    --remote-expr "luaeval('require(\"reference\").open(_A)', '$payload')" \
    >/dev/null
}
sh
```


## Usage

在nvim的終端機:

```sh
# 範例1
curl --help all | nvimRef

# 範例2
cat <<-\sh | nvimRef
    gh repo create __Project__ --private --source=. --push
    gh repo create __Project__ --public  --source=. --push
sh

```
