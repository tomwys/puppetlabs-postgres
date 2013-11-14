# Copyright (c) 2008, Luke Kanies, luke@madstop.com
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

class postgres {
  case $operatingsystem {
      debian, ubuntu: {
          $postgresql_server = "postgresql"
          $postgresql_client = "postgresql-client"
      }
      redhat, fedora: {
          $postgresql_server = "postgresql-server"
          $postgresql_client = "postgresql"
      }
      default: {
          err("postgres module doesn't know package names for '${operatingsystem}'.")
      }
  }

  package {
    'postgresql_server':
    name => $postgresql_server,
    ensure => installed,
  }
  package {
    'postgresql_client':
    name => $postgresql_client,
    ensure => installed,
  }

    service { 'postgresql':
        ensure    => running,
        enable    => true,
        hasstatus => true,
        subscribe => [
          Package[$postgresql_server],
          Package[$postgresql_server]
        ]
    }
}
