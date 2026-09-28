# Changelog

## [2.0.0] - 2026-09-28

### Fixed
- `Vertebrae::Request#request` applied the connection's `prefix` twice when building a request path
  (once baked into `Configuration#endpoint` as the Faraday connection's base URL, again via string
  concatenation in `request`). Combined with the default `/` prefix and a caller-supplied path that
  already started with `/`, this produced a path starting with `//`, which Faraday treats as a
  protocol-relative URL and mangles, yielding malformed URLs with multiple consecutive slashes (e.g.
  `https://host////api/path`). Some upstream APIs reject these at the edge with a bare 403. Paths are
  now joined so the prefix and path always meet with exactly one slash, regardless of whether either
  side has its own leading or trailing slash.

### Breaking Changes
- Dropped support for Ruby versions older than 3.3. Officially supported versions are Ruby 3.3, 3.4, and 4.0.
- Pinned `faraday` to `~> 2.0` (previously unbounded above `2.0`).
