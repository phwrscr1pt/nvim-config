# Reverts everything neovide-assoc-install.reg did. Per-user, no admin needed.
# Run:  powershell -ExecutionPolicy Bypass -File undo-neovide-assoc.ps1
$ErrorActionPreference = 'Continue'
$C = 'HKCU:\Software\Classes'
$removed = 0

# 1. Per-extension ProgIds
Get-ChildItem $C -ErrorAction SilentlyContinue |
  Where-Object { $_.PSChildName -like 'Neovide.*' } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force -ErrorAction SilentlyContinue; $script:removed++ }
"removed ProgIds            : $removed"

# 2. Extension default values + OpenWithProgids entries
$fixed = 0
Get-ChildItem $C -ErrorAction SilentlyContinue |
  Where-Object { $_.PSChildName -like '.*' } |
  ForEach-Object {
    $ext = $_.PSChildName
    $def = (Get-ItemProperty $_.PSPath -Name '(default)' -ErrorAction SilentlyContinue).'(default)'
    if ($def -like 'Neovide.*') {
      Remove-ItemProperty $_.PSPath -Name '(default)' -Force -ErrorAction SilentlyContinue
      $script:fixed++
    }
    $owp = Join-Path $_.PSPath 'OpenWithProgids'
    if (Test-Path $owp) {
      Get-Item $owp | Select-Object -ExpandProperty Property |
        Where-Object { $_ -like 'Neovide.*' } |
        ForEach-Object { Remove-ItemProperty $owp -Name $_ -Force -ErrorAction SilentlyContinue }
    }
  }
"cleared extension defaults : $fixed"

# 3-6. Application entry, Unknown handler, right-click verb, Default-apps registration
foreach ($k in @(
  "$C\Applications\neovide.exe",
  "$C\Unknown\shell\open",
  "$C\*\shell\NeovideOpen",
  'HKCU:\Software\Neovide'
)) {
  if (Test-Path -LiteralPath $k) { Remove-Item -LiteralPath $k -Recurse -Force -ErrorAction SilentlyContinue; "removed $k" }
}
if (Test-Path "$C\Unknown\shell") {
  Remove-ItemProperty "$C\Unknown\shell" -Name '(default)' -Force -ErrorAction SilentlyContinue
  "reset Unknown\shell default verb"
}
Remove-ItemProperty 'HKCU:\Software\RegisteredApplications' -Name 'Neovide' -Force -ErrorAction SilentlyContinue

# 7. Tell Explorer to reload associations
Add-Type -Namespace W -Name S -MemberDefinition '
[DllImport("shell32.dll")] public static extern void SHChangeNotify(int e, uint f, IntPtr a, IntPtr b);'
[W.S]::SHChangeNotify(0x08000000, 0, [IntPtr]::Zero, [IntPtr]::Zero)

""
"DONE. Note: .html .htm .svg .xml .txt .log .ps1 had a Windows UserChoice that was"
"cleared during install and cannot be restored programmatically (it is hash-signed)."
"Re-pick those in Settings > Apps > Default apps > 'Choose defaults by file type'."
