# Changelog

## [2.0.0] - 2026-09-28

### Fixed
- The default `/` prefix was applied twice when building request paths, so a caller path that
  already started with `/` produced a leading `//`. Faraday treats that as a protocol-relative URL
  and mangles it, yielding malformed URLs like `https://host////api/path` that some upstream APIs
  reject at the edge with a bare 403.

### Breaking Changes
- Dropped support for Ruby versions older than 3.3. Officially supported versions are Ruby 3.3, 3.4, and 4.0.
- Pinned `faraday` to `~> 2.0` (previously unbounded above `2.0`).
