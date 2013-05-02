require 'sanitize'

Sanitize::Config::RELAXED.merge!({add_attributes: {'a' => {'rel' => 'nofollow'}}})
Sanitize::Config::KEYWORDS = {elements: ['sub', 'sup', 'var', 'ruby', 'rp', 'rt']}
