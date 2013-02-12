class AccessConstraint
  def initialize()
    @ipv4 = []
    @ipv6 = []

    File.open("#{Rails.root}/lib/RemoteWhitelist.ips") do |f|
      ips = f.lines.to_a.map { |l| l.strip } .delete_if { |ip| ip.empty? or ip.start_with?('#') }
      ips.each do |ip|
        ip = NetAddr::CIDR.create(ip)
        if ip.version == 4
          @ipv4 << ip
        elsif ip.version == 6
          @ipv6 << ip
        end
      end
    end
  end

  def matches?(ip, availability, file_availability = nil)
    ip = NetAddr::CIDR.create(ip)
    restricted_access = false
    withheld_access = false

    if ip.version == 4
      restricted_access = @ipv4.map { |subnet| subnet.matches?(ip) } .include?(true)
      withheld_access = Rails.env == 'development' and ip.matches?('127.0.0.1')
    elsif ip.version == 6
      restricted_access = @ipv6.map { |subnet| subnet.matches?(ip) } .include?(true)
      withheld_access = Rails.env == 'development' and ip.matches?('::1')
    end

    result = availability.access_restriction == 'None'
    result |= availability.access_restriction == 'Restricted' and (restricted_access or withheld_access)
    result |= availability.access_restriction == 'Withheld' and withheld_access

    # This block would not be necessary except for the mixed case.
    if !file_availability.nil? and result
      result = file_availability.access_restriction == 'None'
      result |= file_availability.access_restriction == 'Restricted' and (restricted_access or withheld_access)
      result |= file_availability.access_restriction == 'Withheld' and withheld_access
    end

    return result
  end
end
