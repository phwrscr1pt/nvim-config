# Generates neovide-assoc-install.reg - per-user file associations -> Neovide.
# PowerShell is used because backslashes are not escape characters here.
$ErrorActionPreference = 'Stop'
$OUT = Join-Path $PSScriptRoot 'neovide-assoc-install.reg'

$exePlain = (Get-Command neovide.exe -ErrorAction SilentlyContinue).Source
if (-not $exePlain) { $exePlain = 'C:\Program Files\Neovide\neovide.exe' }
if (-not (Test-Path $exePlain)) { throw "neovide.exe not found - install it or edit $exePlain" }
$exeReg   = $exePlain -replace '\\', '\\'          # .reg needs doubled backslashes
$openCmd  = '@="\"' + $exeReg + '\" \"%1\""'
$iconVal  = '"' + $exeReg + ',0"'

$CODE = @('.lua','.py','.pyw','.pyi','.js','.mjs','.cjs','.ts','.mts','.cts','.tsx','.jsx',
  '.json','.jsonc','.json5','.toml','.yml','.yaml','.sh','.bash','.zsh','.fish',
  '.ps1','.psm1','.psd1','.c','.h','.cpp','.hpp','.cc','.cxx','.hh','.go','.rs','.rb',
  '.php','.java','.kt','.kts','.cs','.fs','.sql','.vim','.ini','.conf','.cfg','.env',
  '.properties','.gitignore','.gitattributes','.gitconfig','.gitmodules','.editorconfig',
  '.dockerignore','.npmrc','.nvmrc','.prettierrc','.eslintrc','.babelrc','.r','.pl','.pm',
  '.swift','.scala','.clj','.cljs','.ex','.exs','.erl','.hs','.ml','.zig','.nim','.dart',
  '.gradle','.tf','.tfvars','.nix','.mk','.cmake','.diff','.patch','.bashrc','.zshrc',
  '.profile','.inputrc')
$TEXT = @('.md','.markdown','.mdx','.mkd','.rst','.adoc','.asciidoc','.txt','.log','.text','.csv','.tsv','.nfo')
$WEB  = @('.html','.htm','.xhtml','.css','.scss','.sass','.less','.xml','.svg','.vue','.svelte','.astro','.xsl','.xslt')
$ALL  = $CODE + $TEXT + $WEB

# Extensions that already carry a hash-protected UserChoice -> must be cleared.
$CLEAR = @('.html','.htm','.svg','.xml','.txt','.log','.ps1')

$names = @{
  '.lua'='Lua Source File'; '.py'='Python Source File'; '.pyw'='Python Source File'; '.pyi'='Python Stub File'
  '.js'='JavaScript File'; '.mjs'='JavaScript Module'; '.cjs'='CommonJS Module'
  '.ts'='TypeScript File'; '.mts'='TypeScript Module'; '.cts'='TypeScript Module'
  '.tsx'='React TypeScript File'; '.jsx'='React JavaScript File'
  '.json'='JSON File'; '.jsonc'='JSON File'; '.json5'='JSON File'
  '.toml'='TOML File'; '.yml'='YAML File'; '.yaml'='YAML File'
  '.sh'='Shell Script'; '.bash'='Shell Script'; '.zsh'='Shell Script'; '.fish'='Shell Script'
  '.ps1'='PowerShell Script'; '.psm1'='PowerShell Module'; '.psd1'='PowerShell Manifest'
  '.c'='C Source File'; '.h'='C Header File'; '.cpp'='C++ Source File'; '.hpp'='C++ Header File'
  '.cc'='C++ Source File'; '.cxx'='C++ Source File'; '.hh'='C++ Header File'
  '.go'='Go Source File'; '.rs'='Rust Source File'; '.rb'='Ruby Source File'; '.php'='PHP Source File'
  '.java'='Java Source File'; '.kt'='Kotlin Source File'; '.kts'='Kotlin Script'; '.cs'='C# Source File'
  '.fs'='F# Source File'; '.sql'='SQL Script'; '.vim'='Vim Script'
  '.md'='Markdown Document'; '.markdown'='Markdown Document'; '.mdx'='MDX Document'; '.mkd'='Markdown Document'
  '.txt'='Text Document'; '.text'='Text Document'; '.log'='Log File'; '.csv'='CSV File'; '.tsv'='TSV File'
  '.html'='HTML Document'; '.htm'='HTML Document'; '.xhtml'='XHTML Document'
  '.css'='Stylesheet'; '.scss'='Sass Stylesheet'; '.sass'='Sass Stylesheet'; '.less'='Less Stylesheet'
  '.xml'='XML Document'; '.xsl'='XSL Stylesheet'; '.xslt'='XSL Stylesheet'; '.svg'='SVG Image'
  '.ini'='Configuration File'; '.conf'='Configuration File'; '.cfg'='Configuration File'
  '.env'='Environment File'; '.properties'='Properties File'
  '.diff'='Patch File'; '.patch'='Patch File'
}
function Get-Friendly([string]$e) {
  if ($names.ContainsKey($e)) { return $names[$e] }
  return ($e.TrimStart('.').ToUpper() + ' File')
}

$L = New-Object System.Collections.Generic.List[string]
$L.Add('Windows Registry Editor Version 5.00'); $L.Add('')
$L.Add('; ============================================================')
$L.Add('; Neovide as the default editor for code/text files (per-user)')
$L.Add('; No admin rights needed. Undo with undo-neovide-assoc.ps1')
$L.Add('; ============================================================'); $L.Add('')

$L.Add('; --- 1. The application itself (Open-with dialog entry) ---')
$L.Add('[HKEY_CURRENT_USER\Software\Classes\Applications\neovide.exe]')
$L.Add('"FriendlyAppName"="Neovide"'); $L.Add('')
$L.Add('[HKEY_CURRENT_USER\Software\Classes\Applications\neovide.exe\shell\open\command]')
$L.Add($openCmd); $L.Add('')
$L.Add('[HKEY_CURRENT_USER\Software\Classes\Applications\neovide.exe\SupportedTypes]')
foreach ($e in $ALL) { $L.Add('"' + $e + '"=""') }
$L.Add('')

$L.Add('; --- 2. Per-extension ProgIds (keeps the Explorer "Type" column meaningful) ---')
foreach ($e in $ALL) {
  $f = Get-Friendly $e
  $L.Add("[HKEY_CURRENT_USER\Software\Classes\Neovide$e]")
  $L.Add('@="' + $f + '"')
  $L.Add('"FriendlyTypeName"="' + $f + '"'); $L.Add('')
  $L.Add("[HKEY_CURRENT_USER\Software\Classes\Neovide$e\DefaultIcon]")
  $L.Add('@=' + $iconVal); $L.Add('')
  $L.Add("[HKEY_CURRENT_USER\Software\Classes\Neovide$e\shell\open\command]")
  $L.Add($openCmd); $L.Add('')
}

$L.Add('; --- 3. Point each extension at its ProgId + list it in Open-with ---')
foreach ($e in $ALL) {
  $L.Add("[HKEY_CURRENT_USER\Software\Classes\$e]")
  $L.Add('@="Neovide' + $e + '"'); $L.Add('')
  $L.Add("[HKEY_CURRENT_USER\Software\Classes\$e\OpenWithProgids]")
  $L.Add('"Neovide' + $e + '"=""'); $L.Add('')
}

$L.Add('; --- 4. Clear the hash-protected UserChoice where one already exists ---')
$fe = 'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts'
foreach ($e in $CLEAR) {
  $L.Add("[-$fe\$e\UserChoice]")
  $L.Add("[-$fe\$e\UserChoiceLatest]")
}
$L.Add('')

$L.Add('; --- 5. Unknown / extensionless files (Dockerfile, Makefile, LICENSE) ---')
$L.Add('[HKEY_CURRENT_USER\Software\Classes\Unknown\shell]')
$L.Add('@="open"'); $L.Add('')
$L.Add('[HKEY_CURRENT_USER\Software\Classes\Unknown\shell\open]')
$L.Add('@="Open with Neovide"')
$L.Add('"Icon"=' + $iconVal); $L.Add('')
$L.Add('[HKEY_CURRENT_USER\Software\Classes\Unknown\shell\open\command]')
$L.Add($openCmd); $L.Add('')

$L.Add('; --- 6. Right-click "Open with Neovide" on every file ---')
$L.Add('[HKEY_CURRENT_USER\Software\Classes\*\shell\NeovideOpen]')
$L.Add('@="Open with Neovide"')
$L.Add('"Icon"=' + $iconVal); $L.Add('')
$L.Add('[HKEY_CURRENT_USER\Software\Classes\*\shell\NeovideOpen\command]')
$L.Add($openCmd); $L.Add('')

$L.Add('; --- 7. Register in Settings > Default apps ---')
$L.Add('[HKEY_CURRENT_USER\Software\Neovide\Capabilities]')
$L.Add('"ApplicationName"="Neovide"')
$L.Add('"ApplicationDescription"="No Nonsense Neovim GUI"'); $L.Add('')
$L.Add('[HKEY_CURRENT_USER\Software\Neovide\Capabilities\FileAssociations]')
foreach ($e in $ALL) { $L.Add('"' + $e + '"="Neovide' + $e + '"') }
$L.Add('')
$L.Add('[HKEY_CURRENT_USER\Software\RegisteredApplications]')
$L.Add('"Neovide"="Software\\Neovide\\Capabilities"')
$L.Add('')

Set-Content -LiteralPath $OUT -Value $L -Encoding ascii
"wrote $OUT"
"extensions : $($ALL.Count)"
"lines      : $($L.Count)"
"userchoice cleared for: $($CLEAR -join ' ')"


