name=k9s
version=0.26.6
release=1
desc='TUI for managing Kubernetes clusters and pods'
homepage='https://github.com/derailed/k9s'
architectures=('amd64')
license=('APACHE')
provides=('k9s')

sources_amd64=("https://github.com/derailed/k9s/releases/download/v0.26.6/k9s_Linux_x86_64.tar.gz")
checksums_amd64=('7abe5d029a29d8108ab405889ea2a8f731765d79333920ac7c2942c6e16d1bd4')

package() {
  ./k9s completion bash | install -Dm644 /dev/stdin "$pkgdir/usr/share/bash-completion/completion/k9s"
  ./k9s completion zsh | install -Dm644 /dev/stdin "$pkgdir/usr/share/zsh/site-functions/_k9s"
  ./k9s completion fish | install -Dm644 /dev/stdin "$pkgdir/usr/share/fish/vendor_completions.d/k9s.fish"
  install -Dm755 "./$name" "$pkgdir/usr/bin/$name"
  install -Dm644 ./LICENSE "$pkgdir/usr/share/licenses/$name/LICENSE"
}
