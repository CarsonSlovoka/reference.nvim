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
  local ft="${1:-sh}"

  # 避免特殊字元破壞 remote-expr 表達式
  case "$ft" in
    *[!a-zA-Z0-9_.-]*)
      printf 'Invalid filetype: %s\n' "$ft" >&2
      return 1
      ;;
  esac

  if [ -z "${NVIM:-}" ]; then
    case "$ft" in
      sh) ft=bash ;;
      text) ft=txt ;;
    esac

    bat -l "$ft" -P
    return
  fi

  local payload
  payload=$(base64 | tr -d '\n') || return

  nvim --server "$NVIM" \
    --remote-expr "luaeval('require(\"reference\").open(_A[1], _A[2])', ['$payload', '$ft'])" \
    >/dev/null
}
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

# 範例3 指定filetype (預設為sh)
cat <<\lua | nvimRef lua
vim.keymap.set("n", "<leader>x", function()
  print("Hello World")
end)
lua
```
