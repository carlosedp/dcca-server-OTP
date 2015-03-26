%% -------------------------------------------------------------------
%% This is a generated file.
%% -------------------------------------------------------------------

%%
%% Copyright (c) Ericsson AB. All rights reserved.
%%
%% The information in this document is the property of Ericsson.
%%
%% Except as specifically authorized in writing by Ericsson, the
%% receiver of this document shall keep the information contained
%% herein confidential and shall protect the same in whole or in
%% part from disclosure and dissemination to third parties.
%%
%% Disclosure and disseminations to the receivers employees shall
%% only be made on a strict need to know basis.
%%

-hrl_name('rfc4005_nas.hrl').


%%% -------------------------------------------------------
%%% Message records:
%%% -------------------------------------------------------

-record(rfc4005_nas_AAR,
	{'Session-Id', 'Auth-Application-Id', 'Origin-Host',
	 'Origin-Realm', 'Destination-Realm',
	 'Auth-Request-Type', 'Destination-Host' = [],
	 'NAS-Identifier' = [], 'NAS-IP-Address' = [],
	 'NAS-IPv6-Address' = [], 'NAS-Port' = [],
	 'NAS-Port-Id' = [], 'NAS-Port-Type' = [],
	 'Origin-AAA-Protocol' = [], 'Origin-State-Id' = [],
	 'Port-Limit' = [], 'User-Name' = [],
	 'User-Password' = [], 'Service-Type' = [], 'State' = [],
	 'Authorization-Lifetime' = [], 'Auth-Grace-Period' = [],
	 'Auth-Session-State' = [], 'Callback-Number' = [],
	 'Called-Station-Id' = [], 'Calling-Station-Id' = [],
	 'Originating-Line-Info' = [], 'Connect-Info' = [],
	 'CHAP-Auth' = [], 'CHAP-Challenge' = [],
	 'Framed-Compression' = [], 'Framed-Interface-Id' = [],
	 'Framed-IP-Address' = [], 'Framed-IPv6-Prefix' = [],
	 'Framed-IP-Netmask' = [], 'Framed-MTU' = [],
	 'Framed-Protocol' = [], 'ARAP-Password' = [],
	 'ARAP-Security' = [], 'ARAP-Security-Data' = [],
	 'Login-IP-Host' = [], 'Login-IPv6-Host' = [],
	 'Login-LAT-Group' = [], 'Login-LAT-Node' = [],
	 'Login-LAT-Port' = [], 'Login-LAT-Service' = [],
	 'Tunneling' = [], 'Proxy-Info' = [],
	 'Route-Record' = [], 'AVP' = []}).

-record(rfc4005_nas_AAA,
	{'Session-Id', 'Auth-Application-Id',
	 'Auth-Request-Type', 'Result-Code', 'Origin-Host',
	 'Origin-Realm', 'User-Name' = [], 'Service-Type' = [],
	 'Class' = [], 'Configuration-Token' = [],
	 'Acct-Interim-Interval' = [], 'Error-Message' = [],
	 'Error-Reporting-Host' = [], 'Failed-AVP' = [],
	 'Idle-Timeout' = [], 'Authorization-Lifetime' = [],
	 'Auth-Grace-Period' = [], 'Auth-Session-State' = [],
	 'Re-Auth-Request-Type' = [],
	 'Multi-Round-Time-Out' = [], 'Session-Timeout' = [],
	 'State' = [], 'Reply-Message' = [],
	 'Origin-AAA-Protocol' = [], 'Origin-State-Id' = [],
	 'Filter-Id' = [], 'Password-Retry' = [],
	 'Port-Limit' = [], 'Prompt' = [],
	 'ARAP-Challenge-Response' = [], 'ARAP-Features' = [],
	 'ARAP-Security' = [], 'ARAP-Security-Data' = [],
	 'ARAP-Zone-Access' = [], 'Callback-Id' = [],
	 'Callback-Number' = [], 'Framed-AppleTalk-Link' = [],
	 'Framed-AppleTalk-Network' = [],
	 'Framed-AppleTalk-Zone' = [], 'Framed-Compression' = [],
	 'Framed-Interface-Id' = [], 'Framed-IP-Address' = [],
	 'Framed-IPv6-Prefix' = [], 'Framed-IPv6-Pool' = [],
	 'Framed-IPv6-Route' = [], 'Framed-IP-Netmask' = [],
	 'Framed-Route' = [], 'Framed-Pool' = [],
	 'Framed-IPX-Network' = [], 'Framed-MTU' = [],
	 'Framed-Protocol' = [], 'Framed-Routing' = [],
	 'Login-IP-Host' = [], 'Login-IPv6-Host' = [],
	 'Login-LAT-Group' = [], 'Login-LAT-Node' = [],
	 'Login-LAT-Port' = [], 'Login-LAT-Service' = [],
	 'Login-Service' = [], 'Login-TCP-Port' = [],
	 'NAS-Filter-Rule' = [], 'QoS-Filter-Rule' = [],
	 'Tunneling' = [], 'Redirect-Host' = [],
	 'Redirect-Host-Usage' = [],
	 'Redirect-Max-Cache-Time' = [], 'Proxy-Info' = [],
	 'AVP' = []}).

-record(rfc4005_nas_RAR,
	{'Session-Id', 'Origin-Host', 'Origin-Realm',
	 'Destination-Realm', 'Destination-Host',
	 'Auth-Application-Id', 'Re-Auth-Request-Type',
	 'User-Name' = [], 'Origin-AAA-Protocol' = [],
	 'Origin-State-Id' = [], 'NAS-Identifier' = [],
	 'NAS-IP-Address' = [], 'NAS-IPv6-Address' = [],
	 'NAS-Port' = [], 'NAS-Port-Id' = [],
	 'NAS-Port-Type' = [], 'Service-Type' = [],
	 'Framed-IP-Address' = [], 'Framed-IPv6-Prefix' = [],
	 'Framed-Interface-Id' = [], 'Called-Station-Id' = [],
	 'Calling-Station-Id' = [], 'Originating-Line-Info' = [],
	 'Acct-Session-Id' = [], 'Acct-Multi-Session-Id' = [],
	 'State' = [], 'Class' = [], 'Reply-Message' = [],
	 'Proxy-Info' = [], 'Route-Record' = [], 'AVP' = []}).

-record(rfc4005_nas_RAA,
	{'Session-Id', 'Result-Code', 'Origin-Host',
	 'Origin-Realm', 'User-Name' = [],
	 'Origin-AAA-Protocol' = [], 'Origin-State-Id' = [],
	 'Error-Message' = [], 'Error-Reporting-Host' = [],
	 'Failed-AVP' = [], 'Redirect-Host' = [],
	 'Redirect-Host-Usage' = [],
	 'Redirect-Max-Cache-Time' = [], 'Service-Type' = [],
	 'Configuration-Token' = [], 'Idle-Timeout' = [],
	 'Authorization-Lifetime' = [], 'Auth-Grace-Period' = [],
	 'Re-Auth-Request-Type' = [], 'State' = [], 'Class' = [],
	 'Reply-Message' = [], 'Prompt' = [], 'Proxy-Info' = [],
	 'AVP' = []}).

-record(rfc4005_nas_STR,
	{'Session-Id', 'Origin-Host', 'Origin-Realm',
	 'Destination-Realm', 'Auth-Application-Id',
	 'Termination-Cause', 'User-Name' = [],
	 'Destination-Host' = [], 'Class' = [],
	 'Origin-AAA-Protocol' = [], 'Origin-State-Id' = [],
	 'Proxy-Info' = [], 'Route-Record' = [], 'AVP' = []}).

-record(rfc4005_nas_STA,
	{'Session-Id', 'Result-Code', 'Origin-Host',
	 'Origin-Realm', 'User-Name' = [], 'Class' = [],
	 'Error-Message' = [], 'Error-Reporting-Host' = [],
	 'Failed-AVP' = [], 'Origin-AAA-Protocol' = [],
	 'Origin-State-Id' = [], 'Redirect-Host' = [],
	 'Redirect-Host-Usage' = [],
	 'Redirect-Max-Cache-Time' = [], 'Proxy-Info' = [],
	 'AVP' = []}).

-record(rfc4005_nas_ASR,
	{'Session-Id', 'Origin-Host', 'Origin-Realm',
	 'Destination-Realm', 'Destination-Host',
	 'Auth-Application-Id', 'User-Name' = [],
	 'Origin-AAA-Protocol' = [], 'Origin-State-Id' = [],
	 'NAS-Identifier' = [], 'NAS-IP-Address' = [],
	 'NAS-IPv6-Address' = [], 'NAS-Port' = [],
	 'NAS-Port-Id' = [], 'NAS-Port-Type' = [],
	 'Service-Type' = [], 'Framed-IP-Address' = [],
	 'Framed-IPv6-Prefix' = [], 'Framed-Interface-Id' = [],
	 'Called-Station-Id' = [], 'Calling-Station-Id' = [],
	 'Originating-Line-Info' = [], 'Acct-Session-Id' = [],
	 'Acct-Multi-Session-Id' = [], 'State' = [],
	 'Class' = [], 'Reply-Message' = [], 'Proxy-Info' = [],
	 'Route-Record' = [], 'AVP' = []}).

-record(rfc4005_nas_ASA,
	{'Session-Id', 'Result-Code', 'Origin-Host',
	 'Origin-Realm', 'User-Name' = [],
	 'Origin-AAA-Protocol' = [], 'Origin-State-Id' = [],
	 'State' = [], 'Error-Message' = [],
	 'Error-Reporting-Host' = [], 'Failed-AVP' = [],
	 'Redirect-Host' = [], 'Redirect-Host-Usage' = [],
	 'Redirect-Max-Cache-Time' = [], 'Proxy-Info' = [],
	 'AVP' = []}).

-record(rfc4005_nas_ACR,
	{'Session-Id', 'Origin-Host', 'Origin-Realm',
	 'Destination-Realm', 'Accounting-Record-Type',
	 'Accounting-Record-Number', 'Acct-Application-Id' = [],
	 'Vendor-Specific-Application-Id' = [], 'User-Name' = [],
	 'Accounting-Sub-Session-Id' = [],
	 'Acct-Session-Id' = [], 'Acct-Multi-Session-Id' = [],
	 'Origin-AAA-Protocol' = [], 'Origin-State-Id' = [],
	 'Destination-Host' = [], 'Event-Timestamp' = [],
	 'Acct-Delay-Time' = [], 'NAS-Identifier' = [],
	 'NAS-IP-Address' = [], 'NAS-IPv6-Address' = [],
	 'NAS-Port' = [], 'NAS-Port-Id' = [],
	 'NAS-Port-Type' = [], 'Class' = [], 'Service-Type' = [],
	 'Termination-Cause' = [],
	 'Accounting-Input-Octets' = [],
	 'Accounting-Input-Packets' = [],
	 'Accounting-Output-Octets' = [],
	 'Accounting-Output-Packets' = [], 'Acct-Authentic' = [],
	 'Accounting-Auth-Method' = [], 'Acct-Link-Count' = [],
	 'Acct-Session-Time' = [], 'Acct-Tunnel-Connection' = [],
	 'Acct-Tunnel-Packets-Lost' = [], 'Callback-Id' = [],
	 'Callback-Number' = [], 'Called-Station-Id' = [],
	 'Calling-Station-Id' = [], 'Connect-Info' = [],
	 'Originating-Line-Info' = [],
	 'Authorization-Lifetime' = [], 'Session-Timeout' = [],
	 'Idle-Timeout' = [], 'Port-Limit' = [],
	 'Accounting-Realtime-Required' = [],
	 'Acct-Interim-Interval' = [], 'Filter-Id' = [],
	 'NAS-Filter-Rule' = [], 'QoS-Filter-Rule' = [],
	 'Framed-AppleTalk-Link' = [],
	 'Framed-AppleTalk-Network' = [],
	 'Framed-AppleTalk-Zone' = [], 'Framed-Compression' = [],
	 'Framed-Interface-Id' = [], 'Framed-IP-Address' = [],
	 'Framed-IP-Netmask' = [], 'Framed-IPv6-Prefix' = [],
	 'Framed-IPv6-Pool' = [], 'Framed-IPv6-Route' = [],
	 'Framed-IPX-Network' = [], 'Framed-MTU' = [],
	 'Framed-Pool' = [], 'Framed-Protocol' = [],
	 'Framed-Route' = [], 'Framed-Routing' = [],
	 'Login-IP-Host' = [], 'Login-IPv6-Host' = [],
	 'Login-LAT-Group' = [], 'Login-LAT-Node' = [],
	 'Login-LAT-Port' = [], 'Login-LAT-Service' = [],
	 'Login-Service' = [], 'Login-TCP-Port' = [],
	 'Tunneling' = [], 'Proxy-Info' = [],
	 'Route-Record' = [], 'AVP' = []}).

-record(rfc4005_nas_ACA,
	{'Session-Id', 'Result-Code', 'Origin-Host',
	 'Origin-Realm', 'Accounting-Record-Type',
	 'Accounting-Record-Number', 'Acct-Application-Id' = [],
	 'Vendor-Specific-Application-Id' = [], 'User-Name' = [],
	 'Accounting-Sub-Session-Id' = [],
	 'Acct-Session-Id' = [], 'Acct-Multi-Session-Id' = [],
	 'Event-Timestamp' = [], 'Error-Message' = [],
	 'Error-Reporting-Host' = [], 'Failed-AVP' = [],
	 'Origin-AAA-Protocol' = [], 'Origin-State-Id' = [],
	 'NAS-Identifier' = [], 'NAS-IP-Address' = [],
	 'NAS-IPv6-Address' = [], 'NAS-Port' = [],
	 'NAS-Port-Id' = [], 'NAS-Port-Type' = [],
	 'Service-Type' = [], 'Termination-Cause' = [],
	 'Accounting-Realtime-Required' = [],
	 'Acct-Interim-Interval' = [], 'Class' = [],
	 'Proxy-Info' = [], 'Route-Record' = [], 'AVP' = []}).


%%% -------------------------------------------------------
%%% Grouped AVP records:
%%% -------------------------------------------------------

-record('rfc4005_nas_CHAP-Auth',
	{'CHAP-Algorithm', 'CHAP-Ident', 'CHAP-Response' = [],
	 'AVP' = []}).

-record(rfc4005_nas_Tunneling,
	{'Tunnel-Type', 'Tunnel-Medium-Type',
	 'Tunnel-Client-Endpoint', 'Tunnel-Server-Endpoint',
	 'Tunnel-Preference' = [], 'Tunnel-Client-Auth-Id' = [],
	 'Tunnel-Server-Auth-Id' = [],
	 'Tunnel-Assignment-Id' = [], 'Tunnel-Password' = [],
	 'Tunnel-Private-Group-Id' = []}).


%%% -------------------------------------------------------
%%% Grouped AVP records from diameter_gen_base_rfc6733:
%%% -------------------------------------------------------

-record('rfc4005_nas_Proxy-Info',
	{'Proxy-Host', 'Proxy-State', 'AVP' = []}).

-record('rfc4005_nas_Failed-AVP', {'AVP' = []}).

-record('rfc4005_nas_Experimental-Result',
	{'Vendor-Id', 'Experimental-Result-Code'}).

-record('rfc4005_nas_Vendor-Specific-Application-Id',
	{'Vendor-Id', 'Auth-Application-Id' = [],
	 'Acct-Application-Id' = []}).


%%% -------------------------------------------------------
%%% ENUM Macros:
%%% -------------------------------------------------------

-define('RFC4005_NAS_NAS-PORT-TYPE_ASYNC', 0).
-define('RFC4005_NAS_NAS-PORT-TYPE_SYNC', 1).
-define('RFC4005_NAS_NAS-PORT-TYPE_ISDN_SYNC', 2).
-define('RFC4005_NAS_NAS-PORT-TYPE_ISDN_ASYNC_V120', 3).
-define('RFC4005_NAS_NAS-PORT-TYPE_ISDN_ASYNC_V110', 4).
-define('RFC4005_NAS_NAS-PORT-TYPE_VIRTUAL', 5).
-define('RFC4005_NAS_NAS-PORT-TYPE_PIAFS', 6).
-define('RFC4005_NAS_NAS-PORT-TYPE_HDLC_CLEAR_CHANNEL', 7).
-define('RFC4005_NAS_NAS-PORT-TYPE_X25', 8).
-define('RFC4005_NAS_NAS-PORT-TYPE_X75', 9).
-define('RFC4005_NAS_NAS-PORT-TYPE_G3FAX', 10).
-define('RFC4005_NAS_NAS-PORT-TYPE_SDSL', 11).
-define('RFC4005_NAS_NAS-PORT-TYPE_ADSL-CAP', 12).
-define('RFC4005_NAS_NAS-PORT-TYPE_ADSL-DMT', 13).
-define('RFC4005_NAS_NAS-PORT-TYPE_IDSL', 14).
-define('RFC4005_NAS_NAS-PORT-TYPE_ETHERNET', 15).
-define('RFC4005_NAS_NAS-PORT-TYPE_XDSL', 16).
-define('RFC4005_NAS_NAS-PORT-TYPE_CABLE', 17).
-define('RFC4005_NAS_NAS-PORT-TYPE_WIRELESS_OTHER', 18).
-define('RFC4005_NAS_NAS-PORT-TYPE_WIRELESS_802.11', 19).
-define('RFC4005_NAS_NAS-PORT-TYPE_TOKEN-RING', 20).
-define('RFC4005_NAS_NAS-PORT-TYPE_FDDI', 21).
-define('RFC4005_NAS_NAS-PORT-TYPE_WIRELESS_CDMA2000', 22).
-define('RFC4005_NAS_NAS-PORT-TYPE_WIRELESS_UMTS', 23).
-define('RFC4005_NAS_NAS-PORT-TYPE_WIRELESS_1X-EV', 24).
-define('RFC4005_NAS_NAS-PORT-TYPE_IAPP', 25).
-define('RFC4005_NAS_PROMPT_NO_ECHO', 0).
-define('RFC4005_NAS_PROMPT_ECHO', 1).
-define('RFC4005_NAS_CHAP-ALGORITHM_WITH_MD5', 5).
-define('RFC4005_NAS_SERVICE-TYPE_LOGIN', 1).
-define('RFC4005_NAS_SERVICE-TYPE_FRAMED', 2).
-define('RFC4005_NAS_SERVICE-TYPE_CALLBACK_LOGIN', 3).
-define('RFC4005_NAS_SERVICE-TYPE_CALLBACK_FRAMED', 4).
-define('RFC4005_NAS_SERVICE-TYPE_OUTBOUND', 5).
-define('RFC4005_NAS_SERVICE-TYPE_ADMINISTRATIVE', 6).
-define('RFC4005_NAS_SERVICE-TYPE_NAS_PROMPT', 7).
-define('RFC4005_NAS_SERVICE-TYPE_AUTHENTICATE_ONLY', 8).
-define('RFC4005_NAS_SERVICE-TYPE_CALLBACK_NAS_PROMPT', 9).
-define('RFC4005_NAS_SERVICE-TYPE_CALL_CHECK', 10).
-define('RFC4005_NAS_SERVICE-TYPE_CALLBACK_ADMINISTRATIVE', 11).
-define('RFC4005_NAS_SERVICE-TYPE_VOICE', 12).
-define('RFC4005_NAS_SERVICE-TYPE_FAX', 13).
-define('RFC4005_NAS_SERVICE-TYPE_MODEM_RELAY', 14).
-define('RFC4005_NAS_SERVICE-TYPE_IAPP-REGISTER', 15).
-define('RFC4005_NAS_SERVICE-TYPE_IAPP-AP-CHECK', 16).
-define('RFC4005_NAS_SERVICE-TYPE_AUTHORIZE_ONLY', 17).
-define('RFC4005_NAS_FRAMED-PROTOCOL_PPP', 1).
-define('RFC4005_NAS_FRAMED-PROTOCOL_SLIP', 2).
-define('RFC4005_NAS_FRAMED-PROTOCOL_ARAP', 3).
-define('RFC4005_NAS_FRAMED-PROTOCOL_GANDALF', 4).
-define('RFC4005_NAS_FRAMED-PROTOCOL_XYLOGICS', 5).
-define('RFC4005_NAS_FRAMED-PROTOCOL_X75', 6).
-define('RFC4005_NAS_FRAMED-ROUTING_NONE', 0).
-define('RFC4005_NAS_FRAMED-ROUTING_SEND', 1).
-define('RFC4005_NAS_FRAMED-ROUTING_LISTEN', 2).
-define('RFC4005_NAS_FRAMED-ROUTING_SEND_AND_LISTEN', 3).
-define('RFC4005_NAS_FRAMED-COMPRESSION_NONE', 0).
-define('RFC4005_NAS_FRAMED-COMPRESSION_VJ', 1).
-define('RFC4005_NAS_FRAMED-COMPRESSION_IPX', 2).
-define('RFC4005_NAS_FRAMED-COMPRESSION_STAC-LZS', 3).
-define('RFC4005_NAS_ARAP-ZONE-ACCESS_DEFAULT', 1).
-define('RFC4005_NAS_ARAP-ZONE-ACCESS_FILTER_INCLUSIVELY', 2).
-define('RFC4005_NAS_ARAP-ZONE-ACCESS_FILTER_EXCLUSIVELY', 4).
-define('RFC4005_NAS_LOGIN-SERVICE_TELNET', 0).
-define('RFC4005_NAS_LOGIN-SERVICE_RLOGIN', 1).
-define('RFC4005_NAS_LOGIN-SERVICE_TCP_CLEAR', 2).
-define('RFC4005_NAS_LOGIN-SERVICE_PORTMASTER', 3).
-define('RFC4005_NAS_LOGIN-SERVICE_LAT', 4).
-define('RFC4005_NAS_LOGIN-SERVICE_X25-PAD', 5).
-define('RFC4005_NAS_LOGIN-SERVICE_X25-T3POS', 6).
-define('RFC4005_NAS_LOGIN-SERVICE_TCP_CLEAR_QUIET', 8).
-define('RFC4005_NAS_TUNNEL-TYPE_PPTP', 1).
-define('RFC4005_NAS_TUNNEL-TYPE_L2F', 2).
-define('RFC4005_NAS_TUNNEL-TYPE_L2TP', 3).
-define('RFC4005_NAS_TUNNEL-TYPE_ATMP', 4).
-define('RFC4005_NAS_TUNNEL-TYPE_VTP', 5).
-define('RFC4005_NAS_TUNNEL-TYPE_AH', 6).
-define('RFC4005_NAS_TUNNEL-TYPE_IP-IP', 7).
-define('RFC4005_NAS_TUNNEL-TYPE_MIN-IP-IP', 8).
-define('RFC4005_NAS_TUNNEL-TYPE_ESP', 9).
-define('RFC4005_NAS_TUNNEL-TYPE_GRE', 10).
-define('RFC4005_NAS_TUNNEL-TYPE_DVS', 11).
-define('RFC4005_NAS_TUNNEL-TYPE_IP-IN-IP', 12).
-define('RFC4005_NAS_TUNNEL-TYPE_VLAN', 13).
-define('RFC4005_NAS_TUNNEL-MEDIUM-TYPE_IPV4', 1).
-define('RFC4005_NAS_TUNNEL-MEDIUM-TYPE_IPV6', 2).
-define('RFC4005_NAS_TUNNEL-MEDIUM-TYPE_NSAP', 3).
-define('RFC4005_NAS_TUNNEL-MEDIUM-TYPE_HDLC', 4).
-define('RFC4005_NAS_TUNNEL-MEDIUM-TYPE_BBN_1822', 5).
-define('RFC4005_NAS_TUNNEL-MEDIUM-TYPE_802', 6).
-define('RFC4005_NAS_TUNNEL-MEDIUM-TYPE_E163', 7).
-define('RFC4005_NAS_TUNNEL-MEDIUM-TYPE_E164', 8).
-define('RFC4005_NAS_TUNNEL-MEDIUM-TYPE_F69', 9).
-define('RFC4005_NAS_TUNNEL-MEDIUM-TYPE_X121', 10).
-define('RFC4005_NAS_TUNNEL-MEDIUM-TYPE_IPX', 11).
-define('RFC4005_NAS_TUNNEL-MEDIUM-TYPE_APPLETALK', 12).
-define('RFC4005_NAS_TUNNEL-MEDIUM-TYPE_DECNET_IV', 13).
-define('RFC4005_NAS_TUNNEL-MEDIUM-TYPE_BANYAN_VINES', 14).
-define('RFC4005_NAS_TUNNEL-MEDIUM-TYPE_E164_NSAP', 15).
-define('RFC4005_NAS_ACCT-AUTHENTIC_RADIUS', 1).
-define('RFC4005_NAS_ACCT-AUTHENTIC_LOCAL', 2).
-define('RFC4005_NAS_ACCT-AUTHENTIC_REMOTE', 3).
-define('RFC4005_NAS_ACCT-AUTHENTIC_DIAMETER', 4).
-define('RFC4005_NAS_ACCOUNTING-AUTH-METHOD_PAP', 1).
-define('RFC4005_NAS_ACCOUNTING-AUTH-METHOD_CHAP', 2).
-define('RFC4005_NAS_ACCOUNTING-AUTH-METHOD_MS-CHAP-1', 3).
-define('RFC4005_NAS_ACCOUNTING-AUTH-METHOD_MS-CHAP-2', 4).
-define('RFC4005_NAS_ACCOUNTING-AUTH-METHOD_EAP', 5).
-define('RFC4005_NAS_ACCOUNTING-AUTH-METHOD_NONE', 7).
-define('RFC4005_NAS_TERMINATION-CAUSE_USER_REQUEST', 11).
-define('RFC4005_NAS_TERMINATION-CAUSE_LOST_CARRIER', 12).
-define('RFC4005_NAS_TERMINATION-CAUSE_LOST_SERVICE', 13).
-define('RFC4005_NAS_TERMINATION-CAUSE_IDLE_TIMEOUT', 14).
-define('RFC4005_NAS_TERMINATION-CAUSE_SESSION_TIMEOUT', 15).
-define('RFC4005_NAS_TERMINATION-CAUSE_ADMIN_RESET', 16).
-define('RFC4005_NAS_TERMINATION-CAUSE_ADMIN_REBOOT', 17).
-define('RFC4005_NAS_TERMINATION-CAUSE_PORT_ERROR', 18).
-define('RFC4005_NAS_TERMINATION-CAUSE_NAS_ERROR', 19).
-define('RFC4005_NAS_TERMINATION-CAUSE_NAS_REQUEST', 20).
-define('RFC4005_NAS_TERMINATION-CAUSE_NAS_REBOOT', 21).
-define('RFC4005_NAS_TERMINATION-CAUSE_PORT_UNNEEDED', 22).
-define('RFC4005_NAS_TERMINATION-CAUSE_PORT_PREEMPTED', 23).
-define('RFC4005_NAS_TERMINATION-CAUSE_PORT_SUSPENDED', 24).
-define('RFC4005_NAS_TERMINATION-CAUSE_SERVICE_UNAVAILABLE', 25).
-define('RFC4005_NAS_TERMINATION-CAUSE_CALLBACK', 26).
-define('RFC4005_NAS_TERMINATION-CAUSE_USER_ERROR', 27).
-define('RFC4005_NAS_TERMINATION-CAUSE_HOST_REQUEST', 28).
-define('RFC4005_NAS_TERMINATION-CAUSE_SUPPLICANT_RESTART', 29).
-define('RFC4005_NAS_TERMINATION-CAUSE_REAUTHORIZATION_FAILURE', 30).
-define('RFC4005_NAS_TERMINATION-CAUSE_PORT_REINIT', 31).
-define('RFC4005_NAS_TERMINATION-CAUSE_PORT_DISABLED', 32).



%%% -------------------------------------------------------
%%% ENUM Macros from diameter_gen_base_rfc6733:
%%% -------------------------------------------------------

-ifndef('RFC4005_NAS_DISCONNECT-CAUSE_REBOOTING').
-define('RFC4005_NAS_DISCONNECT-CAUSE_REBOOTING', 0).
-endif.
-ifndef('RFC4005_NAS_DISCONNECT-CAUSE_BUSY').
-define('RFC4005_NAS_DISCONNECT-CAUSE_BUSY', 1).
-endif.
-ifndef('RFC4005_NAS_DISCONNECT-CAUSE_DO_NOT_WANT_TO_TALK_TO_YOU').
-define('RFC4005_NAS_DISCONNECT-CAUSE_DO_NOT_WANT_TO_TALK_TO_YOU', 2).
-endif.
-ifndef('RFC4005_NAS_REDIRECT-HOST-USAGE_DONT_CACHE').
-define('RFC4005_NAS_REDIRECT-HOST-USAGE_DONT_CACHE', 0).
-endif.
-ifndef('RFC4005_NAS_REDIRECT-HOST-USAGE_ALL_SESSION').
-define('RFC4005_NAS_REDIRECT-HOST-USAGE_ALL_SESSION', 1).
-endif.
-ifndef('RFC4005_NAS_REDIRECT-HOST-USAGE_ALL_REALM').
-define('RFC4005_NAS_REDIRECT-HOST-USAGE_ALL_REALM', 2).
-endif.
-ifndef('RFC4005_NAS_REDIRECT-HOST-USAGE_REALM_AND_APPLICATION').
-define('RFC4005_NAS_REDIRECT-HOST-USAGE_REALM_AND_APPLICATION', 3).
-endif.
-ifndef('RFC4005_NAS_REDIRECT-HOST-USAGE_ALL_APPLICATION').
-define('RFC4005_NAS_REDIRECT-HOST-USAGE_ALL_APPLICATION', 4).
-endif.
-ifndef('RFC4005_NAS_REDIRECT-HOST-USAGE_ALL_HOST').
-define('RFC4005_NAS_REDIRECT-HOST-USAGE_ALL_HOST', 5).
-endif.
-ifndef('RFC4005_NAS_REDIRECT-HOST-USAGE_ALL_USER').
-define('RFC4005_NAS_REDIRECT-HOST-USAGE_ALL_USER', 6).
-endif.
-ifndef('RFC4005_NAS_AUTH-REQUEST-TYPE_AUTHENTICATE_ONLY').
-define('RFC4005_NAS_AUTH-REQUEST-TYPE_AUTHENTICATE_ONLY', 1).
-endif.
-ifndef('RFC4005_NAS_AUTH-REQUEST-TYPE_AUTHORIZE_ONLY').
-define('RFC4005_NAS_AUTH-REQUEST-TYPE_AUTHORIZE_ONLY', 2).
-endif.
-ifndef('RFC4005_NAS_AUTH-REQUEST-TYPE_AUTHORIZE_AUTHENTICATE').
-define('RFC4005_NAS_AUTH-REQUEST-TYPE_AUTHORIZE_AUTHENTICATE', 3).
-endif.
-ifndef('RFC4005_NAS_AUTH-SESSION-STATE_STATE_MAINTAINED').
-define('RFC4005_NAS_AUTH-SESSION-STATE_STATE_MAINTAINED', 0).
-endif.
-ifndef('RFC4005_NAS_AUTH-SESSION-STATE_NO_STATE_MAINTAINED').
-define('RFC4005_NAS_AUTH-SESSION-STATE_NO_STATE_MAINTAINED', 1).
-endif.
-ifndef('RFC4005_NAS_RE-AUTH-REQUEST-TYPE_AUTHORIZE_ONLY').
-define('RFC4005_NAS_RE-AUTH-REQUEST-TYPE_AUTHORIZE_ONLY', 0).
-endif.
-ifndef('RFC4005_NAS_RE-AUTH-REQUEST-TYPE_AUTHORIZE_AUTHENTICATE').
-define('RFC4005_NAS_RE-AUTH-REQUEST-TYPE_AUTHORIZE_AUTHENTICATE', 1).
-endif.
-ifndef('RFC4005_NAS_TERMINATION-CAUSE_LOGOUT').
-define('RFC4005_NAS_TERMINATION-CAUSE_LOGOUT', 1).
-endif.
-ifndef('RFC4005_NAS_TERMINATION-CAUSE_SERVICE_NOT_PROVIDED').
-define('RFC4005_NAS_TERMINATION-CAUSE_SERVICE_NOT_PROVIDED', 2).
-endif.
-ifndef('RFC4005_NAS_TERMINATION-CAUSE_BAD_ANSWER').
-define('RFC4005_NAS_TERMINATION-CAUSE_BAD_ANSWER', 3).
-endif.
-ifndef('RFC4005_NAS_TERMINATION-CAUSE_ADMINISTRATIVE').
-define('RFC4005_NAS_TERMINATION-CAUSE_ADMINISTRATIVE', 4).
-endif.
-ifndef('RFC4005_NAS_TERMINATION-CAUSE_LINK_BROKEN').
-define('RFC4005_NAS_TERMINATION-CAUSE_LINK_BROKEN', 5).
-endif.
-ifndef('RFC4005_NAS_TERMINATION-CAUSE_AUTH_EXPIRED').
-define('RFC4005_NAS_TERMINATION-CAUSE_AUTH_EXPIRED', 6).
-endif.
-ifndef('RFC4005_NAS_TERMINATION-CAUSE_USER_MOVED').
-define('RFC4005_NAS_TERMINATION-CAUSE_USER_MOVED', 7).
-endif.
-ifndef('RFC4005_NAS_TERMINATION-CAUSE_SESSION_TIMEOUT').
-define('RFC4005_NAS_TERMINATION-CAUSE_SESSION_TIMEOUT', 8).
-endif.
-ifndef('RFC4005_NAS_SESSION-SERVER-FAILOVER_REFUSE_SERVICE').
-define('RFC4005_NAS_SESSION-SERVER-FAILOVER_REFUSE_SERVICE', 0).
-endif.
-ifndef('RFC4005_NAS_SESSION-SERVER-FAILOVER_TRY_AGAIN').
-define('RFC4005_NAS_SESSION-SERVER-FAILOVER_TRY_AGAIN', 1).
-endif.
-ifndef('RFC4005_NAS_SESSION-SERVER-FAILOVER_ALLOW_SERVICE').
-define('RFC4005_NAS_SESSION-SERVER-FAILOVER_ALLOW_SERVICE', 2).
-endif.
-ifndef('RFC4005_NAS_SESSION-SERVER-FAILOVER_TRY_AGAIN_ALLOW_SERVICE').
-define('RFC4005_NAS_SESSION-SERVER-FAILOVER_TRY_AGAIN_ALLOW_SERVICE', 3).
-endif.
-ifndef('RFC4005_NAS_ACCOUNTING-RECORD-TYPE_EVENT_RECORD').
-define('RFC4005_NAS_ACCOUNTING-RECORD-TYPE_EVENT_RECORD', 1).
-endif.
-ifndef('RFC4005_NAS_ACCOUNTING-RECORD-TYPE_START_RECORD').
-define('RFC4005_NAS_ACCOUNTING-RECORD-TYPE_START_RECORD', 2).
-endif.
-ifndef('RFC4005_NAS_ACCOUNTING-RECORD-TYPE_INTERIM_RECORD').
-define('RFC4005_NAS_ACCOUNTING-RECORD-TYPE_INTERIM_RECORD', 3).
-endif.
-ifndef('RFC4005_NAS_ACCOUNTING-RECORD-TYPE_STOP_RECORD').
-define('RFC4005_NAS_ACCOUNTING-RECORD-TYPE_STOP_RECORD', 4).
-endif.
-ifndef('RFC4005_NAS_ACCOUNTING-REALTIME-REQUIRED_DELIVER_AND_GRANT').
-define('RFC4005_NAS_ACCOUNTING-REALTIME-REQUIRED_DELIVER_AND_GRANT', 1).
-endif.
-ifndef('RFC4005_NAS_ACCOUNTING-REALTIME-REQUIRED_GRANT_AND_STORE').
-define('RFC4005_NAS_ACCOUNTING-REALTIME-REQUIRED_GRANT_AND_STORE', 2).
-endif.
-ifndef('RFC4005_NAS_ACCOUNTING-REALTIME-REQUIRED_GRANT_AND_LOSE').
-define('RFC4005_NAS_ACCOUNTING-REALTIME-REQUIRED_GRANT_AND_LOSE', 3).
-endif.

