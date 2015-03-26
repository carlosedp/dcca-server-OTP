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

-hrl_name('rfc4006_cc_Gy.hrl').


%%% -------------------------------------------------------
%%% Message records:
%%% -------------------------------------------------------

-record(rfc4006_cc_Gy_CCR,
	{'Session-Id', 'Origin-Host', 'Origin-Realm',
	 'Destination-Realm', 'Auth-Application-Id',
	 'Service-Context-Id', 'CC-Request-Type',
	 'CC-Request-Number', 'Destination-Host' = [],
	 'User-Name' = [], 'Origin-State-Id' = [],
	 'Event-Timestamp' = [], 'Subscription-Id' = [],
	 'Termination-Cause' = [],
	 'Multiple-Services-Indicator' = [],
	 'Multiple-Services-Credit-Control' = [],
	 'Framed-IP-Address' = [], 'Framed-IPv6-Prefix' = [],
	 'Called-Station-Id' = [], '3GPP-SGSN-IP-Address' = [],
	 '3GPP-GGSN-IP-Address' = [], '3GPP-Charging-Id' = [],
	 '3GPP-GPRS-Neg-QoS-Profile' = [],
	 '3GPP-Charging-Characteristics' = [],
	 '3GPP-PDP-Type' = [], '3GPP-SGSN-MCC-MNC' = [],
	 '3GPP-NSAPI' = [], '3GPP-Session-Stop-Indicator' = [],
	 '3GPP-Selection-Mode' = [], '3GPP-RAT-Type' = [],
	 '3GPP-User-Location-Info' = [],
	 '3GPP-MS-Time-Zone' = [], '3GPP-IMSI-MCC-MNC' = [],
	 'Rulebase-ID' = [], 'Session-Start-Indicator' = [],
	 'Proxy-Info' = [], 'Service-Information' = [],
	 'AVP' = []}).

-record(rfc4006_cc_Gy_CCA,
	{'Session-Id', 'Result-Code', 'Origin-Host',
	 'Origin-Realm', 'Auth-Application-Id',
	 'CC-Request-Type', 'CC-Request-Number',
	 'User-Name' = [], 'CC-Session-Failover' = [],
	 'Origin-State-Id' = [], 'Event-Timestamp' = [],
	 'Multiple-Services-Credit-Control' = [],
	 'Cost-Information' = [], 'Low-Balance-Indication' = [],
	 'Remaining-Balance' = [],
	 'Credit-Control-Failure-Handling' = [],
	 'Direct-Debiting-Failure-Handling' = [],
	 'Redirect-Host' = [], 'Redirect-Host-Usage' = [],
	 'Redirect-Max-Cache-Time' = [], 'Proxy-Info' = [],
	 'Route-Record' = [], 'Failed-AVP' = [],
	 'Service-Information' = [], 'AVP' = []}).


%%% -------------------------------------------------------
%%% Grouped AVP records:
%%% -------------------------------------------------------

-record('rfc4006_cc_Gy_Cost-Information',
	{'Unit-Value', 'Currency-Code', 'Cost-Unit' = []}).

-record('rfc4006_cc_Gy_Unit-Value',
	{'Value-Digits', 'Exponent' = []}).

-record('rfc4006_cc_Gy_Multiple-Services-Credit-Control',
	{'Requested-Service-Unit' = [],
	 'Used-Service-Unit' = [], 'Granted-Service-Unit' = [],
	 'Service-Identifier' = [], 'Rating-Group' = [],
	 'Time-of-First-Usage' = [], 'Time-of-Last-Usage' = [],
	 'Reporting-Reason' = [], 'Nokia-URI' = [],
	 'Trigger-Type' = [], 'Trigger' = [],
	 'User-Equipment-Info' = [],
	 'Service-Parameter-Info' = [], 'Framed-IP-Address' = [],
	 'Framed-IPv6-Prefix' = [], 'Validity-Time' = [],
	 'Result-Code' = [], 'Final-Unit-Indication' = [],
	 'Tariff-Change-Usage' = [], 'G-S-U-Pool-Reference' = [],
	 'AVP' = []}).

-record('rfc4006_cc_Gy_Granted-Service-Unit',
	{'Tariff-Time-Change' = [], 'CC-Time' = [],
	 'CC-Input-Octets' = [], 'CC-Output-Octets' = [],
	 'CC-Total-Octets' = [],
	 'CC-Service-Specific-Units' = [], 'AVP' = []}).

-record('rfc4006_cc_Gy_Requested-Service-Unit',
	{'CC-Time' = [], 'CC-Total-Octets' = [],
	 'CC-Service-Specific-Units' = [],
	 'CC-Input-Octets' = [], 'CC-Output-Octets' = [],
	 'CC-Money' = [], 'AVP' = []}).

-record('rfc4006_cc_Gy_Used-Service-Unit',
	{'Tariff-Change-Usage' = [], 'CC-Time' = [],
	 'CC-Input-Octets' = [], 'CC-Output-Octets' = [],
	 'CC-Total-Octets' = [], 'Reporting-Reason' = [],
	 'AVP' = []}).

-record('rfc4006_cc_Gy_CC-Money',
	{'Unit-Value', 'Currency-Code' = []}).

-record('rfc4006_cc_Gy_G-S-U-Pool-Reference',
	{'G-S-U-Pool-Identifier', 'CC-Unit-Type',
	 'Unit-Value'}).

-record('rfc4006_cc_Gy_Final-Unit-Indication',
	{'Final-Unit-Action', 'Restriction-Filter-Rule' = [],
	 'Filter-Id' = [], 'Redirect-Server' = []}).

-record('rfc4006_cc_Gy_Redirect-Server',
	{'Redirect-Address-Type', 'Redirect-Server-Address'}).

-record('rfc4006_cc_Gy_Service-Parameter-Info',
	{'Service-Parameter-Type', 'Service-Parameter-Value'}).

-record('rfc4006_cc_Gy_Subscription-Id',
	{'Subscription-Id-Type', 'Subscription-Id-Data'}).

-record('rfc4006_cc_Gy_User-Equipment-Info',
	{'User-Equipment-Info-Type',
	 'User-Equipment-Info-Value'}).

-record('rfc4006_cc_Gy_Service-Information',
	{'PS-Information' = []}).

-record('rfc4006_cc_Gy_PS-Information',
	{'PDN-Connection-ID' = [], 'PDP-Address' = [],
	 'Called-Station-Id' = [], '3GPP-IMSI-MCC-MNC' = [],
	 'GGSN-Address' = [], 'SGSN-Address' = [],
	 '3GPP-Charging-Id' = [],
	 '3GPP-GPRS-Neg-QoS-Profile' = [],
	 '3GPP-Charging-Characteristics' = [],
	 '3GPP-PDP-Type' = [], '3GPP-SGSN-MCC-MNC' = [],
	 '3GPP-GGSN-MCC-MNC' = [], 'CG-Address' = [],
	 '3GPP-NSAPI' = [], '3GPP-Session-Stop-Indicator' = [],
	 '3GPP-Selection-Mode' = [], '3GPP-RAT-Type' = [],
	 '3GPP-User-Location-Info' = [],
	 '3GPP-MS-Time-Zone' = [],
	 'Charging-Rule-Base-Name' = [], 'Filter-Id' = []}).

-record('rfc4006_cc_Gy_Remaining-Balance',
	{'Unit-Value', 'Currency-Code'}).

-record(rfc4006_cc_Gy_Trigger, {'Trigger-Type'}).


%%% -------------------------------------------------------
%%% Grouped AVP records from diameter_gen_base_rfc6733:
%%% -------------------------------------------------------

-record('rfc4006_cc_Gy_Proxy-Info',
	{'Proxy-Host', 'Proxy-State', 'AVP' = []}).

-record('rfc4006_cc_Gy_Failed-AVP', {'AVP' = []}).

-record('rfc4006_cc_Gy_Experimental-Result',
	{'Vendor-Id', 'Experimental-Result-Code'}).

-record('rfc4006_cc_Gy_Vendor-Specific-Application-Id',
	{'Vendor-Id', 'Auth-Application-Id' = [],
	 'Acct-Application-Id' = []}).


%%% -------------------------------------------------------
%%% ENUM Macros:
%%% -------------------------------------------------------

-define('RFC4006_CC_GY_CC-REQUEST-TYPE_INITIAL_REQUEST', 1).
-define('RFC4006_CC_GY_CC-REQUEST-TYPE_UPDATE_REQUEST', 2).
-define('RFC4006_CC_GY_CC-REQUEST-TYPE_TERMINATION_REQUEST', 3).
-define('RFC4006_CC_GY_CC-REQUEST-TYPE_EVENT_REQUEST', 4).
-define('RFC4006_CC_GY_CC-SESSION-FAILOVER_NOT_SUPPORTED', 0).
-define('RFC4006_CC_GY_CC-SESSION-FAILOVER_SUPPORTED', 1).
-define('RFC4006_CC_GY_CHECK-BALANCE-RESULT_ENOUGH_CREDIT', 0).
-define('RFC4006_CC_GY_CHECK-BALANCE-RESULT_NO_CREDIT', 1).
-define('RFC4006_CC_GY_CREDIT-CONTROL_AUTHORIZATION', 0).
-define('RFC4006_CC_GY_CREDIT-CONTROL_RE_AUTHORIZATION', 1).
-define('RFC4006_CC_GY_CREDIT-CONTROL-FAILURE-HANDLING_TERMINATE', 0).
-define('RFC4006_CC_GY_CREDIT-CONTROL-FAILURE-HANDLING_CONTINUE', 1).
-define('RFC4006_CC_GY_CREDIT-CONTROL-FAILURE-HANDLING_RETRY_AND_TERMINATE', 2).
-define('RFC4006_CC_GY_DIRECT-DEBITING-FAILURE-HANDLING_TERMINATE_OR_BUFFER', 0).
-define('RFC4006_CC_GY_DIRECT-DEBITING-FAILURE-HANDLING_CONTINUE', 1).
-define('RFC4006_CC_GY_TARIFF-CHANGE-USAGE_UNIT_BEFORE_TARIFF_CHANGE', 0).
-define('RFC4006_CC_GY_TARIFF-CHANGE-USAGE_UNIT_AFTER_TARIFF_CHANGE', 1).
-define('RFC4006_CC_GY_TARIFF-CHANGE-USAGE_UNIT_INDETERMINATE', 2).
-define('RFC4006_CC_GY_CC-UNIT-TYPE_TIME', 0).
-define('RFC4006_CC_GY_CC-UNIT-TYPE_MONEY', 1).
-define('RFC4006_CC_GY_CC-UNIT-TYPE_TOTAL-OCTETS', 2).
-define('RFC4006_CC_GY_CC-UNIT-TYPE_INPUT-OCTETS', 3).
-define('RFC4006_CC_GY_CC-UNIT-TYPE_OUTPUT-OCTETS', 4).
-define('RFC4006_CC_GY_CC-UNIT-TYPE_SERVICE-SPECIFIC-UNITS', 5).
-define('RFC4006_CC_GY_FINAL-UNIT-ACTION_TERMINATE', 0).
-define('RFC4006_CC_GY_FINAL-UNIT-ACTION_REDIRECT', 1).
-define('RFC4006_CC_GY_FINAL-UNIT-ACTION_RESTRICT_ACCESS', 2).
-define('RFC4006_CC_GY_REDIRECT-ADDRESS-TYPE_IPV4', 0).
-define('RFC4006_CC_GY_REDIRECT-ADDRESS-TYPE_IPV6', 1).
-define('RFC4006_CC_GY_REDIRECT-ADDRESS-TYPE_URL', 2).
-define('RFC4006_CC_GY_REDIRECT-ADDRESS-TYPE_SIP_URI', 3).
-define('RFC4006_CC_GY_MULTIPLE-SERVICES-INDICATOR_NOT_SUPPORTED', 0).
-define('RFC4006_CC_GY_MULTIPLE-SERVICES-INDICATOR_SUPPORTED', 1).
-define('RFC4006_CC_GY_REQUESTED-ACTION_DIRECT_DEBITING', 0).
-define('RFC4006_CC_GY_REQUESTED-ACTION_REFUND_ACCOUNT', 1).
-define('RFC4006_CC_GY_REQUESTED-ACTION_CHECK_BALANCE', 2).
-define('RFC4006_CC_GY_REQUESTED-ACTION_PRICE_ENQUIRY', 3).
-define('RFC4006_CC_GY_SUBSCRIPTION-ID-TYPE_END_USER_E164', 0).
-define('RFC4006_CC_GY_SUBSCRIPTION-ID-TYPE_END_USER_IMSI', 1).
-define('RFC4006_CC_GY_SUBSCRIPTION-ID-TYPE_END_USER_SIP_URI', 2).
-define('RFC4006_CC_GY_SUBSCRIPTION-ID-TYPE_END_USER_NAI', 3).
-define('RFC4006_CC_GY_SUBSCRIPTION-ID-TYPE_END_USER_PRIVATE', 4).
-define('RFC4006_CC_GY_USER-EQUIPMENT-INFO-TYPE_IMEISV', 0).
-define('RFC4006_CC_GY_USER-EQUIPMENT-INFO-TYPE_MAC', 1).
-define('RFC4006_CC_GY_USER-EQUIPMENT-INFO-TYPE_EUI64', 2).
-define('RFC4006_CC_GY_USER-EQUIPMENT-INFO-TYPE_MODIFIED_EUI64', 3).
-define('RFC4006_CC_GY_REPORTING-REASON_THRESHOLD', 0).
-define('RFC4006_CC_GY_REPORTING-REASON_QHT', 1).
-define('RFC4006_CC_GY_REPORTING-REASON_FINAL', 2).
-define('RFC4006_CC_GY_REPORTING-REASON_QUOTA_EXAUSTED', 3).
-define('RFC4006_CC_GY_REPORTING-REASON_VALIDITY_TIME', 4).
-define('RFC4006_CC_GY_REPORTING-REASON_OTHER_QUOTA_TYPE', 5).
-define('RFC4006_CC_GY_REPORTING-REASON_RATING_CONDITION_CHANGE', 6).
-define('RFC4006_CC_GY_REPORTING-REASON_FORCED_REAUTHORIZATION', 7).
-define('RFC4006_CC_GY_REPORTING-REASON_POOL_EXHAUSTED', 8).
-define('RFC4006_CC_GY_AOC-REQUEST-TYPE_AOC_NOT_REQUESTE', 0).
-define('RFC4006_CC_GY_AOC-REQUEST-TYPE_AOC_FULL', 1).
-define('RFC4006_CC_GY_AOC-REQUEST-TYPE_AOC_COST_ONLY', 2).
-define('RFC4006_CC_GY_AOC-REQUEST-TYPE_AOC_TARIFF_ONLY', 3).
-define('RFC4006_CC_GY_LOW-BALANCE-INDICATION_NOT-APPLICABLE', 0).
-define('RFC4006_CC_GY_LOW-BALANCE-INDICATION_YES', 1).
-define('RFC4006_CC_GY_TRIGGER-TYPE_CHANGE_IN_SGSN_IP_ADDRESS', 1).
-define('RFC4006_CC_GY_TRIGGER-TYPE_CHANGEINQOS_ANY', 2).
-define('RFC4006_CC_GY_TRIGGER-TYPE_CHANGEINRAT', 4).



%%% -------------------------------------------------------
%%% DEFINE Macros:
%%% -------------------------------------------------------

-define('RFC4006_CC_GY_RESULT-CODE_END_USER_SERVICE_DENIED', 4010).
-define('RFC4006_CC_GY_RESULT-CODE_CREDIT_CONTROL_NOT_APPLICABLE', 4011).
-define('RFC4006_CC_GY_RESULT-CODE_CREDIT_LIMIT_REACHED', 4012).
-define('RFC4006_CC_GY_RESULT-CODE_USER_UNKNOWN', 5030).
-define('RFC4006_CC_GY_RESULT-CODE_RATING_FAILED', 5031).



%%% -------------------------------------------------------
%%% ENUM Macros from diameter_gen_base_rfc6733:
%%% -------------------------------------------------------

-ifndef('RFC4006_CC_GY_DISCONNECT-CAUSE_REBOOTING').
-define('RFC4006_CC_GY_DISCONNECT-CAUSE_REBOOTING', 0).
-endif.
-ifndef('RFC4006_CC_GY_DISCONNECT-CAUSE_BUSY').
-define('RFC4006_CC_GY_DISCONNECT-CAUSE_BUSY', 1).
-endif.
-ifndef('RFC4006_CC_GY_DISCONNECT-CAUSE_DO_NOT_WANT_TO_TALK_TO_YOU').
-define('RFC4006_CC_GY_DISCONNECT-CAUSE_DO_NOT_WANT_TO_TALK_TO_YOU', 2).
-endif.
-ifndef('RFC4006_CC_GY_REDIRECT-HOST-USAGE_DONT_CACHE').
-define('RFC4006_CC_GY_REDIRECT-HOST-USAGE_DONT_CACHE', 0).
-endif.
-ifndef('RFC4006_CC_GY_REDIRECT-HOST-USAGE_ALL_SESSION').
-define('RFC4006_CC_GY_REDIRECT-HOST-USAGE_ALL_SESSION', 1).
-endif.
-ifndef('RFC4006_CC_GY_REDIRECT-HOST-USAGE_ALL_REALM').
-define('RFC4006_CC_GY_REDIRECT-HOST-USAGE_ALL_REALM', 2).
-endif.
-ifndef('RFC4006_CC_GY_REDIRECT-HOST-USAGE_REALM_AND_APPLICATION').
-define('RFC4006_CC_GY_REDIRECT-HOST-USAGE_REALM_AND_APPLICATION', 3).
-endif.
-ifndef('RFC4006_CC_GY_REDIRECT-HOST-USAGE_ALL_APPLICATION').
-define('RFC4006_CC_GY_REDIRECT-HOST-USAGE_ALL_APPLICATION', 4).
-endif.
-ifndef('RFC4006_CC_GY_REDIRECT-HOST-USAGE_ALL_HOST').
-define('RFC4006_CC_GY_REDIRECT-HOST-USAGE_ALL_HOST', 5).
-endif.
-ifndef('RFC4006_CC_GY_REDIRECT-HOST-USAGE_ALL_USER').
-define('RFC4006_CC_GY_REDIRECT-HOST-USAGE_ALL_USER', 6).
-endif.
-ifndef('RFC4006_CC_GY_AUTH-REQUEST-TYPE_AUTHENTICATE_ONLY').
-define('RFC4006_CC_GY_AUTH-REQUEST-TYPE_AUTHENTICATE_ONLY', 1).
-endif.
-ifndef('RFC4006_CC_GY_AUTH-REQUEST-TYPE_AUTHORIZE_ONLY').
-define('RFC4006_CC_GY_AUTH-REQUEST-TYPE_AUTHORIZE_ONLY', 2).
-endif.
-ifndef('RFC4006_CC_GY_AUTH-REQUEST-TYPE_AUTHORIZE_AUTHENTICATE').
-define('RFC4006_CC_GY_AUTH-REQUEST-TYPE_AUTHORIZE_AUTHENTICATE', 3).
-endif.
-ifndef('RFC4006_CC_GY_AUTH-SESSION-STATE_STATE_MAINTAINED').
-define('RFC4006_CC_GY_AUTH-SESSION-STATE_STATE_MAINTAINED', 0).
-endif.
-ifndef('RFC4006_CC_GY_AUTH-SESSION-STATE_NO_STATE_MAINTAINED').
-define('RFC4006_CC_GY_AUTH-SESSION-STATE_NO_STATE_MAINTAINED', 1).
-endif.
-ifndef('RFC4006_CC_GY_RE-AUTH-REQUEST-TYPE_AUTHORIZE_ONLY').
-define('RFC4006_CC_GY_RE-AUTH-REQUEST-TYPE_AUTHORIZE_ONLY', 0).
-endif.
-ifndef('RFC4006_CC_GY_RE-AUTH-REQUEST-TYPE_AUTHORIZE_AUTHENTICATE').
-define('RFC4006_CC_GY_RE-AUTH-REQUEST-TYPE_AUTHORIZE_AUTHENTICATE', 1).
-endif.
-ifndef('RFC4006_CC_GY_TERMINATION-CAUSE_LOGOUT').
-define('RFC4006_CC_GY_TERMINATION-CAUSE_LOGOUT', 1).
-endif.
-ifndef('RFC4006_CC_GY_TERMINATION-CAUSE_SERVICE_NOT_PROVIDED').
-define('RFC4006_CC_GY_TERMINATION-CAUSE_SERVICE_NOT_PROVIDED', 2).
-endif.
-ifndef('RFC4006_CC_GY_TERMINATION-CAUSE_BAD_ANSWER').
-define('RFC4006_CC_GY_TERMINATION-CAUSE_BAD_ANSWER', 3).
-endif.
-ifndef('RFC4006_CC_GY_TERMINATION-CAUSE_ADMINISTRATIVE').
-define('RFC4006_CC_GY_TERMINATION-CAUSE_ADMINISTRATIVE', 4).
-endif.
-ifndef('RFC4006_CC_GY_TERMINATION-CAUSE_LINK_BROKEN').
-define('RFC4006_CC_GY_TERMINATION-CAUSE_LINK_BROKEN', 5).
-endif.
-ifndef('RFC4006_CC_GY_TERMINATION-CAUSE_AUTH_EXPIRED').
-define('RFC4006_CC_GY_TERMINATION-CAUSE_AUTH_EXPIRED', 6).
-endif.
-ifndef('RFC4006_CC_GY_TERMINATION-CAUSE_USER_MOVED').
-define('RFC4006_CC_GY_TERMINATION-CAUSE_USER_MOVED', 7).
-endif.
-ifndef('RFC4006_CC_GY_TERMINATION-CAUSE_SESSION_TIMEOUT').
-define('RFC4006_CC_GY_TERMINATION-CAUSE_SESSION_TIMEOUT', 8).
-endif.
-ifndef('RFC4006_CC_GY_SESSION-SERVER-FAILOVER_REFUSE_SERVICE').
-define('RFC4006_CC_GY_SESSION-SERVER-FAILOVER_REFUSE_SERVICE', 0).
-endif.
-ifndef('RFC4006_CC_GY_SESSION-SERVER-FAILOVER_TRY_AGAIN').
-define('RFC4006_CC_GY_SESSION-SERVER-FAILOVER_TRY_AGAIN', 1).
-endif.
-ifndef('RFC4006_CC_GY_SESSION-SERVER-FAILOVER_ALLOW_SERVICE').
-define('RFC4006_CC_GY_SESSION-SERVER-FAILOVER_ALLOW_SERVICE', 2).
-endif.
-ifndef('RFC4006_CC_GY_SESSION-SERVER-FAILOVER_TRY_AGAIN_ALLOW_SERVICE').
-define('RFC4006_CC_GY_SESSION-SERVER-FAILOVER_TRY_AGAIN_ALLOW_SERVICE', 3).
-endif.
-ifndef('RFC4006_CC_GY_ACCOUNTING-RECORD-TYPE_EVENT_RECORD').
-define('RFC4006_CC_GY_ACCOUNTING-RECORD-TYPE_EVENT_RECORD', 1).
-endif.
-ifndef('RFC4006_CC_GY_ACCOUNTING-RECORD-TYPE_START_RECORD').
-define('RFC4006_CC_GY_ACCOUNTING-RECORD-TYPE_START_RECORD', 2).
-endif.
-ifndef('RFC4006_CC_GY_ACCOUNTING-RECORD-TYPE_INTERIM_RECORD').
-define('RFC4006_CC_GY_ACCOUNTING-RECORD-TYPE_INTERIM_RECORD', 3).
-endif.
-ifndef('RFC4006_CC_GY_ACCOUNTING-RECORD-TYPE_STOP_RECORD').
-define('RFC4006_CC_GY_ACCOUNTING-RECORD-TYPE_STOP_RECORD', 4).
-endif.
-ifndef('RFC4006_CC_GY_ACCOUNTING-REALTIME-REQUIRED_DELIVER_AND_GRANT').
-define('RFC4006_CC_GY_ACCOUNTING-REALTIME-REQUIRED_DELIVER_AND_GRANT', 1).
-endif.
-ifndef('RFC4006_CC_GY_ACCOUNTING-REALTIME-REQUIRED_GRANT_AND_STORE').
-define('RFC4006_CC_GY_ACCOUNTING-REALTIME-REQUIRED_GRANT_AND_STORE', 2).
-endif.
-ifndef('RFC4006_CC_GY_ACCOUNTING-REALTIME-REQUIRED_GRANT_AND_LOSE').
-define('RFC4006_CC_GY_ACCOUNTING-REALTIME-REQUIRED_GRANT_AND_LOSE', 3).
-endif.

