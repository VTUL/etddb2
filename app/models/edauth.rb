# Simple ED-Auth library; requires ruby-ldap built
# against OpenLDAP and OpenSSL.
# Sam Stephenson <sams@vt.edu> 2004-06-17
# Modified a bit by Brad Tilley < rtilley@vt.edu> 2006-12-13

require 'ldap'

class NotAuthenticatedError < Exception
end

class EdAuth
    HOST, PORT = 'authn.directory.vt.edu', 389
    DN, FILTER = 'ou=People,dc=vt,dc=edu', '(uupid=%s)'

    def initialize(pid, pass)
        @ldap = LDAP::SSLConn.new(HOST, PORT, true)
        @authenticated = false
        @pid, @pass = pid, pass
        @dn, @filter = DN, format(FILTER, pid)

        @authenticity = false
        @pri_affil, @affil = nil, nil
    end

    def authenticate
        return @authenticity if @authenticated
        begin
            @ldap.search(@dn, LDAP::LDAP_SCOPE_ONELEVEL,
                        @filter) {|c| @dn = c.get_dn}
            @ldap.bind(@dn, @pass)
            @authenticity = true
        rescue LDAP::ResultError
            @authenticity = false
        ensure
            @authenticated = true
        end
        @authenticity
    end

    def get_primary_affiliation
        query if @pri_affil.nil?
    puts @pri_affil
        @pri_affil
    end

    def get_affiliations
        query if @affil.nil?
    puts @affil
        @affil
    end

    def close
        begin
            @ldap.unbind
        rescue LDAP::InvalidDataError
        end
    end

    private
    def query
        raise NotAuthenticatedError unless @authenticated and
        @authenticity
        @ldap.search(@dn, LDAP::LDAP_SCOPE_SUBTREE, @filter,
                    ['eduPersonPrimaryAffiliation',
                    'eduPersonAffiliation']) do |entry|
                    @pri_affil =
                    entry.get_values('edupersonprimaryaffiliation').shift
                    @affil = entry.get_values('edupersonaffiliation')
        end
    end
end

